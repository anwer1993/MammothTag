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
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var sendButton: GradientButton!
   
    var viewModel = ChangeForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializeView()
    }
    
    func setupLocalizedText() {
        changePasswordLbl.text = "CHANGE_PASSWORD".localized
//        codeStaticLabel.text = "CODE".localized
        passwordStaticLabel.text = "PASSWORD".localized
        sendButton.setTitle("SEND".localized, for: .normal)
    }
    
    func initializeView() {
        setupLocalizedText()
        backButton.flipWhenRTL(image: UIImage(named: "Groupe 469")!)
        changePasswordLbl.textColor = UIColor.redBrown
        sendButton.customizeButton()
        passwordTextField.delegate = self
        passwordView.customizeViewForContainTextField()
//        codeView.customizeViewForContainTextField()
        passwordStaticLabel.isHidden = true
        passwordStaticLabel.textColor = .tangerine
//        codeStaticLabel.textColor = .tangerine
//        codeStaticLabel.isHidden = false
    }
    
    
    @IBAction func backButtonDidTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendButtonDidTapped(_ sender: Any) {
    }
    
}


extension ChangeForgotPassword: UITextFieldDelegate {
    
    func updateTextFieldApparence(_ textField: UITextField, isStartEditing: Bool) {
        if isStartEditing {
            toggleStaticLabelAppearence(textField, isHidden: true)
        } else {
            if textField == passwordTextField {
                passwordStaticLabel.isHidden = textField.isEmpty()
                if !textField.isEmpty() {
                    passwordView.customizeViewContainTextFieldWhenValid()
                    passwordStaticLabel.customizeLabelWhenValid()
                } else {
                    passwordView.customizeViewContainTextFieldWhenError()
                    passwordStaticLabel.customizeLabelWhenError()
                }
            }
        }
    }
    
    func toggleStaticLabelAppearence(_ textField: UITextField, isHidden: Bool) {
        if textField == passwordTextField {
            passwordStaticLabel.isHidden = !isHidden
            resetTextField()
        }
    }
    
    func resetTextField() {
        passwordView.layer.borderColor = UIColor.clear.cgColor
        passwordView.layer.borderWidth = 0
        passwordStaticLabel.textColor = UIColor.tangerine
        sendButton.customizeButton()
        sendButton.setTitle("Send", for: .normal)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateTextFieldApparence(textField, isStartEditing: false)
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
        updateTextFieldApparence(textField, isStartEditing: true)
        passwordStaticLabel.textColor = UIColor.tangerine
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
        updateTextFieldApparence(textField, isStartEditing: false)
    }
    
}
