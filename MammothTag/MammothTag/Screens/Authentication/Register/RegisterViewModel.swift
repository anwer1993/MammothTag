//
//  RegisterViewModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 09/08/2022.
//

import Foundation


struct RegisterViewModel {
    
    var termsChecked: Bool = false
    
    var registerModel = RegisterModel()
    
    var brokenRules: [BrokenRule] = [BrokenRule]()
    
    var updateUIWhenRegister: ((Bool, String) -> Void) = {_,_  in}
    
    var firstName = Dynamic<String>("")
    var LastName = Dynamic<String>("")
    var email = Dynamic<String>("")
    var dateOfBirth = Dynamic<String>("")
    var phone = Dynamic<String>("")
    var password = Dynamic<String>("")
    var confirmPassword = Dynamic<String>("")
    var picturee: Data? = nil
    
    var isValid :Bool {
        mutating get {
            self.brokenRules = [BrokenRule]()
            self.validate()
            return self.brokenRules.count == 0 ? true : false
        }
    }
    
    mutating func toggleTermsChecked() {
        termsChecked.toggle()
    }
    
    mutating func updateRegisterModel(withcountryCode _countryCode: String) {
        self.registerModel.countryCode = _countryCode
    }
    
    func register() {
        AuthenticationService.sharedInstance.register(userModel: self.registerModel) { data in
            if let message = data.message, let isDone = data.result {
                updateUIWhenRegister(isDone, message)
            }
        }
    }
}


extension RegisterViewModel {
    
    mutating private func validate() {
        
        guard let firstName = firstName.value, firstName.isEmptyString == false else {
            let brokenRule = BrokenRule(propertyName: .firstName)
            self.brokenRules.append(brokenRule)
            return
        }
        
        guard let lastName = LastName.value, lastName.isEmptyString == false else {
            let brokenRule = BrokenRule(propertyName: .lastName)
            self.brokenRules.append(brokenRule)
            return
        }
        
        guard let email = email.value, email.isEmptyString == false else {
            let brokenRule = BrokenRule(propertyName: .email)
            self.brokenRules.append(brokenRule)
            return
        }
        
        guard let dateOfBirth = dateOfBirth.value, dateOfBirth.isEmptyString == false else {
            let brokenRule = BrokenRule(propertyName: .dateOfBirth)
            self.brokenRules.append(brokenRule)
            return
        }
        
        guard let phone = phone.value, phone.isEmptyString == false else {
            let brokenRule = BrokenRule(propertyName: .phone)
            self.brokenRules.append(brokenRule)
            return
        }
        
        guard let password = password.value, password.isEmptyString == false else {
            let brokenRule = BrokenRule(propertyName: .emptyPassword)
            self.brokenRules.append(brokenRule)
            return
        }
        
        if password.count < 8 {
            let brokenRule = BrokenRule(propertyName: .passwordTooShort)
            self.brokenRules.append(brokenRule)
            return
        }
        
        guard let confirmPassword = confirmPassword.value, confirmPassword.isEmptyString == false else {
            let brokenRule = BrokenRule(propertyName: .emptyConfirmPassword)
            self.brokenRules.append(brokenRule)
            return
        }
        
        if confirmPassword != password {
            let brokenRule = BrokenRule(propertyName: .confirmPassword)
            self.brokenRules.append(brokenRule)
            return
        }
        
//        if picturee == nil {
//            let brokenRule = BrokenRule(propertyName: .picture)
//            self.brokenRules.append(brokenRule)
//            return
//        }
        
        registerModel = RegisterModel(firstName: firstName, LastName: lastName, email: email, dateOfBirth: dateOfBirth, countryCode: "", phone: phone, password: password, picture: picturee)
        
    }
    
}
