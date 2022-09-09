//
//  UpdatePasswordController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 21/08/2022.
//

import Foundation
import UIKit

class UpdatePasswordController: UIViewController, Storyboarded {
    
    @IBOutlet weak var mamouthIcon: UIImageView!
    @IBOutlet weak var mamouthIconWidth: NSLayoutConstraint!
    @IBOutlet weak var mamouthIconHeight: NSLayoutConstraint!
    @IBOutlet weak var titleLblTopConstrainte: NSLayoutConstraint!
    @IBOutlet weak var passwordStackTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var passStack: UIStackView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var updatePasswordLabel: UILabel!
    @IBOutlet weak var viewOfOldPassword: UIView!
    @IBOutlet weak var oldPasswordStaticLabel: UILabel!
    @IBOutlet weak var oldPasswordTextField: CustomTextField!{
        didSet {
            self.oldPasswordTextField.bind(callback: {self.viewModel.oldPassword.value = $0 })
        }
    }
    @IBOutlet weak var viewOfNewPassword: UIView!
    @IBOutlet weak var newPasswordStaticLabel: UILabel!
    @IBOutlet weak var newPasswordTextField: CustomTextField!{
        didSet {
            self.newPasswordTextField.bind(callback: {self.viewModel.newPassword.value = $0 })
        }
    }
    @IBOutlet weak var viewOfConfirmPassword: UIView!
    @IBOutlet weak var confirmPasswordStaticLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: CustomTextField!{
        didSet {
            self.confirmPasswordTextField.bind(callback: {self.viewModel.confirmPassword.value = $0 })
        }
    }
    @IBOutlet weak var stackViewOfTextField: UIStackView!
    @IBOutlet weak var sendButton: GradientButton!
    
    var viewModel = UpdatePasswordViewModel()
    
    var mamouthIconWidthOriginal: CGFloat = 0.0
    var mamouthIconHeightOriginal: CGFloat = 0.0
    var titleLblTopConstrainteOriginal: CGFloat = 0.0
    var passwordStackTopConstraintOriginal: CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        viewModel.bindViewModelDataToController = {[weak self] done, message in
            guard let this = self else {
                return
            }
            this.updateUIWhenUpdatePassword(done: done, message: message)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mamouthIconWidthOriginal = mamouthIconWidth.constant
        mamouthIconHeightOriginal = mamouthIconHeight.constant
        titleLblTopConstrainteOriginal  = titleLblTopConstrainte.constant
        passwordStackTopConstraintOriginal = passwordStackTopConstraint.constant
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            print(keyboardSize.origin.y)
            if self.passStack.frame.origin.y + self.passStack.frame.height > keyboardSize.origin.y {
                print("passwordTextField hidden")
                mamouthIconWidth.constant = 80
                mamouthIconHeight.constant = 80
                titleLblTopConstrainte.constant = 15
                passwordStackTopConstraint.constant = 15
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        mamouthIconWidth.constant = mamouthIconWidthOriginal
        mamouthIconHeight.constant = mamouthIconHeightOriginal
        titleLblTopConstrainte.constant = titleLblTopConstrainteOriginal
        passwordStackTopConstraint.constant =  passwordStackTopConstraintOriginal
    }
    
    func setLocalizationText(){
        updatePasswordLabel.text = "CHANGE_PASSWORD".localized
        oldPasswordStaticLabel.text = "OLD_PASSWORD".localized
        newPasswordStaticLabel.text = "NEW_PASSWORD".localized
        confirmPasswordStaticLabel.text = "CONFIRM_PASSWORD".localized
        sendButton.setTitle("SEND".localized, for: .normal)
    }
    
    func setupStaticLabel(label: UILabel) {
        label.isHidden = true
        label.textColor = .tangerine
    }
    
    func initView() {
        updatePasswordLabel.textColor = .chestnut
        viewOfOldPassword.customizeViewForContainTextField()
        viewOfNewPassword.customizeViewForContainTextField()
        viewOfConfirmPassword.customizeViewForContainTextField()
        backButton.flipWhenRTL(image: UIImage(named: "Groupe 469")!)
        setLocalizationText()
        setupStaticLabel(label: oldPasswordStaticLabel)
        setupStaticLabel(label: newPasswordStaticLabel)
        setupStaticLabel(label: confirmPasswordStaticLabel)
        sendButton.layer.cornerRadius = 15
        viewOfOldPassword.layer.cornerRadius = 20.0
        viewOfNewPassword.layer.cornerRadius = 20.0
        viewOfConfirmPassword.layer.cornerRadius = 20.0
        sendButton.customizeButton()
        oldPasswordTextField.SecureTextField(delegate: self)
        newPasswordTextField.SecureTextField(delegate: self)
        confirmPasswordTextField.SecureTextField(delegate: self)
        updatePasswordLabel.font = UIFont(name: "Lato-Black", size: 18)
        updatePasswordLabel.textColor = .chestnut
        sendButton.titleLabel?.font = UIFont(name: "Lato-SemiBold", size: 16)
        sendButton.titleLabel?.textColor = .white
        oldPasswordTextField.font = UIFont(name: "Lato-Regular", size: 15)
        oldPasswordStaticLabel.font = UIFont(name: "Lato-Regular", size: 12)
        newPasswordTextField.font = UIFont(name: "Lato-Regular", size: 15)
        newPasswordStaticLabel.font = UIFont(name: "Lato-Regular", size: 12)
        confirmPasswordTextField.font = UIFont(name: "Lato-Regular", size: 15)
        confirmPasswordStaticLabel.font = UIFont(name: "Lato-Regular", size: 12)
        oldPasswordTextField.textAlignment = AppSettings().appLanguage == .AR ? .right : .left
        newPasswordTextField.textAlignment = AppSettings().appLanguage == .AR ? .right : .left
        confirmPasswordTextField.textAlignment = AppSettings().appLanguage == .AR ? .right : .left
    }
    
    func updateUIWhenUpdatePassword(done: Bool, message: String) {
        showOrHideLoader(done: true)
        if done {
            showAlertWithOk(withTitle: "SUCCESS".localized, withMessage: "UPDATE_PASSWORD".localized) {
                self.dismiss(animated: true)
            }
        } else {
            showAlertWithOk(withTitle: "ERROR".localized, withMessage: message) {
                self.resetTextField(self.viewOfNewPassword, self.newPasswordStaticLabel)
                self.resetTextField(self.viewOfConfirmPassword, self.confirmPasswordStaticLabel)
                self.resetTextField(self.viewOfOldPassword, self.oldPasswordStaticLabel)
                self.oldPasswordTextField.text = ""
                self.newPasswordTextField.text = ""
                self.confirmPasswordTextField.text = ""
            }
            showAlert(withTitle: "ERROR".localized, withMessage: message)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func backButtonDidTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func sendButtonDidTapped(_ sender: Any) {
        if viewModel.isValid {
            showOrHideLoader(done: false)
            viewModel.updatePassword()
        } else {
            viewModel.brokenRules.map({$0.propertyName}).forEach { Brokenrule in
                switch Brokenrule {
                case .emptyOldPassword:
                    showAlertWithOk(withTitle: "ERROR".localized, withMessage: "ENTER_PASSWORD".localized)
                    break
                case .emptyPassword:
                    showAlertWithOk(withTitle: "ERROR".localized, withMessage: "ENTER_NEW_PASSWORD".localized)
                    break
                case .emptyConfirmPassword:
                    showAlertWithOk(withTitle: "ERROR".localized, withMessage: "CONFIRM_PASSWORD".localized)
                    break
                case .passwordTooShort:
                    showAlertWithOk(withTitle: "ERROR".localized, withMessage: "PASSWORD_TOO_SHORT".localized)
                     break
                case .confirmPassword:
                    showAlertWithOk(withTitle: "ERROR".localized, withMessage: "PASSWORD_NOT_MATCH".localized)
                    break
                default:
                    break
                }
            }
        }
    }
    
}


extension UpdatePasswordController : UITextFieldDelegate {
    
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
    
    func updateViewAppearenceWhenValid(_ view: UIView, _ label: UILabel) {
        view.customizeViewContainTextFieldWhenValid()
        label.customizeLabelWhenValid()
    }
    
    func updateViewAppearenceWhenError(_ view: UIView, _ label: UILabel) {
        view.customizeViewContainTextFieldWhenError()
        label.customizeLabelWhenError()
        updateSignInButtonWhenError()
    }
    
    func updateSignInButtonWhenError() {
        sendButton.customizeButtonWhenError()
        sendButton.setTitle("RESET_FIELDS".localized, for: .normal)
    }
    
    func initializeSignInBtn() {
        sendButton.customizeButton()
        sendButton.setTitle("SEND".localized, for: .normal)
    }
    
    func resetTextField(_ view: UIView, _ label: UILabel) {
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.borderWidth = 0
        label.textColor = UIColor.tangerine
        initializeSignInBtn()
    }

    
    func updateUIWhenEndEditingTextField(_ textField: UITextField) {
        if textField == oldPasswordTextField {
            oldPasswordStaticLabel.isHidden = textField.isEmpty()
            if !textField.isEmpty() {
                updateViewAppearenceWhenValid(viewOfOldPassword, oldPasswordStaticLabel)
            } else {
                updateViewAppearenceWhenError(viewOfOldPassword, oldPasswordStaticLabel)
            }
        } else if textField == newPasswordTextField {
            newPasswordStaticLabel.isHidden = textField.isEmpty()
            if !textField.isEmpty() {
                updateViewAppearenceWhenValid(viewOfNewPassword, newPasswordStaticLabel)
            } else {
                updateViewAppearenceWhenError(viewOfNewPassword, newPasswordStaticLabel)
            }
        } else if textField == confirmPasswordTextField {
            confirmPasswordStaticLabel.isHidden = textField.isEmpty()
            if !textField.isEmpty() {
                updateViewAppearenceWhenValid(viewOfConfirmPassword, confirmPasswordStaticLabel)
            } else {
                updateViewAppearenceWhenError(viewOfConfirmPassword, confirmPasswordStaticLabel)
            }
        } 
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == oldPasswordTextField {
            oldPasswordStaticLabel.isHidden = false
            resetTextField(viewOfOldPassword, oldPasswordStaticLabel)
            updateOtherTextFieldWhenToggle(otherTextField: newPasswordTextField, parentView: viewOfNewPassword, textFieldTitle: newPasswordStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: confirmPasswordTextField, parentView: viewOfConfirmPassword, textFieldTitle: confirmPasswordStaticLabel, isHidden: true)
        } else if textField == newPasswordTextField {
            newPasswordStaticLabel.isHidden = false
            resetTextField(viewOfNewPassword, newPasswordStaticLabel)
            updateOtherTextFieldWhenToggle(otherTextField: oldPasswordTextField, parentView: viewOfOldPassword, textFieldTitle: oldPasswordStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: confirmPasswordTextField, parentView: viewOfConfirmPassword, textFieldTitle: confirmPasswordStaticLabel, isHidden: true)
        } else if textField == confirmPasswordTextField {
            confirmPasswordStaticLabel.isHidden = false
            resetTextField(viewOfConfirmPassword, confirmPasswordStaticLabel)
            updateOtherTextFieldWhenToggle(otherTextField: newPasswordTextField, parentView: viewOfNewPassword, textFieldTitle: newPasswordStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: oldPasswordTextField, parentView: viewOfOldPassword, textFieldTitle: oldPasswordStaticLabel, isHidden: true)
        }
        print("TextField did begin editing method called")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateUIWhenEndEditingTextField(textField)
        return true;
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateUIWhenEndEditingTextField(textField)
        print("TextField did end editing method called")
    }
    
}
