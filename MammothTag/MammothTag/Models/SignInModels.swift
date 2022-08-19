//
//  SignInModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 08/08/2022.
//
import Alamofire
import Foundation

struct SignInModel {
    var email: String = ""
    var password: String = ""
}

struct LoginServerResponseData: Codable {
    let result: Bool?
    let message: String?
    let token: String?
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case token = "token"
    }
}





struct SettingsModel {
    var terms: String
    var conditions: String
}

