//
//  SignInViewModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 08/08/2022.
//

import Foundation

struct SignInViewModel {
    
    var brokenRules: [BrokenRule] = [BrokenRule]()
    var email = Dynamic<String>("")
    var password = Dynamic<String>("")
    var signInModel = SignInModel()
    
    var isValid :Bool {
        mutating get {
            self.brokenRules = [BrokenRule]()
            self.validate()
            return self.brokenRules.count == 0 ? true : false
        }
    }
    
    var bindViewModelDataToController: (Bool, String) -> () = {_,_  in}
    
    func login() {
        AuthenticationService.sharedInstance.login(loginModel: signInModel) { data in
            if data.result == true {
                if let token = data.token {
                    AccountManager.shared.token = token
                    AccountManager.shared.loginType  = .simpleLogin
                    bindViewModelDataToController(true, "")
                } else if let message = data.message {
                    bindViewModelDataToController(false, message)
                    print("Error: \(message)")
                }
            } else if let message = data.message {
                bindViewModelDataToController(false, message)
                print("Error: \(message)")
            }
        }
    }
    
    
}

extension SignInViewModel {
    
    mutating private func validate() {
        
        guard let email = email.value, email.isEmptyString == false else {
            let brokenRule = BrokenRule(propertyName: .email)
            self.brokenRules.append(brokenRule)
            return
        }
        
        guard let password = password.value, password.isEmptyString == false else {
            let brokenRule = BrokenRule(propertyName: .emptyPassword)
            self.brokenRules.append(brokenRule)
            return
        }
        
        signInModel = SignInModel(email: email, password: password)
    }
    
}
