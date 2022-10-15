//
//  SignInModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 08/08/2022.
//
import Alamofire
import Foundation

struct SignInModel: Codable {
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


struct LoginWithSocialMediaModel: Codable {
    let name: String
    let lastName: String
    let email: String
    let url_Picture: String
}
