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

struct SignInServerResponseData<T: Codable>: Codable {
    
    let result: Bool?
    let message: String?
    let data: ProfileModel?
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
    
}

struct ProfileModel: Codable {
    let id: Int?
    let name: String?
    let username: String?
    let birthday: String?
    let email: String?
    let phone: String?
    let picture: String?
    let deviceToken: String?
    let code: String?
    let isApproved: String?
    let isBanned: String?
    let isNotifiable: String?
    let userType: String?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case username = "username"
        case birthday = "birthday"
        case email = "email"
        case phone = "phone"
        case picture = "picture"
        case deviceToken = "device_token"
        case code = "code"
        case isApproved = "is_approved"
        case isBanned = "is_banned"
        case isNotifiable = "is_notifiable"
        case userType = "user_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


struct SettingsModel {
    var terms: String
    var conditions: String
}

