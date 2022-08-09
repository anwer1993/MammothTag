//
//  SignInController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 07/08/2022.
//

import Foundation
import UIKit
import JVFloatLabeledTextField

class SignInController: UIViewController {
    
    
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var discLbl: UILabel!
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
    
    var signInViewModel = SignInViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializeView()
        linkViewModelToController()
    }
    
    func linkViewModelToController() {
        signInViewModel.bindViewModelDataToController = { [weak self] done in
            guard let this = self else {return}
             this.updateUIWhenLogin(isLoggedIn: done)
        }
    }
    
    func initializeView() {
        welcomeLbl.textColor = UIColor.chestnut
        discLbl.textColor = UIColor.greyishBrown
        initializeSignInBtn()
        forgotPasswordLbl.applyLineView(lineColor: UIColor.black)
        createNewAccountLbl.attributedText = createNewAccountLbl.customizeTextLabel(stringToColor: "Create a new account", color: UIColor.tangerine, isUnderline: true)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        viewEmail.customizeViewForContainTextField()
        emailTextField.setLeftPaddingPoints(0)
        emailStaticLbl.isHidden = true
        passwordStaticLabl.isHidden = true
        viewPassword.customizeViewForContainTextField()
        passwordTextField.enablePasswordToggle()
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
    }
    
    func initializeSignInBtn() {
        signInButton.customizeButton()
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
    
    @IBAction func signInButtonDidTapped(_ sender: UIButton) {
        if signInViewModel.isValid {
            updateViewAppearenceWhenValid(viewPassword, passwordStaticLabl)
            updateViewAppearenceWhenValid(viewEmail, emailStaticLbl)
            signInViewModel.signInModel = SignInModel(email: emailTextField.text!, password: passwordTextField.text!)
            signInViewModel.login()
        } else {
            signInViewModel.brokenRules.map({$0.propertyName}).forEach { Brokenrule in
                switch Brokenrule {
                case .email:
                    updateTextFieldWhenError(emailTextField)
                    break
                case .password:
                    updateTextFieldWhenError(passwordTextField)
                    break
                }
            }
        }
    }
    
    func updateUIWhenLogin(isLoggedIn: Bool) {
        if isLoggedIn {
            print("ISLoggedIn")
        } else {
            print("Loggin failed")
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
