//
//  SignInModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 08/08/2022.
//

import Foundation

struct SignInModel {
    
    var email: String
    var password: String
    
    
}


struct SignInServerResponseData {
    
    var tocken: String
    var error: String
    
}
