//
//  UpdateProfileViewController.swift
//  MammothTag
//
//  Created by Anwar Hajji on 24/08/2022.
//

import Foundation
import UIKit
import Kingfisher


class UpdateProfileViewController : UIViewController, Storyboarded {
    
    
    @IBOutlet weak var viewProfilePic: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var newAccountLbl: UILabel!
    @IBOutlet weak var viewFirstName: UIView!
    @IBOutlet weak var firstNameStaticLbl: UILabel!
    @IBOutlet weak var firstNameTestField: CustomTextField! {
        didSet {
            self.firstNameTestField.bind(callback: {self.updateProfileViewModel.firstName.value = $0 })
        }
    }
    @IBOutlet weak var viewLastName: UIView!
    @IBOutlet weak var lastNameStaticLabel: UILabel!
    @IBOutlet weak var lastNameTextField: CustomTextField! {
        didSet {
            self.lastNameTextField.bind(callback: {self.updateProfileViewModel.LastName.value = $0 })
        }
    }
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailStaticLbl: UILabel!
    @IBOutlet weak var emailTextField: CustomTextField! {
        didSet {
            self.emailTextField.bind(callback: {self.updateProfileViewModel.email.value = $0 })
        }
    }
    @IBOutlet weak var dateOfBirthView: UIView!
    @IBOutlet weak var dateOfBirthStaticLbl: UILabel!
    @IBOutlet weak var dateOfBirthTextField: CustomTextField! {
        didSet {
            self.dateOfBirthTextField.bind(callback: {self.updateProfileViewModel.dateOfBirth.value = $0 })
        }
    }
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTextField: CustomTextField! {
        didSet {
            self.phoneTextField.bind(callback: {self.updateProfileViewModel.phone.value = $0 })
        }
    }
    @IBOutlet weak var phoneStaticLabel: UILabel!
    @IBOutlet weak var sendButton: GradientButton!
    
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var passwordStaticLabel: UILabel!
    @IBOutlet weak var passwordTextField: CustomTextField!{
        didSet {
            self.passwordTextField.bind(callback: {self.updateProfileViewModel.password.value = $0 })
        }
    }
    
    var updateProfileViewModel = UpdateProfileViewModel()
    var profile: ProfileModel?
    
    private lazy var datePicker: UIDatePicker = {
      let datePicker = UIDatePicker(frame: .zero)
      datePicker.datePickerMode = .date
      datePicker.timeZone = TimeZone.current
      return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        dateOfBirthTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        passwordTextField.isUserInteractionEnabled = false
        passwordTextField.text = AccountManager.shared.password
        updateProfileViewModel.password.value = AccountManager.shared.password
        passwordTextField.isSecureTextEntry  = true
        passwordStaticLabel.isHidden = false
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "yyyy-MM-dd"
          dateOfBirthTextField.text = dateFormatter.string(from: sender.date)
        updateProfileViewModel.dateOfBirth.value = dateOfBirthTextField.text
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateProfileViewModel.updateUIWhenRegister = {[weak self] done, message in
            guard let this = self else {
                return
            }
            this.showOrHideLoader(done: true)
            if done {
                this.navigationController?.popViewController(animated: true)
            } else {
                this.showAlert(withTitle: "Error", withMessage: message)
            }
        }
    }
    
    func setupLocalizedText() {
        newAccountLbl.text = "UPDATE_PROFILE".localized
        lastNameStaticLabel.text = "LAST_NAME".localized
        firstNameStaticLbl.text = "FIRST_NAME".localized
        dateOfBirthStaticLbl.text = "DATE_OF_BIRTH".localized
        phoneStaticLabel.text = "PHONE".localized
        emailStaticLbl.text = "EMAIL".localized
        passwordStaticLabel.text = "PASSWORD".localized
        passwordStaticLabel.textColor = .tangerine
//        passwordStaticLabel.isHidden = true
        sendButton.setTitle("SEND".localized, for: .normal)
    }
    
    func initializeView() {
        profilePicture.layer.cornerRadius = 50
        viewProfilePic.layer.cornerRadius = 50
        viewProfilePic.applySketchShadow(color: UIColor.black37, alpha: 1, x: 0, y: 5, blur: 20, spread: 0)
        setupLocalizedText()
        backButton.flipWhenRTL(image: UIImage(named: "Groupe 469")!)
        sendButton.customizeButton()
        hideStaticLAbel()
        setupViewsContainTextField()
        sendButton.layer.cornerRadius = 15
        sendButton.customizeButton()
        viewPassword.customizeViewForContainTextField()
        newAccountLbl.font = UIFont(name: "Lato-Black", size: 18)
        newAccountLbl.textColor = .chestnut
        sendButton.titleLabel?.font = UIFont(name: "Lato-SemiBold", size: 16)
        sendButton.titleLabel?.textColor = .white
        firstNameTestField.font = UIFont(name: "Lato-Regular", size: 15)
        firstNameStaticLbl.font = UIFont(name: "Lato-Regular", size: 12)
        lastNameTextField.font = UIFont(name: "Lato-Regular", size: 15)
        lastNameTextField.font = UIFont(name: "Lato-Regular", size: 12)
        emailTextField.font = UIFont(name: "Lato-Regular", size: 15)
        emailStaticLbl.font = UIFont(name: "Lato-Regular", size: 12)
        dateOfBirthTextField.font = UIFont(name: "Lato-Regular", size: 15)
        dateOfBirthStaticLbl.font = UIFont(name: "Lato-Regular", size: 12)
        phoneTextField.font = UIFont(name: "Lato-Regular", size: 15)
        phoneStaticLabel.font = UIFont(name: "Lato-Regular", size: 12)
        passwordTextField.font = UIFont(name: "Lato-Regular", size: 15)
        passwordStaticLabel.font = UIFont(name: "Lato-Regular", size: 12)

        if let profile = profile {
            firstNameTestField.text = profile.name
            lastNameTextField.text = profile.username
            emailTextField.text = profile.email
            dateOfBirthTextField.text = profile.birthday
            phoneTextField.text = profile.phone
            updateProfileViewModel.firstName.value = profile.name
            updateProfileViewModel.LastName.value = profile.username
            updateProfileViewModel.email.value = profile.email
            updateProfileViewModel.dateOfBirth.value = profile.birthday
            updateProfileViewModel.phone.value = profile.phone
            if let picture = profile.picture, picture.isEmptyString == false {
                let url = URL(string: picture)
                profilePicture.kf.setImage(with: url)
            } else {
                profilePicture.image = UIImage(named: "avatar")
            }
        }
        
        
    }
    
    func setupViewsContainTextField() {
        viewFirstName.layer.cornerRadius = 20.0
        viewLastName.layer.cornerRadius = 20.0
        emailView.layer.cornerRadius = 20.0
        dateOfBirthView.layer.cornerRadius = 20.0
        phoneView.layer.cornerRadius = 20.0
        viewFirstName.customizeViewForContainTextField()
        viewLastName.customizeViewForContainTextField()
        emailView.customizeViewForContainTextField()
        dateOfBirthView.customizeViewForContainTextField()
        phoneView.customizeViewForContainTextField()
    }
    
    func hideStaticLAbel() {
        firstNameTestField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        emailTextField.keyboardType = .emailAddress
        dateOfBirthTextField.delegate = self
        phoneTextField.delegate = self
        phoneTextField.keyboardType = .phonePad
        firstNameStaticLbl.textColor = .tangerine
        lastNameStaticLabel.textColor = .tangerine
        emailStaticLbl.textColor = .tangerine
        dateOfBirthStaticLbl.textColor = .tangerine
        phoneStaticLabel.textColor = .tangerine
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        if updateProfileViewModel.isValid {
            showOrHideLoader(done: false)
            updateProfileViewModel.updateUser()
        } else {
            updateProfileViewModel.brokenRules.map({$0.propertyName}).forEach { Brokenrule in
                switch Brokenrule {
                case .firstName:
                    updateUIWhenEndEditingTextField(firstNameTestField)
                    break
                case .lastName:
                    updateUIWhenEndEditingTextField(lastNameTextField)
                    break
                case .email:
                    updateUIWhenEndEditingTextField(emailTextField)
                    print("invalid email")
                    break
                case .dateOfBirth:
                    updateUIWhenEndEditingTextField(dateOfBirthTextField)
                    break
                case .phone:
                    updateUIWhenEndEditingTextField(phoneTextField)
                    break
                case .emptyPassword:
                    updateUIWhenEndEditingTextField(passwordTextField)
                    break
                case .passwordTooShort:
                    showAlert(withTitle: "Error", withMessage: "Passwords too short, please try another time")
                    break
                case .emptyConfirmPassword:
                    break
                case .confirmPassword:
                    break
                case .picture:
                    break
                case .emptyOldPassword:
                    break
                }
            }
        }
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}


extension UpdateProfileViewController: UITextFieldDelegate {
    
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
        if textField == firstNameTestField {
            firstNameStaticLbl.isHidden = textField.isEmpty()
            if !textField.isEmpty() {
                updateViewAppearenceWhenValid(viewFirstName, firstNameStaticLbl)
            } else {
                updateViewAppearenceWhenError(viewFirstName, firstNameStaticLbl)
            }
        } else if textField == lastNameTextField {
            lastNameStaticLabel.isHidden = textField.isEmpty()
            if !textField.isEmpty() {
                updateViewAppearenceWhenValid(viewLastName, lastNameStaticLabel)
            } else {
                updateViewAppearenceWhenError(viewLastName, lastNameStaticLabel)
            }
        } else if textField == emailTextField {
            emailStaticLbl.isHidden = textField.isEmpty()
            if !textField.isEmpty() {
                updateViewAppearenceWhenValid(emailView, emailStaticLbl)
            } else {
                updateViewAppearenceWhenError(emailView, emailStaticLbl)
            }
        } else if textField == dateOfBirthTextField {
            dateOfBirthStaticLbl.isHidden = textField.isEmpty()
            if !textField.isEmpty() {
                updateViewAppearenceWhenValid(dateOfBirthView, dateOfBirthStaticLbl)
            } else {
                updateViewAppearenceWhenError(dateOfBirthView, dateOfBirthStaticLbl)
            }
        } else if textField == phoneTextField {
            if !textField.isEmpty() {
                updateViewAppearenceWhenValid(phoneView, phoneStaticLabel)
            } else {
                updateViewAppearenceWhenError(phoneView, phoneStaticLabel)
            }
        } else if textField == passwordTextField {
            if !textField.isEmpty() {
                updateViewAppearenceWhenValid(viewPassword, passwordStaticLabel)
            } else {
                updateViewAppearenceWhenError(viewPassword, passwordStaticLabel)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateUIWhenEndEditingTextField(textField)
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == firstNameTestField {
            firstNameStaticLbl.isHidden = false
            resetTextField(viewFirstName, firstNameStaticLbl)
            updateOtherTextFieldWhenToggle(otherTextField: lastNameTextField, parentView: viewLastName, textFieldTitle: lastNameStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: emailTextField, parentView: emailView, textFieldTitle: emailStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: dateOfBirthTextField, parentView: dateOfBirthView, textFieldTitle: dateOfBirthStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: phoneTextField, parentView: phoneView, textFieldTitle: UILabel(), isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: passwordTextField, parentView: viewPassword, textFieldTitle: passwordStaticLabel, isHidden: true)
        } else if textField == lastNameTextField {
            lastNameStaticLabel.isHidden = false
            resetTextField(viewLastName, lastNameStaticLabel)
            updateOtherTextFieldWhenToggle(otherTextField: firstNameTestField, parentView: viewFirstName, textFieldTitle: firstNameStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: emailTextField, parentView: emailView, textFieldTitle: emailStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: dateOfBirthTextField, parentView: dateOfBirthView, textFieldTitle: dateOfBirthStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: phoneTextField, parentView: phoneView, textFieldTitle: UILabel(), isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: passwordTextField, parentView: viewPassword, textFieldTitle: passwordStaticLabel, isHidden: true)
        } else if textField == emailTextField {
            updateProfileViewModel.registerModel.email = textField.text ?? ""
            emailStaticLbl.isHidden = false
            resetTextField(emailView, emailStaticLbl)
            updateOtherTextFieldWhenToggle(otherTextField: firstNameTestField, parentView: viewFirstName, textFieldTitle: firstNameStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: lastNameTextField, parentView: viewLastName, textFieldTitle: lastNameStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: dateOfBirthTextField, parentView: dateOfBirthView, textFieldTitle: dateOfBirthStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: phoneTextField, parentView: phoneView, textFieldTitle: UILabel(), isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: passwordTextField, parentView: viewPassword, textFieldTitle: passwordStaticLabel, isHidden: true)
        } else if textField == dateOfBirthTextField {
            dateOfBirthStaticLbl.isHidden = false
            resetTextField(dateOfBirthView, dateOfBirthStaticLbl)
            updateOtherTextFieldWhenToggle(otherTextField: firstNameTestField, parentView: viewFirstName, textFieldTitle: firstNameStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: lastNameTextField, parentView: viewLastName, textFieldTitle: lastNameStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: emailTextField, parentView: emailView, textFieldTitle: emailStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: phoneTextField, parentView: phoneView, textFieldTitle: UILabel(), isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: passwordTextField, parentView: viewPassword, textFieldTitle: passwordStaticLabel, isHidden: true)
        } else if textField == phoneTextField{
            resetTextField(phoneView, phoneStaticLabel)
            updateOtherTextFieldWhenToggle(otherTextField: firstNameTestField, parentView: viewFirstName, textFieldTitle: firstNameStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: lastNameTextField, parentView: viewLastName, textFieldTitle: lastNameStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: emailTextField, parentView: emailView, textFieldTitle: emailStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: dateOfBirthTextField, parentView: dateOfBirthView, textFieldTitle: dateOfBirthStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: passwordTextField, parentView: viewPassword, textFieldTitle: passwordStaticLabel, isHidden: true)
        } else if textField == passwordTextField{
            resetTextField(viewPassword, passwordStaticLabel)
            updateOtherTextFieldWhenToggle(otherTextField: firstNameTestField, parentView: viewFirstName, textFieldTitle: firstNameStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: lastNameTextField, parentView: viewLastName, textFieldTitle: lastNameStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: emailTextField, parentView: emailView, textFieldTitle: emailStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: dateOfBirthTextField, parentView: dateOfBirthView, textFieldTitle: dateOfBirthStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: phoneTextField, parentView: phoneView, textFieldTitle: phoneStaticLabel, isHidden: true)
        }
        print("TextField did begin editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateUIWhenEndEditingTextField(textField)
        print("TextField did end editing method called")
    }
    
}
