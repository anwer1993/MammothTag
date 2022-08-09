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
    var signInModel: SignInModel?
    
    private(set) var data: SignInServerResponseData? {
        didSet {
            if let data = data {
                self.bindViewModelDataToController(data.tocken != "")
            } else {
                self.bindViewModelDataToController(false)
            }
            
        }
    }
    
    var isValid :Bool {
        mutating get {
            self.brokenRules = [BrokenRule]()
            self.validate()
            return self.brokenRules.count == 0 ? true : false
        }
    }
    
    var bindViewModelDataToController: (Bool) -> () = {_ in}
    
    mutating func login() {
        if let email = email.value, let password = password.value {
            let signInModel = SignInModel(email: email, password: password)
            AuthenticationService.sharedInstance.login(loginModel: signInModel) { data in
                self.data = data
            }
        } else {
            self.data = nil
        }
    }
    
    
}

extension SignInViewModel {
    
    mutating private func validate() {
        
        if email.value == "" || email.value == nil || email.value == ""  {
            let brokenRule = BrokenRule(propertyName: .email)
            self.brokenRules.append(brokenRule)
        }
        
        if (password.value == "" || password.value == nil || password.value == "") {
            let brokenRule = BrokenRule(propertyName: .password)
            self.brokenRules.append(brokenRule)
        }
        
    }
    
}
