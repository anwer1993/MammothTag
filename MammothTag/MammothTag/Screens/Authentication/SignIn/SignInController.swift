//
//  SignInController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 07/08/2022.
//

import Foundation
import UIKit
import AVFoundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import  AuthenticationServices
import FacebookLogin
import TwitterKit

class SignInController: UIViewController, Storyboarded {
    
    
    
    
    @IBOutlet weak var twitterBtn: UIButton!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var googleBtn: UIButton!
    @IBOutlet weak var appleeBtn: UIButton!
    @IBOutlet weak var orLbl: UILabel!
    @IBOutlet weak var signupWithLbl: UILabel!
    @IBOutlet weak var identityStack: UIStackView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var groupedImage: UIImageView!
    @IBOutlet weak var emailTextField: CustomTextField! {
        didSet {
            self.emailTextField.bind(callback: {self.signInViewModel.email.value = $0 })
        }
    }
    @IBOutlet weak var signInButton: GradientButton!
    @IBOutlet weak var passwordTextField: CustomTextField! {
        didSet {
            self.passwordTextField.bind(callback: {self.signInViewModel.password.value = $0 })
        }
    }
    @IBOutlet weak var forgotPasswordLbl: UILabel!
    @IBOutlet weak var createNewAccountLbl: UILabel!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var emailStaticLbl: UILabel!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var passwordStaticLabl: UILabel!
    
    var descStackTopConstrainteOriginal: CGFloat = 0.0
    var identityStackTopContrainteOriginal: CGFloat = 0.0
    
    var signInViewModel = SignInViewModel()
    var sourceController = 0
    var user_id = ""
    
    var  currentNonce: String = ""
    var twitter_session: TWTRSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let forgotPasswordTap = UITapGestureRecognizer(target: self, action: #selector(showForgotPasswordScreen(_:)))
        let registerTap = UITapGestureRecognizer(target: self, action: #selector(showRegistrationScreen(_:)))
        forgotPasswordLbl.addTagGesture(forgotPasswordTap)
        createNewAccountLbl.addTagGesture(registerTap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        appleeBtn.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        facebookBtn.addTarget(self, action: #selector(loginWithFb), for: .touchUpInside)
        twitterBtn.addTarget(self, action: #selector(loginWithTwitter), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        initializeView()
        linkViewModelToController()
        emailTextField.text = AccountManager.shared.email
        passwordTextField.text = AccountManager.shared.password
        signInViewModel.email.value = AccountManager.shared.email
        signInViewModel.password.value = AccountManager.shared.password
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        descStackTopConstrainteOriginal = descStackTopConstrainte.constant
        //        identityStackTopContrainteOriginal = identityStackTopContrainte.constant
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print(self.identityStack.frame.origin.y)
            print(self.identityStack.frame.height)
            print(keyboardSize.origin.y)
            if self.identityStack.frame.origin.y + self.identityStack.frame.height > keyboardSize.origin.y {
                print("passwordTextField hidden")
                //                descStackTopConstrainte.constant = 15
                //                identityStackTopContrainte.constant = 15
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        //        descStackTopConstrainte.constant = descStackTopConstrainteOriginal
        //        identityStackTopContrainte.constant = identityStackTopContrainteOriginal
    }
    
    func linkViewModelToController() {
        signInViewModel.bindViewModelDataToController = { [weak self] done, message in
            guard let this = self else {return}
            this.showOrHideLoader(done: true)
            this.updateUIWhenLogin(isLoggedIn: done, message: message)
        }
    }
    
    func initializeView() {
        setupLocalizedText()
        groupedImage.flipWhenRTL(image: UIImage(named: "Groupe 454")!)
        bgImage.flipWhenRTL(image: UIImage(named: "bg")!)
        initializeSignInBtn()
        appleeBtn.setupButton()
        googleBtn.setupButton()
        facebookBtn.setupButton()
        twitterBtn.setupButton()
        emailTextField.delegate = self
        emailTextField.keyboardType = .emailAddress
        passwordTextField.delegate = self
        viewEmail.customizeViewForContainTextField()
        emailTextField.setLeftPaddingPoints(0)
        emailStaticLbl.isHidden = true
        passwordStaticLabl.isHidden = true
        viewPassword.customizeViewForContainTextField()
        passwordTextField.SecureTextField(delegate: self)
    }
    
    func setupLocalizedText() {
        emailStaticLbl.text = "EMAIL".localized
        passwordStaticLabl.text = "PASSWORD".localized
        forgotPasswordLbl.text = "FORGOT_PASSWORD".localized
        createNewAccountLbl.text = "DONT_HAVE_ACCOUNT".localized
        passwordStaticLabl.text = "PASSWORD".localized
        signInButton.setTitle("SIGN_IN".localized, for: .normal)
        forgotPasswordLbl.font = UIFont(name: "Lato-Regular", size: 16)
        signupWithLbl.font = UIFont(name: "Lato-Bold", size: 16)
        orLbl.font = UIFont(name: "Lato-Bold", size: 16)
        signInButton.titleLabel?.font = UIFont(name: "Lato-SemiBold", size: 16)
        createNewAccountLbl.font = UIFont(name: "Lato-Regular", size: 16)
        forgotPasswordLbl.attributedText = forgotPasswordLbl.customizeTextLabel(stringToColor: "FORGOT_PASSWORD".localized, color: UIColor.black, isUnderline: true)
        createNewAccountLbl.attributedText = createNewAccountLbl.customizeTextLabel(stringToColor: "CREATE_NEW_ACCOUNT".localized, color: UIColor.tangerine, isUnderline: true)
        print(AppSettings().appLanguage == .AR)
        emailTextField.textAlignment = AppSettings().appLanguage == .AR ? .right : .left
        passwordTextField.textAlignment = AppSettings().appLanguage == .AR ? .right : .left
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    func toggleStaticLabelAppearence(_ textField: UITextField, isHidden: Bool) {
        if textField == emailTextField {
            emailStaticLbl.isHidden = !isHidden
            updateOtherTextFieldWhenToggle(otherTextField: passwordTextField, parentView: viewPassword, textFieldTitle: passwordStaticLabl, isHidden: isHidden)
            resetTextField(viewEmail, emailStaticLbl)
        } else {
            passwordStaticLabl.isHidden = isHidden
            updateOtherTextFieldWhenToggle(otherTextField: emailTextField, parentView: viewEmail, textFieldTitle: emailStaticLbl, isHidden: !isHidden)
            resetTextField(viewPassword, passwordStaticLabl)
        }
    }
    
    func updateOtherTextFieldWhenToggle(otherTextField: UITextField, parentView: UIView, textFieldTitle: UILabel, isHidden: Bool) {
        if otherTextField.isEmpty() {
            if parentView.layer.borderWidth != 2 {
                textFieldTitle.isHidden = isHidden
            } else {
                textFieldTitle.customizeLabelWhenError()
            }
        } else {
            textFieldTitle.isHidden = !isHidden
            updateViewAppearenceWhenValid(parentView, textFieldTitle)
        }
    }
    
    func setStaticLabelTextColor(_ color: UIColor, parentTextFieldParent: UITextField) {
        if parentTextFieldParent == emailTextField {
            emailStaticLbl.textColor = color
        } else {
            passwordStaticLabl.textColor = color
        }
    }
    
    func setTextFieldTitleApparence(_ textField: UITextField, isStartEditing: Bool) {
        if isStartEditing {
            toggleStaticLabelAppearence(textField, isHidden: textField == emailTextField)
        } else {
            emailStaticLbl.isHidden = textField.isEmpty()
        }
    }
    
    func updateTextFieldApparence(_ textField: UITextField, isStartEditing: Bool) {
        if isStartEditing {
            toggleStaticLabelAppearence(textField, isHidden: textField == emailTextField)
        } else {
            if textField == emailTextField {
                emailStaticLbl.isHidden = textField.isEmpty()
                if !textField.isEmpty() {
                    updateViewAppearenceWhenValid(viewEmail, emailStaticLbl)
                } else {
                    updateViewAppearenceWhenError(viewEmail, emailStaticLbl)
                }
            } else {
                passwordStaticLabl.isHidden = textField.isEmpty()
                if !textField.isEmpty() {
                    updateViewAppearenceWhenValid(viewPassword, passwordStaticLabl)
                } else {
                    updateViewAppearenceWhenError(viewPassword, passwordStaticLabl)
                }
            }
        }
    }
    
    func updateTextFieldWhenError(_ textField: UITextField) {
        if textField == emailTextField {
            updateViewAppearenceWhenError(viewEmail, emailStaticLbl)
        } else {
            updateViewAppearenceWhenError(viewPassword, passwordStaticLabl)
        }
    }
    
    func updateViewAppearenceWhenError(_ view: UIView, _ label: UILabel) {
        view.customizeViewContainTextFieldWhenError()
        label.customizeLabelWhenError()
        updateSignInButtonWhenError()
    }
    
    func updateSignInButtonWhenError() {
        signInButton.customizeButtonWhenError()
        signInButton.setTitle("RESET_FIELDS".localized, for: .normal)
    }
    
    func initializeSignInBtn() {
        signInButton.customizeButton()
        signInButton.setTitle("SIGN_IN".localized, for: .normal)
    }
    
    func updateViewAppearenceWhenValid(_ view: UIView, _ label: UILabel) {
        view.customizeViewContainTextFieldWhenValid()
        label.customizeLabelWhenValid()
    }
    
    func resetTextField(_ view: UIView, _ label: UILabel) {
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.borderWidth = 0
        label.textColor = UIColor.tangerine
        initializeSignInBtn()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func signUpWithGoogleBtnDidTapped(_ sender: Any) {
        signupWithGoogle()
    }
    
    
    
    @IBAction func signInButtonDidTapped(_ sender: UIButton) {
        if signInViewModel.isValid {
            updateViewAppearenceWhenValid(viewPassword, passwordStaticLabl)
            updateViewAppearenceWhenValid(viewEmail, emailStaticLbl)
            showOrHideLoader(done: false)
            signInViewModel.login()
        } else {
            signInViewModel.brokenRules.map({$0.propertyName}).forEach { Brokenrule in
                switch Brokenrule {
                case .email:
                    updateTextFieldWhenError(emailTextField)
                    break
                case .emptyPassword:
                    updateTextFieldWhenError(passwordTextField)
                    break
                default:
                    break
                }
            }
        }
    }
    
    func updateUIWhenLogin(isLoggedIn: Bool, message: String) {
        if isLoggedIn {
            if sourceController == 0 {
                Contstant.updateRootVC()
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let rootViewController = storyboard.instantiateViewController(withIdentifier: "ContactDetailsViewController") as? ContactDetailsViewController {
                    rootViewController.user_id = user_id
                    rootViewController.sourceController = 1
                    UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.rootViewController = rootViewController
                    UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.makeKeyAndVisible()
                }
            }
            AccountManager.shared.email = emailTextField.text
            AccountManager.shared.password = passwordTextField.text
            
        } else {
            self.showAlert(withTitle: "ERROR".localized, withMessage: message)
        }
    }
    
    @objc func showForgotPasswordScreen(_ sender: UITapGestureRecognizer? = nil) {
        Router.shared.push(with: self.navigationController, screen: .ForgotPassword, animated: true)
    }
    
    @objc func showRegistrationScreen(_ sender: UITapGestureRecognizer? = nil) {
        clearTextField(passwordTextField)
        clearTextField(emailTextField)
        Router.shared.push(with: self.navigationController, screen: .Register, animated: true)
    }
    
    func clearTextField(_ textField: UITextField) {
        textField.text = ""
        if textField == passwordTextField {
            viewPassword.layer.backgroundColor = UIColor.white.cgColor
            resetTextField(viewPassword, passwordStaticLabl)
        } else {
            viewEmail.layer.backgroundColor = UIColor.white.cgColor
            resetTextField(viewEmail, emailStaticLbl)
        }
    }
    
}


extension SignInController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateTextFieldApparence(textField, isStartEditing: false)
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
        updateTextFieldApparence(textField, isStartEditing: true)
        setStaticLabelTextColor(UIColor.tangerine, parentTextFieldParent: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
        updateTextFieldApparence(textField, isStartEditing: false)
    }
    
    
    
}
