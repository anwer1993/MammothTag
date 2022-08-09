//
//  AuthenticationService.swift
//  MammothTag
//
//  Created by Anwar Hajji on 09/08/2022.
//

import Foundation
import Alamofire


class AuthenticationService {
    
    static var sharedInstance = AuthenticationService()
    
    
    func login(loginModel: SignInModel, completion: (SignInServerResponseData) -> Void) {
        
        if loginModel.email.lowercased() == "Anwer".lowercased() && loginModel.password == "anwer" {
            completion(SignInServerResponseData(tocken: "welcome", error: ""))
        } else {
            completion(SignInServerResponseData(tocken: "", error: "error"))
        }
    }
    
    func sendEmail(email: String, completion: (Bool) -> Void) {
        completion(email.lowercased() == "Anwer".lowercased())
    }
    
    
    
}
