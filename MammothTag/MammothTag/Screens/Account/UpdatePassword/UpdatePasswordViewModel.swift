//
//  UpdatePasswordViewModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 21/08/2022.
//

import Foundation

import Foundation

struct UpdatePasswordViewModel {
    
    var brokenRules: [BrokenRule] = [BrokenRule]()
    
    var oldPassword = Dynamic<String>("")
    var newPassword = Dynamic<String>("")
    var confirmPassword = Dynamic<String>("")
    
    var bindViewModelDataToController: (Bool, String) -> () = {_,_  in}
    
    var isValid :Bool {
        mutating get {
            self.brokenRules = [BrokenRule]()
            self.validate()
            return self.brokenRules.count == 0 ? true : false
        }
    }
    
    func updatePassword() {
        guard let token = AccountManager.shared.token else {return}
        AuthenticationService.sharedInstance.updatePassword(token: token, oldPassword: oldPassword.value!, newPassword: newPassword.value!) { response in
            if let done = response.result, let message = response.message {
                bindViewModelDataToController(done, message)
            }
        }
    }
}

extension UpdatePasswordViewModel {
     
    mutating func validate() {
        guard let oldPassword = oldPassword.value, oldPassword.isEmptyString == false else {
            let brokenRule = BrokenRule(propertyName: .emptyOldPassword)
            self.brokenRules.append(brokenRule)
            return
        }
        
        guard let newPassword = newPassword.value, newPassword.isEmptyString == false else {
            let brokenRule = BrokenRule(propertyName: .emptyPassword)
            self.brokenRules.append(brokenRule)
            return
        }
        
        if newPassword.count < 8 {
            let brokenRule = BrokenRule(propertyName: .passwordTooShort)
            self.brokenRules.append(brokenRule)
            return
        }
        
        guard let confirmPassword = confirmPassword.value, confirmPassword.isEmptyString == false else {
            let brokenRule = BrokenRule(propertyName: .emptyConfirmPassword)
            self.brokenRules.append(brokenRule)
            return
        }
        
        if confirmPassword != newPassword {
            let brokenRule = BrokenRule(propertyName: .confirmPassword)
            self.brokenRules.append(brokenRule)
            return
        }
    }
    
    
}
