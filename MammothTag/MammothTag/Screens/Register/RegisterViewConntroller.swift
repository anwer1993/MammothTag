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
    @IBOutlet weak var firstNameTestField: CustomTextField!
    @IBOutlet weak var viewLastName: UIView!
    @IBOutlet weak var lastNameStaticLabel: UILabel!
    @IBOutlet weak var lastNameTextField: CustomTextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailStaticLbl: UILabel!
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var dateOfBirthView: UIView!
    @IBOutlet weak var dateOfBirthStaticLbl: UILabel!
    @IBOutlet weak var dateOfBirthTextField: CustomTextField!
    
    @IBOutlet weak var createPasswordLbl: UILabel!
    @IBOutlet weak var viewPassword: UIView!
    @IBOutlet weak var passwordStaticLbl: UIView!
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    @IBOutlet weak var countryViewContainer: CountryPickerView!
    @IBOutlet weak var countryCodeView: CountryPickerView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var sendButton: GradientButton!
    @IBOutlet weak var uHaveAccountLbl: UILabel!
    @IBOutlet weak var checkTermsButton: UIButton!
    @IBOutlet weak var readTermsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        let showTermsTap = UITapGestureRecognizer(target: self, action: #selector(showTermsAndConditionScreen(_:)))
        let signInTap = UITapGestureRecognizer(target: self, action: #selector(showSignInScreen(_:)))
        readTermsLabel.addTagGesture(showTermsTap)
        uHaveAccountLbl.addTagGesture(signInTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func initializeView() {
        createPasswordLbl.textColor = UIColor.chestnut
        createPasswordLbl.textColor = UIColor.chestnut
        sendButton.customizeButton()
        hideStaticLAbel()
        setupViewsContainTextField()
        sendButton.layer.cornerRadius = 15
        sendButton.customizeButton()
        uHaveAccountLbl.attributedText = uHaveAccountLbl.customizeTextLabel(stringToColor: "Sign in now", color: UIColor.tangerine, isUnderline: true)
        readTermsLabel.attributedText = readTermsLabel.customizeTextLabel(stringToColor: "Terms & conditions", color: UIColor.black, isUnderline: true)
        addPicImage.layer.cornerRadius = 22
        addPicImage.layer.backgroundColor = UIColor.chestnut.cgColor
        addPicImage.layer.borderColor = UIColor.white.cgColor
        addPicImage.layer.borderWidth = 1
        profileImage.layer.cornerRadius = 55
        profileImage.layer.backgroundColor = UIColor.tangerine.cgColor
        passwordTextField.enablePasswordToggle()
        countryCodeView.font = UIFont.systemFont(ofSize: 10)
        countryCodeView.textColor = .black
        countryCodeView.flagSpacingInView = 10
        countryCodeView.setCountryByCode("SA")
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
        firstNameStaticLbl.isHidden = true
        lastNameStaticLabel.isHidden = true
        emailStaticLbl.isHidden = true
        dateOfBirthStaticLbl.isHidden = true
        passwordStaticLbl.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func checkTermsButtonTapped(_ sender: Any) {
        checkTermsButton.isSelected.toggle()
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
    }
    
    
    
}
