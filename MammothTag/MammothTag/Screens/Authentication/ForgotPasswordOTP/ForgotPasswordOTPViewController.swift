//
//  ForgotPasswordOTPViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 28/09/2022.
//

import UIKit

class ForgotPasswordOTPViewController: UIViewController, Storyboarded {

    
    
    
    
    
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var mammothIcon: UIImageView!
    @IBOutlet weak var descriptionStackView: UIStackView!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var codeTextFieldStackView: UIStackView!
    @IBOutlet weak var codeTextFieldView: UIView!
    @IBOutlet weak var codeTextField: CustomTextField!
    @IBOutlet weak var sendBtn: GradientButton!
    
    var  code: String = ""
    var phone: String = ""
    var delegate: Navigatable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func setupLocalizedText() {
        screenTitle.text = "FORGOT_PASSWORD".localized
        descriptionLabel.text = "RESET_PASSWORD_DISC".localized
        codeTextField.placeholder = "PHONE".localized
        sendBtn.setTitle("SEND".localized, for: .normal)
    }
    
    func initView() {
        setupLocalizedText()
        backBtn.flipWhenRTL(image: UIImage(named: "Groupe 469")!)
        screenTitle.textColor = UIColor.chestnut
        descriptionLabel.textColor = UIColor.greyishBrown
        sendBtn.customizeButton()
        codeTextField.delegate = self
        codeTextFieldView.customizeViewForContainTextField()
        screenTitle.font = UIFont(name: "Lato-Black", size: 18)
        descriptionLabel.font = UIFont(name: "Lato-Regular", size: 18)
        sendBtn.titleLabel?.font = UIFont(name: "Lato-SemiBold", size: 16)
        codeTextField.font = UIFont(name: "Lato-Regular", size: 15)
        codeTextField.textAlignment = .center
    }
    

    @IBAction func sendBtnDidTapped(_ sender: Any) {
        if codeTextField.text?.isEmptyString == false {
            
        } else {
            
        }
    }
    
    @IBAction func backBtnDidTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension ForgotPasswordOTPViewController: UITextFieldDelegate {
    
    func resetTextField() {
        codeTextFieldView.layer.borderColor = UIColor.clear.cgColor
        codeTextFieldView.layer.borderWidth = 0
        sendBtn.customizeButton()
        sendBtn.setTitle("Send", for: .normal)
    }
    
    func toggleStaticLabelAppearence(_ textField: UITextField, isHidden: Bool) {
        if textField == codeTextField {
            resetTextField()
        }
    }
    
    func updateTextFieldApparence(_ textField: UITextField, isStartEditing: Bool) {
        if isStartEditing {
            toggleStaticLabelAppearence(textField, isHidden: true)
        } else {
            if textField == codeTextField {
                if !textField.isEmpty() {
                    codeTextFieldView.customizeViewContainTextFieldWhenValid()
                } else {
                    codeTextFieldView.customizeViewContainTextFieldWhenError()
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateTextFieldApparence(textField, isStartEditing: false)
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
        updateTextFieldApparence(textField, isStartEditing: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
        updateTextFieldApparence(textField, isStartEditing: false)
    }
    
}
