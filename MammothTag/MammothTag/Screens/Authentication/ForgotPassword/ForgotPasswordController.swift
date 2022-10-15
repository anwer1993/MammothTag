//
//  ForgotPasswordController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 09/08/2022.
//

import Foundation
import UIKit
import CountryPickerView

class ForgotPasswordController: UIViewController, Storyboarded, Navigatable {
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forgotPassswordLbl: UILabel!
    @IBOutlet weak var forgotPasswordDescLbl: UILabel!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var emailTextField: CustomTextField! {
        didSet {
            self.emailTextField.bind(callback: {self.forgotPasswordViewModel.phone.value = $0 })
        }
    }
    @IBOutlet weak var sendButton: GradientButton!
    
    var forgotPasswordViewModel = ForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        forgotPasswordViewModel.bindViewModelDataToController = { [weak self] done, model, message in
            guard let this = self else {return}
            this.showOrHideLoader(done: true)
            this.updateUIWhenSendEmail(done: done, forgotPasswordModel: model, message: message)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupLocalizedText() {
        forgotPassswordLbl.text = "FORGOT_PASSWORD".localized
        forgotPasswordDescLbl.text = "RESET_PASSWORD_DISC".localized
        emailTextField.placeholder = "EMAIL".localized
        sendButton.setTitle("SEND".localized, for: .normal)
    }
    
    func initializeView() {
        setupLocalizedText()
        backButton.flipWhenRTL(image: UIImage(named: "Groupe 469")!)
        forgotPassswordLbl.textColor = UIColor.chestnut
        forgotPasswordDescLbl.textColor = UIColor.greyishBrown
        sendButton.customizeButton()
        emailTextField.delegate = self
        viewEmail.customizeViewForContainTextField()
        forgotPassswordLbl.font = UIFont(name: "Lato-Black", size: 18)
        forgotPasswordDescLbl.font = UIFont(name: "Lato-Regular", size: 18)
        sendButton.titleLabel?.font = UIFont(name: "Lato-SemiBold", size: 16)
        emailTextField.font = UIFont(name: "Lato-Regular", size: 15)
        emailTextField.textAlignment = AppSettings().appLanguage == .AR ? .right : .left
    }
    
    func toggleStaticLabelAppearence(_ textField: UITextField, isHidden: Bool) {
        if textField == emailTextField {
            resetTextField()
        }
    }
    
    func resetTextField() {
        viewEmail.layer.borderColor = UIColor.clear.cgColor
        viewEmail.layer.borderWidth = 0
        sendButton.customizeButton()
        sendButton.setTitle("Send", for: .normal)
    }
    
    func updateTextFieldApparence(_ textField: UITextField, isStartEditing: Bool) {
        if isStartEditing {
            toggleStaticLabelAppearence(textField, isHidden: true)
        } else {
            if textField == emailTextField {
                if !textField.isEmpty() {
                    viewEmail.customizeViewContainTextFieldWhenValid()
                } else {
                    viewEmail.customizeViewContainTextFieldWhenError()
                }
            }
        }
    }
    
    func updateViewAppearenceWhenError() {
        viewEmail.customizeViewContainTextFieldWhenError()
        sendButton.customizeButtonWhenError()
        sendButton.setTitle("Reset field", for: .normal)
    }
    
    func clearTextField() {
        emailTextField.text = ""
        viewEmail.layer.backgroundColor = UIColor.white.cgColor
        resetTextField()
    }
    
    func updateUIWhenSendEmail(done: Bool, forgotPasswordModel: ForgotPasswordModel?, message: String) {
        if done {
            if let forgotPasswordModel = forgotPasswordModel {
                clearTextField()
                Router.shared.push(with: self.navigationController, screen: .ForgotPasswordOTP(email: forgotPasswordModel.email!, delegate: self), animated: true)
            }
        } else {
            showAlert(withTitle: "ERROR".localized, withMessage: message)
        }
    }
    
    func backToPreviousViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButtonDidTapped(_ sender: Any) {
        backToPreviousViewController()
    }
    
    
    @IBAction func sendButtonDidTapped(_ sender: Any) {
        if forgotPasswordViewModel.isValid {
            viewEmail.customizeViewContainTextFieldWhenValid()
            showOrHideLoader(done: false)
            forgotPasswordViewModel.sendPhone()
        } else {
            forgotPasswordViewModel.brokenRules.map({$0.propertyName}).forEach { Brokenrule in
                switch Brokenrule {
                case .phone:
                    updateViewAppearenceWhenError()
                    break
                default:
                    break
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


extension ForgotPasswordController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateTextFieldApparence(textField, isStartEditing: false)
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
        updateTextFieldApparence(textField, isStartEditing: true)
//        emailStaticLbl.textColor = UIColor.tangerine
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
        updateTextFieldApparence(textField, isStartEditing: false)
    }
    
    
    
}
