//
//  UpdatePasswordController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 21/08/2022.
//

import Foundation
import UIKit

class UpdatePasswordController: UIViewController, Storyboarded {
    
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
    }
    
    func updateUIWhenUpdatePassword(done: Bool, message: String) {
        showOrHideLoader(done: true)
        if done {
            showAlertWithOk(withTitle: "Success", withMessage: "You have updated your password") {
                self.dismiss(animated: true)
            }
        } else {
            showAlertWithOk(withTitle: "Error", withMessage: message) {
                self.resetTextField(self.viewOfNewPassword, self.newPasswordStaticLabel)
                self.resetTextField(self.viewOfConfirmPassword, self.confirmPasswordStaticLabel)
                self.resetTextField(self.viewOfOldPassword, self.oldPasswordStaticLabel)
                self.oldPasswordTextField.text = ""
                self.newPasswordTextField.text = ""
                self.confirmPasswordTextField.text = ""
            }
            showAlert(withTitle: "Error", withMessage: message)
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
                    break
                case .emptyPassword:
                    break
                case .emptyConfirmPassword:
                    break
                case .passwordTooShort:
                     break
                case .confirmPassword:
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
