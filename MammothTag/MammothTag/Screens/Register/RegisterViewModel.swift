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
}


extension RegisterViewModel {
    
    mutating private func validate() {
        
        if email.value.isEmpty{
            let brokenRule = BrokenRule(propertyName: .email)
            self.brokenRules.append(brokenRule)
        }
        
    }
    
}
