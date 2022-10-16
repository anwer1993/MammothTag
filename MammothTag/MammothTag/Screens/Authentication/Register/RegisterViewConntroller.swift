//
//  RegisterViewConntroller.swift
//  MammothTag
//
//  Created by Anwar Hajji on 09/08/2022.
//

import Foundation
import UIKit
import CountryPickerView


class RegisterViewController: UIViewController, Storyboarded {
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var newAccountLbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var addPicImage: UIImageView!
    @IBOutlet weak var viewFirstName: UIView!
    @IBOutlet weak var firstNameStaticLbl: UILabel!
    @IBOutlet weak var firstNameTestField: CustomTextField! {
        didSet {
            self.firstNameTestField.bind(callback: {self.registerViewModel.firstName.value = $0 })
        }
    }
    @IBOutlet weak var viewLastName: UIView!
    @IBOutlet weak var lastNameStaticLabel: UILabel!
    @IBOutlet weak var lastNameTextField: CustomTextField! {
        didSet {
            self.lastNameTextField.bind(callback: {self.registerViewModel.LastName.value = $0 })
        }
    }
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailStaticLbl: UILabel!
    @IBOutlet weak var emailTextField: CustomTextField! {
        didSet {
            self.emailTextField.bind(callback: {self.registerViewModel.email.value = $0 })
        }
    }
    @IBOutlet weak var dateOfBirthView: UIView!
    @IBOutlet weak var dateOfBirthStaticLbl: UILabel!
    @IBOutlet weak var dateOfBirthTextField: CustomTextField! {
        didSet {
            self.dateOfBirthTextField.bind(callback: {self.registerViewModel.dateOfBirth.value = $0 })
        }
    }
    @IBOutlet weak var createPasswordLbl: UILabel!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var passwordTextField: CustomTextField! {
        didSet {
            self.passwordTextField.bind(callback: {self.registerViewModel.password.value = $0 })
        }
    }
    @IBOutlet weak var passwordStaticLabel: UILabel!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var confirmPasswordSstaticLbl: UILabel!
    @IBOutlet weak var confirmPasswordTextField: CustomTextField! {
        didSet {
            self.confirmPasswordTextField.bind(callback: {self.registerViewModel.confirmPassword.value = $0 })
        }
    }
    @IBOutlet weak var countryViewContainer: CountryPickerView!
    @IBOutlet weak var countryCodeView: CountryPickerView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTextField: CustomTextField! {
        didSet {
            self.phoneTextField.bind(callback: {self.registerViewModel.phone.value = $0 })
        }
    }
    @IBOutlet weak var sendButton: GradientButton!
    @IBOutlet weak var uHaveAccountLbl: UILabel!
    @IBOutlet weak var checkTermsButton: UIButton!
    @IBOutlet weak var readTermsLabel: UILabel!
    
    
    var registerViewModel = RegisterViewModel()
    var isTermedChecked: Bool = false
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        datePicker.timeZone = TimeZone.current
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        let showTermsTap = UITapGestureRecognizer(target: self, action: #selector(showTermsAndConditionScreen(_:)))
        let signInTap = UITapGestureRecognizer(target: self, action: #selector(showSignInScreen(_:)))
        let addPicTap = UITapGestureRecognizer(target: self, action: #selector(showActionSheet(_:)))
        readTermsLabel.addTagGesture(showTermsTap)
        uHaveAccountLbl.addTagGesture(signInTap)
        addPicImage.addTagGesture(addPicTap)
        datePicker.locale = Locale(identifier:  AppSettings().appLanguage == .AR ? "ar_LY" : "en_US")
        dateOfBirthTextField.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "DONE".localized, style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "CANCEL".localized, style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        dateOfBirthTextField.inputAccessoryView = toolbar
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ar_LY")
        dateOfBirthTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "ar_LY")
        dateOfBirthTextField.text = dateFormatter.string(from: sender.date)
        registerViewModel.dateOfBirth.value = dateOfBirthTextField.text
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countryCodeView.font = UIFont.systemFont(ofSize: 10)
        countryCodeView.textColor = .black
        countryCodeView.flagSpacingInView = 10
        countryCodeView.setCountryByCode("SA")
        registerViewModel.updateRegisterModel(withcountryCode: countryCodeView.selectedCountry.phoneCode)
        registerViewModel.updateUIWhenRegister =  {done, message in
            self.showOrHideLoader(done: true)
            if done == true {
                self.showAlertWithOk(withTitle: "SUCCESS".localized, withMessage: "SUCCESSFULLY_REGISTRED_MESSAGE".localized) {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                self.showAlert(withTitle: "Error", withMessage: message)
            }
        }
    }
    
    func setupLocalizedText() {
        newAccountLbl.text = "NEW_ACCOUNT".localized
        lastNameStaticLabel.text = "LAST_NAME".localized
        firstNameStaticLbl.text = "FIRST_NAME".localized
        dateOfBirthStaticLbl.text = "DATE_OF_BIRTH".localized
        readTermsLabel.text = "CHECK_TERMS".localized
        uHaveAccountLbl.text = "U_HAVE_ACCOUNT".localized
        sendButton.setTitle("SEND".localized, for: .normal)
    }
    
    func initializeView() {
        profileImage.contentMode = .center
        setupLocalizedText()
        backButton.flipWhenRTL(image: UIImage(named: "Groupe 469")!)
        createPasswordLbl.textColor = UIColor.chestnut
        createPasswordLbl.textColor = UIColor.chestnut
        sendButton.customizeButton()
        hideStaticLAbel()
        setupViewsContainTextField()
        sendButton.layer.cornerRadius = 15
        sendButton.customizeButton()
        addPicImage.layer.cornerRadius = 22
        addPicImage.layer.backgroundColor = UIColor.chestnut.cgColor
        addPicImage.layer.borderColor = UIColor.white.cgColor
        addPicImage.layer.borderWidth = 1
        profileImage.layer.cornerRadius = 55
        profileImage.layer.backgroundColor = UIColor.tangerine.cgColor
        passwordTextField.SecureTextField(delegate: self)
        confirmPasswordTextField.SecureTextField(delegate: self)
        checkTermsButton.setImage(UIImage(named: "check_on"), for: .selected)
        checkTermsButton.setImage(UIImage(named: "check_off"), for: .normal)
        newAccountLbl.font = UIFont(name: "Lato-Black", size: 18)
        createPasswordLbl.font = UIFont(name: "Lato-Black", size: 18)
        newAccountLbl.textColor = .redBrown
        createPasswordLbl.textColor = .redBrown
        uHaveAccountLbl.font = UIFont(name: "Lato-Regular", size: 16)
        readTermsLabel.font = UIFont(name: "Lato-Regular", size: 16)
        sendButton.titleLabel?.font = UIFont(name: "Lato-SemiBold", size: 16)
        uHaveAccountLbl.attributedText = uHaveAccountLbl.customizeTextLabel(stringToColor: "SIGN_IN_NOW".localized, color: UIColor.tangerine, isUnderline: true)
        readTermsLabel.attributedText = readTermsLabel.customizeTextLabel(stringToColor: "TERMS_AND_CONDITION".localized, color: UIColor.black, isUnderline: true)
        firstNameTestField.textAlignment = AppSettings().appLanguage == .AR ? .right : .left
        lastNameTextField.textAlignment = AppSettings().appLanguage == .AR ? .right : .left
        emailTextField.textAlignment = AppSettings().appLanguage == .AR ? .right : .left
        dateOfBirthTextField.textAlignment = AppSettings().appLanguage == .AR ? .right : .left
        phoneTextField.textAlignment = AppSettings().appLanguage == .AR ? .right : .left
        passwordTextField.textAlignment = AppSettings().appLanguage == .AR ? .right : .left
        confirmPasswordTextField.textAlignment = AppSettings().appLanguage == .AR ? .right : .left
        firstNameTestField.placeholder = "FIRST_NAME".localized
        lastNameTextField.placeholder = "LAST_NAME".localized
        emailTextField.placeholder = "EMAIL".localized
        dateOfBirthTextField.placeholder = "DATE_OF_BIRTH".localized
        phoneTextField.placeholder = "PHONE".localized
        passwordTextField.placeholder = "PASSWORD".localized
        confirmPasswordTextField.placeholder = "CONFIRM_PASSWORD".localized
        createPasswordLbl.text = "CREATE_PASSWORD".localized
    }
    
    func setupViewsContainTextField() {
        viewFirstName.layer.cornerRadius = 20.0
        viewLastName.layer.cornerRadius = 20.0
        emailView.layer.cornerRadius = 20.0
        dateOfBirthView.layer.cornerRadius = 20.0
        countryViewContainer.layer.cornerRadius = 20.0
        viewPassword.layer.cornerRadius = 20.0
        phoneView.layer.cornerRadius = 20.0
        confirmPasswordView.layer.cornerRadius = 20.0
        viewFirstName.customizeViewForContainTextField()
        viewLastName.customizeViewForContainTextField()
        emailView.customizeViewForContainTextField()
        dateOfBirthView.customizeViewForContainTextField()
        countryViewContainer.customizeViewForContainTextField()
        viewPassword.customizeViewForContainTextField()
        phoneView.customizeViewForContainTextField()
        confirmPasswordView.customizeViewForContainTextField()
    }
    
    func hideStaticLAbel() {
        firstNameTestField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        emailTextField.keyboardType = .emailAddress
        dateOfBirthTextField.delegate = self
        phoneTextField.delegate = self
        phoneTextField.keyboardType = .phonePad
        firstNameStaticLbl.isHidden = true
        lastNameStaticLabel.isHidden = true
        emailStaticLbl.isHidden = true
        dateOfBirthStaticLbl.isHidden = true
        passwordStaticLabel.isHidden = true
        confirmPasswordSstaticLbl.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func checkTermsButtonTapped(_ sender: Any) {
        checkTermsButton.isSelected.toggle()
        registerViewModel.toggleTermsChecked()
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        if registerViewModel.isValid {
            if registerViewModel.termsChecked {
                showOrHideLoader(done: false)
                registerViewModel.register()
            } else {
                showAlert(withTitle: "Error", withMessage: "Please check terms & conditions first")
            }
        } else {
            registerViewModel.brokenRules.map({$0.propertyName}).forEach { Brokenrule in
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
                    showAlert(withTitle: "ERROR".localized, withMessage: "PASSWORD_TOO_SHORT".localized)
                    break
                case .emptyConfirmPassword:
                    updateUIWhenEndEditingTextField(confirmPasswordTextField)
                    break
                case .confirmPassword:
                    showAlert(withTitle: "ERROR".localized, withMessage: "PASSWORD_NOT_MATCHED".localized)
                    break
                case .picture:
                    showAlert(withTitle: "ERROR".localized, withMessage: "SELECT_PROFILE_PIC".localized)
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
    
    @objc func showTermsAndConditionScreen(_ sender: UITapGestureRecognizer? = nil) {
        Router.shared.push(with: self.navigationController, screen: .Terms(source: .none), animated: true)
    }
    
    @objc func showSignInScreen(_ sender: UITapGestureRecognizer? = nil) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension RegisterViewController: UITextFieldDelegate {
    
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
                updateViewAppearenceWhenValid(phoneView, UILabel())
            } else {
                updateViewAppearenceWhenError(phoneView, UILabel())
            }
        } else if textField == passwordTextField {
            passwordStaticLabel.isHidden = textField.isEmpty()
            if !textField.isEmpty() {
                updateViewAppearenceWhenValid(viewPassword, passwordStaticLabel)
            } else {
                updateViewAppearenceWhenError(viewPassword, passwordStaticLabel)
            }
        } else if textField == confirmPasswordTextField {
            confirmPasswordSstaticLbl.isHidden = textField.isEmpty()
            if !textField.isEmpty() {
                updateViewAppearenceWhenValid(confirmPasswordView, confirmPasswordSstaticLbl)
            } else {
                updateViewAppearenceWhenError(confirmPasswordView, confirmPasswordSstaticLbl)
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
            updateOtherTextFieldWhenToggle(otherTextField: confirmPasswordTextField, parentView: confirmPasswordView, textFieldTitle: confirmPasswordSstaticLbl, isHidden: true)
        } else if textField == lastNameTextField {
            lastNameStaticLabel.isHidden = false
            resetTextField(viewLastName, lastNameStaticLabel)
            updateOtherTextFieldWhenToggle(otherTextField: firstNameTestField, parentView: viewFirstName, textFieldTitle: firstNameStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: emailTextField, parentView: emailView, textFieldTitle: emailStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: dateOfBirthTextField, parentView: dateOfBirthView, textFieldTitle: dateOfBirthStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: phoneTextField, parentView: phoneView, textFieldTitle: UILabel(), isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: passwordTextField, parentView: viewPassword, textFieldTitle: passwordStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: confirmPasswordTextField, parentView: confirmPasswordView, textFieldTitle: confirmPasswordSstaticLbl, isHidden: true)
        } else if textField == emailTextField {
            registerViewModel.registerModel.email = textField.text ?? ""
            emailStaticLbl.isHidden = false
            resetTextField(emailView, emailStaticLbl)
            updateOtherTextFieldWhenToggle(otherTextField: firstNameTestField, parentView: viewFirstName, textFieldTitle: firstNameStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: lastNameTextField, parentView: viewLastName, textFieldTitle: lastNameStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: dateOfBirthTextField, parentView: dateOfBirthView, textFieldTitle: dateOfBirthStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: phoneTextField, parentView: phoneView, textFieldTitle: UILabel(), isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: passwordTextField, parentView: viewPassword, textFieldTitle: passwordStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: confirmPasswordTextField, parentView: confirmPasswordView, textFieldTitle: confirmPasswordSstaticLbl, isHidden: true)
        } else if textField == dateOfBirthTextField {
            dateOfBirthStaticLbl.isHidden = false
            resetTextField(dateOfBirthView, dateOfBirthStaticLbl)
            updateOtherTextFieldWhenToggle(otherTextField: firstNameTestField, parentView: viewFirstName, textFieldTitle: firstNameStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: lastNameTextField, parentView: viewLastName, textFieldTitle: lastNameStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: emailTextField, parentView: emailView, textFieldTitle: emailStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: phoneTextField, parentView: phoneView, textFieldTitle: UILabel(), isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: passwordTextField, parentView: viewPassword, textFieldTitle: passwordStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: confirmPasswordTextField, parentView: confirmPasswordView, textFieldTitle: confirmPasswordSstaticLbl, isHidden: true)
        } else if textField == passwordTextField {
            passwordStaticLabel.isHidden = false
            resetTextField(viewPassword, passwordStaticLabel)
            updateOtherTextFieldWhenToggle(otherTextField: firstNameTestField, parentView: viewFirstName, textFieldTitle: firstNameStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: lastNameTextField, parentView: viewLastName, textFieldTitle: lastNameStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: emailTextField, parentView: emailView, textFieldTitle: emailStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: dateOfBirthTextField, parentView: dateOfBirthView, textFieldTitle: dateOfBirthStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: phoneTextField, parentView: phoneView, textFieldTitle: UILabel(), isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: confirmPasswordTextField, parentView: confirmPasswordView, textFieldTitle: confirmPasswordSstaticLbl, isHidden: true)
        } else if textField == phoneTextField{
            resetTextField(phoneView, UILabel())
            updateOtherTextFieldWhenToggle(otherTextField: firstNameTestField, parentView: viewFirstName, textFieldTitle: firstNameStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: lastNameTextField, parentView: viewLastName, textFieldTitle: lastNameStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: emailTextField, parentView: emailView, textFieldTitle: emailStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: dateOfBirthTextField, parentView: dateOfBirthView, textFieldTitle: dateOfBirthStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: passwordTextField, parentView: viewPassword, textFieldTitle: passwordStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: confirmPasswordTextField, parentView: confirmPasswordView, textFieldTitle: confirmPasswordSstaticLbl, isHidden: true)
        } else if textField == confirmPasswordTextField {
            confirmPasswordView.isHidden = false
            resetTextField(confirmPasswordView, confirmPasswordSstaticLbl)
            updateOtherTextFieldWhenToggle(otherTextField: firstNameTestField, parentView: viewFirstName, textFieldTitle: firstNameStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: lastNameTextField, parentView: viewLastName, textFieldTitle: lastNameStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: emailTextField, parentView: emailView, textFieldTitle: emailStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: dateOfBirthTextField, parentView: dateOfBirthView, textFieldTitle: dateOfBirthStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: phoneTextField, parentView: phoneView, textFieldTitle: UILabel(), isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: passwordTextField, parentView: viewPassword, textFieldTitle: passwordStaticLabel, isHidden: true)
        }
        print("TextField did begin editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateUIWhenEndEditingTextField(textField)
        print("TextField did end editing method called")
    }
    
    
    
}
