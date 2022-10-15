//
//  ForgotPassWordViewModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 09/08/2022.
//

import Foundation


struct ForgotPasswordViewModel {
    
    var brokenRules: [BrokenRule] = [BrokenRule]()
    var phone = Dynamic<String>("")
    
    var isValid :Bool {
        mutating get {
            self.brokenRules = [BrokenRule]()
            self.validate()
            return self.brokenRules.count == 0 ? true : false
        }
    }
    
    var bindViewModelDataToController: (Bool, ForgotPasswordModel?, String) -> () = {_,_,_ in}
    
    mutating private func validate() {
        guard let phone = phone.value, phone.isEmptyString == false else {
            let brokenRule = BrokenRule(propertyName: .phone)
            self.brokenRules.append(brokenRule)
            return
        }
        
    }
    
    func sendPhone() {
        AuthenticationService.sharedInstance.forgotPassword(email: phone.value!) { response in
            if let done = response.result, let message = response.message {
                if done {
                    self.bindViewModelDataToController(true, response.data?.first, message)
                } else {
                    self.bindViewModelDataToController(false, nil, message)
                }
            }
        }
    }
    
}
