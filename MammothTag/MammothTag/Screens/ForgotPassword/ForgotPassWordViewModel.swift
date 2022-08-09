//
//  ForgotPassWordViewModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 09/08/2022.
//

import Foundation


struct ForgotPasswordViewModel {
    
    var brokenRules: [BrokenRule] = [BrokenRule]()
    var email = Dynamic<String>("")
    
    var isValid :Bool {
        mutating get {
            self.brokenRules = [BrokenRule]()
            self.validate()
            return self.brokenRules.count == 0 ? true : false
        }
    }
    
    var bindViewModelDataToController: (Bool) -> () = {_ in}
    
    mutating private func validate() {
        if email.value == "" || email.value == nil || email.value == ""  {
            let brokenRule = BrokenRule(propertyName: .email)
            self.brokenRules.append(brokenRule)
        }
    }
    
    mutating func sendEmail() {
        if let email = email.value {
            AuthenticationService.sharedInstance.sendEmail(email: email) { done in
                bindViewModelDataToController(done)
            }
        } else {
            bindViewModelDataToController(false)
        }
        
    }
    
}
