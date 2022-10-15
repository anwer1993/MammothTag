//
//  ChangeForgotPasswordViewModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 21/08/2022.
//

import Foundation


struct ChangeForgotPasswordViewModel {
    
    
    var brokenRules: [BrokenRule] = [BrokenRule]()
    var password = Dynamic<String>("")
    var confirmPassword = Dynamic<String>("")
    
    var isValid :Bool {
        mutating get {
            self.brokenRules = [BrokenRule]()
            self.validate()
            return self.brokenRules.count == 0 ? true : false
        }
    }
    
    var bindViewModelDataToController: (Bool, String) -> () = {_,_ in}
    
    mutating private func validate() {
        
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
        
    }
    
    func changePassword(code: String, email: String) {
        AuthenticationService.sharedInstance.changeForgotPassword(email: email, code: code, password: password.value!) { response in
            if let done = response.result, let message = response.message {
                if done {
                    self.bindViewModelDataToController(true, message)
                } else {
                    self.bindViewModelDataToController(false, message)
                }
            }
        }
    }
    
    
}



