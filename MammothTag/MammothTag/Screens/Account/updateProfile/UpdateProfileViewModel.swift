//
//  UpdateProfileViewModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 24/08/2022.
//

import Foundation


struct UpdateProfileViewModel {
    
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
    
    func updateUser() {
        if let token = AccountManager.shared.token {
            AuthenticationService.sharedInstance.updateUser(userModel: registerModel, token: token) { response in
                if let message = response.message, let isDone = response.result {
                    updateUIWhenRegister(isDone, message)
                } else {
                    updateUIWhenRegister(false, "Fail")
                }
            }
        }
    }
}


extension UpdateProfileViewModel {
    
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
        
        if password != AccountManager.shared.password {
            let brokenRule = BrokenRule(propertyName: .confirmPassword)
            self.brokenRules.append(brokenRule)
            return
        }
        
        registerModel = RegisterModel(firstName: firstName, LastName: lastName, email: email, dateOfBirth: dateOfBirth, countryCode: "", phone: phone, password: password, picture: nil)
        
    }
    
}
