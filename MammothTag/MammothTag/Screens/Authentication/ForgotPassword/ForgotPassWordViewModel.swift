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
    
    var bindViewModelDataToController: (Bool, ForgotPasswordModel?, String) -> () = {_,_,_ in}
    
    mutating private func validate() {
        guard let email = email.value, email.isEmptyString == false else {
            let brokenRule = BrokenRule(propertyName: .email)
            self.brokenRules.append(brokenRule)
            return
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if !emailPred.evaluate(with: email)  {
            let brokenRule = BrokenRule(propertyName: .invalidEmail)
            self.brokenRules.append(brokenRule)
            return
        }
        
    }
    
    func sendPhone() {
        AuthenticationService.sharedInstance.forgotPassword(email: email.value!) { response in
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
