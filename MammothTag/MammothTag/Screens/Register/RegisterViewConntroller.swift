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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        let showTermsTap = UITapGestureRecognizer(target: self, action: #selector(showTermsAndConditionScreen(_:)))
        let signInTap = UITapGestureRecognizer(target: self, action: #selector(showSignInScreen(_:)))
        let addPicTap = UITapGestureRecognizer(target: self, action: #selector(showActionSheet(_:)))
        readTermsLabel.addTagGesture(showTermsTap)
        uHaveAccountLbl.addTagGesture(signInTap)
        addPicImage.addTagGesture(addPicTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countryCodeView.font = UIFont.systemFont(ofSize: 10)
        countryCodeView.textColor = .black
        countryCodeView.flagSpacingInView = 10
        countryCodeView.setCountryByCode("SA")
        registerViewModel.updateRegisterModel(withcountryCode: countryCodeView.selectedCountry.phoneCode)
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
        uHaveAccountLbl.attributedText = uHaveAccountLbl.customizeTextLabel(stringToColor: "SIGN_IN_NOW".localized, color: UIColor.tangerine, isUnderline: true)
        readTermsLabel.attributedText = readTermsLabel.customizeTextLabel(stringToColor: "TERMS_AND_CONDITION".localized, color: UIColor.black, isUnderline: true)
        addPicImage.layer.cornerRadius = 22
        addPicImage.layer.backgroundColor = UIColor.chestnut.cgColor
        addPicImage.layer.borderColor = UIColor.white.cgColor
        addPicImage.layer.borderWidth = 1
        profileImage.layer.cornerRadius = 55
        profileImage.layer.backgroundColor = UIColor.tangerine.cgColor
        passwordTextField.enablePasswordToggle()
        checkTermsButton.setImage(UIImage(named: "check_on"), for: .selected)
        checkTermsButton.setImage(UIImage(named: "check_off"), for: .normal)
    }
    
    func setupViewsContainTextField() {
        viewFirstName.layer.cornerRadius = 20.0
        viewLastName.layer.cornerRadius = 20.0
        emailView.layer.cornerRadius = 20.0
        dateOfBirthView.layer.cornerRadius = 20.0
        countryViewContainer.layer.cornerRadius = 20.0
        viewPassword.layer.cornerRadius = 20.0
        phoneView.layer.cornerRadius = 20.0
        viewFirstName.customizeViewForContainTextField()
        viewLastName.customizeViewForContainTextField()
        emailView.customizeViewForContainTextField()
        dateOfBirthView.customizeViewForContainTextField()
        countryViewContainer.customizeViewForContainTextField()
        viewPassword.customizeViewForContainTextField()
        phoneView.customizeViewForContainTextField()
    }
    
    func hideStaticLAbel() {
        firstNameTestField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        dateOfBirthTextField.delegate = self
        passwordTextField.delegate = self
        phoneTextField.delegate = self
        firstNameStaticLbl.isHidden = true
        lastNameStaticLabel.isHidden = true
        emailStaticLbl.isHidden = true
        dateOfBirthStaticLbl.isHidden = true
        passwordStaticLabel.isHidden = true
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
            print("Valid")
        } else {
            registerViewModel.brokenRules.map({$0.propertyName}).forEach { Brokenrule in
                switch Brokenrule {
                case .email:
                    print("invalid email")
                    break
                case .password:
                    break
                default:
                    break
                }
            }
            
        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showTermsAndConditionScreen(_ sender: UITapGestureRecognizer? = nil) {
        Router.shared.push(with: self.navigationController, screen: .Terms, animated: true)
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
            registerViewModel.registerModel.email = textField.text ?? ""
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
        } else if textField == passwordTextField {
            passwordStaticLabel.isHidden = false
            resetTextField(viewPassword, passwordStaticLabel)
            updateOtherTextFieldWhenToggle(otherTextField: firstNameTestField, parentView: viewFirstName, textFieldTitle: firstNameStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: lastNameTextField, parentView: viewLastName, textFieldTitle: lastNameStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: emailTextField, parentView: emailView, textFieldTitle: emailStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: dateOfBirthTextField, parentView: dateOfBirthView, textFieldTitle: dateOfBirthStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: phoneTextField, parentView: phoneView, textFieldTitle: UILabel(), isHidden: true)
        } else {
            resetTextField(phoneView, UILabel())
            updateOtherTextFieldWhenToggle(otherTextField: firstNameTestField, parentView: viewFirstName, textFieldTitle: firstNameStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: lastNameTextField, parentView: viewLastName, textFieldTitle: lastNameStaticLabel, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: emailTextField, parentView: emailView, textFieldTitle: emailStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: dateOfBirthTextField, parentView: dateOfBirthView, textFieldTitle: dateOfBirthStaticLbl, isHidden: true)
            updateOtherTextFieldWhenToggle(otherTextField: passwordTextField, parentView: viewPassword, textFieldTitle: passwordStaticLabel, isHidden: true)
        }
        print("TextField did begin editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateUIWhenEndEditingTextField(textField)
        print("TextField did end editing method called")
    }
    
    
    
}
