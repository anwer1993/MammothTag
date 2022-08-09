//
//  ForgotPasswordController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 09/08/2022.
//

import Foundation
import UIKit

class ForgotPasswordController: UIViewController, Storyboarded {
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forgotPassswordLbl: UILabel!
    @IBOutlet weak var forgotPasswordDescLbl: UILabel!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var emailTextField: CustomTextField! {
        didSet {
            self.emailTextField.bind(callback: {self.forgotPasswordViewModel.email.value = $0 })
        }
    }
    @IBOutlet weak var emailStaticLbl: UILabel!
    @IBOutlet weak var sendButton: GradientButton!
    
    var forgotPasswordViewModel = ForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        forgotPasswordViewModel.bindViewModelDataToController = { [weak self] done in
            guard let this = self else {return}
            this.updateUIWhenSendEmail(done: done)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initializeView() {
        forgotPassswordLbl.textColor = UIColor.chestnut
        forgotPasswordDescLbl.textColor = UIColor.greyishBrown
        sendButton.customizeButton()
        emailTextField.delegate = self
        viewEmail.customizeViewForContainTextField()
        emailStaticLbl.isHidden = true
    }
    
    func toggleStaticLabelAppearence(_ textField: UITextField, isHidden: Bool) {
        if textField == emailTextField {
            emailStaticLbl.isHidden = !isHidden
            resetTextField()
        }
    }
    
    func resetTextField() {
        viewEmail.layer.borderColor = UIColor.clear.cgColor
        viewEmail.layer.borderWidth = 0
        emailStaticLbl.textColor = UIColor.tangerine
        sendButton.customizeButton()
        sendButton.setTitle("Send", for: .normal)
    }
    
    func updateTextFieldApparence(_ textField: UITextField, isStartEditing: Bool) {
        if isStartEditing {
            toggleStaticLabelAppearence(textField, isHidden: true)
        } else {
            if textField == emailTextField {
                emailStaticLbl.isHidden = textField.isEmpty()
                if !textField.isEmpty() {
                    viewEmail.customizeViewContainTextFieldWhenValid()
                    emailStaticLbl.customizeLabelWhenValid()
                } else {
                    viewEmail.customizeViewContainTextFieldWhenError()
                    emailStaticLbl.customizeLabelWhenError()
                }
            }
        }
    }
    
    func updateViewAppearenceWhenError() {
        viewEmail.customizeViewContainTextFieldWhenError()
        emailStaticLbl.customizeLabelWhenError()
        sendButton.customizeButtonWhenError()
        sendButton.setTitle("Reset field", for: .normal)
    }
    
    func updateUIWhenSendEmail(done: Bool) {
        if done {
            print("request succeeded")
        } else {
            print("request failed")
        }
    }
    
    @IBAction func backButtonDidTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func sendButtonDidTapped(_ sender: Any) {
        if forgotPasswordViewModel.isValid {
            viewEmail.customizeViewContainTextFieldWhenValid()
            emailStaticLbl.customizeLabelWhenValid()
            forgotPasswordViewModel.sendEmail()
        } else {
            forgotPasswordViewModel.brokenRules.map({$0.propertyName}).forEach { Brokenrule in
                switch Brokenrule {
                case .email:
                    updateViewAppearenceWhenError()
                    break
                case .password:
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
        emailStaticLbl.textColor = UIColor.tangerine
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
        updateTextFieldApparence(textField, isStartEditing: false)
    }
    
    
    
}
