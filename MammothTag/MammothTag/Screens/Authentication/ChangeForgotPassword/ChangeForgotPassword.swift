//
//  ChangeForgotPassword.swift
//  MammothTag
//
//  Created by Anwar Hajji on 21/08/2022.
//

import Foundation
import UIKit

class ChangeForgotPassword: UIViewController, Storyboarded {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var changePasswordLbl: UILabel!
    @IBOutlet weak var inputStackView: UIStackView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordStaticLabel: UILabel!
    @IBOutlet weak var passwordTextField: CustomTextField!{
        didSet {
            self.passwordTextField.bind(callback: {self.viewModel.password.value = $0 })
        }
    }
    @IBOutlet weak var sendButton: GradientButton!
    @IBOutlet weak var confirmPasswordTextField: CustomTextField!{
        didSet {
            self.confirmPasswordTextField.bind(callback: {self.viewModel.confirmPassword.value = $0 })
        }
    }
    @IBOutlet weak var confirmPassword: UILabel!
    @IBOutlet weak var confirmPasswordView: UIView!
    
    var viewModel = ChangeForgotPasswordViewModel()
    var email: String?
    var code: String?
    var delegate: Navigatable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializeView()
        viewModel.bindViewModelDataToController = {[weak self] done, message in
            guard let this = self else {
                return
            }
            this.updateUIWhenUpdatePassword(done: done, message: message)
        }
    }
    
    func clearTextField(_ textField: UITextField) {
        textField.text = ""
        if textField == passwordTextField {
            passwordView.layer.backgroundColor = UIColor.white.cgColor
            resetTextField(passwordView, passwordStaticLabel)
        } else {
            confirmPasswordView.layer.backgroundColor = UIColor.white.cgColor
            resetTextField(confirmPasswordView, confirmPassword)
        }
    }
    
    func updateUIWhenUpdatePassword(done: Bool, message: String) {
        showOrHideLoader(done: true)
        if done {
            showAlertWithOk(withTitle: "SUCCESS".localized, withMessage: "UPDATE_PASSWORD".localized) {
                self.clearTextField(self.passwordTextField)
                self.clearTextField(self.confirmPasswordTextField)
                Contstant.updateRootVC(fromChangePassword: true)
            }
        } else {
            showAlertWithOk(withTitle: "ERROR".localized, withMessage: message)
        }
    }
    
    func setupLocalizedText() {
        changePasswordLbl.text = "CHANGE_PASSWORD".localized
        confirmPassword.text = "CONFIRM_PASSWORD".localized
        passwordStaticLabel.text = "PASSWORD".localized
        sendButton.setTitle("SEND".localized, for: .normal)
    }
    
    func initializeView() {
        setupLocalizedText()
        backButton.flipWhenRTL(image: UIImage(named: "Groupe 469")!)
        changePasswordLbl.textColor = UIColor.redBrown
        sendButton.customizeButton()
        passwordTextField.SecureTextField(delegate: self)
        confirmPasswordTextField.SecureTextField(delegate: self)
        passwordView.customizeViewForContainTextField()
        confirmPasswordView.customizeViewForContainTextField()
        passwordStaticLabel.isHidden = true
        passwordStaticLabel.textColor = .tangerine
        confirmPassword.textColor = .tangerine
        confirmPassword.isHidden = true
        changePasswordLbl.font = UIFont(name: "Lato-Black", size: 18)
        sendButton.titleLabel?.font = UIFont(name: "Lato-SemiBold", size: 16)
        passwordTextField.font = UIFont(name: "Lato-Regular", size: 15)
        passwordStaticLabel.font = UIFont(name: "Lato-Regular", size: 14)
        confirmPasswordTextField.font = UIFont(name: "Lato-Regular", size: 15)
        confirmPassword.font = UIFont(name: "Lato-Regular", size: 14)
        passwordTextField.textAlignment = AppSettings().appLanguage == .AR ? .right : .left
        confirmPassword.textAlignment = AppSettings().appLanguage == .AR ? .right : .left
    }
    
    @IBAction func backButtonDidTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendButtonDidTapped(_ sender: Any) {
        if viewModel.isValid {
            showOrHideLoader(done: false)
            viewModel.changePassword(code: code!, email: email!)
        } else {
            viewModel.brokenRules.map({$0.propertyName}).forEach { Brokenrule in
                switch Brokenrule {
                case .emptyPassword:
                    updateUIWhenEndEditingTextField(passwordTextField)
                    break
                case .emptyConfirmPassword:
                    updateUIWhenEndEditingTextField(confirmPasswordTextField)
                    break
                case .confirmPassword:
                    showAlertWithOk(withTitle: "ERROR".localized, withMessage: "PASSWORD_NOT_MATCH".localized)
                    break
                case .passwordTooShort:
                    showAlertWithOk(withTitle: "ERROR".localized, withMessage: "PASSWORD_TOO_SHORT".localized)
                    break
                default:
                    break
                }
            }
        }
    }
    
    func updateUIWhenEndEditingTextField(_ textField: UITextField) {
        if textField == passwordTextField {
            passwordStaticLabel.isHidden = textField.isEmpty()
            if !textField.isEmpty() {
                updateViewAppearenceWhenValid(passwordView, passwordStaticLabel)
            } else {
                updateViewAppearenceWhenError(passwordView, passwordStaticLabel)
            }
        } else if textField == confirmPasswordTextField {
            confirmPassword.isHidden = textField.isEmpty()
            if !textField.isEmpty() {
                updateViewAppearenceWhenValid(confirmPasswordView, confirmPassword)
            } else {
                updateViewAppearenceWhenError(confirmPasswordView, confirmPassword)
            }
        }
    }
    
    
}


extension ChangeForgotPassword: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateUIWhenEndEditingTextField(textField)
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
        if textField == passwordTextField {
            passwordStaticLabel.isHidden = false
            resetTextField(passwordView, passwordStaticLabel)
            updateOtherTextFieldWhenToggle(otherTextField: confirmPasswordTextField, parentView: confirmPasswordView, textFieldTitle: confirmPassword, isHidden: true)
        } else if textField == confirmPasswordTextField {
            confirmPassword.isHidden = false
            resetTextField(confirmPasswordView, confirmPassword)
            updateOtherTextFieldWhenToggle(otherTextField: passwordTextField, parentView: passwordView, textFieldTitle: passwordStaticLabel, isHidden: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
        updateUIWhenEndEditingTextField(textField)
    }
    
}
