//
//  RegisterModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 10/08/2022.
//

import Foundation

struct RegisterModel {
    
    var firstName: String = ""
    var LastName: String = ""
    var email: String = ""
    var dateOfBirth: String = ""
    var countryCode: String = ""
    var phone: String = ""
    var password: String = ""
    var picture: Data? = nil
    
}

// MARK: - RegisterServerResponse
struct RegisterServerResponse: Codable {
    let result: Bool?
    let message: String?
    let data: RegisterDataClass?
    let token: String?
}

// MARK: - DataClass
struct RegisterDataClass: Codable {
    let id: Int?
    let name, username: String?
    let birthday: String?
    let email: String?
    let phone, picture, deviceToken, code: String?
    let nfcTag, branchLink: String?
    let urlPictureSocialNetwork: String?
    let loginWith, isApproved, isBanned, isNotifiable: String?
    let userType, createdAt, updatedAt: String?
    let cards: [CardProfile]?

    enum CodingKeys: String, CodingKey {
        case id, name, username, birthday, email, phone, picture
        case deviceToken = "device_token"
        case code
        case nfcTag = "nfc_tag"
        case branchLink = "branch_link"
        case urlPictureSocialNetwork = "url_picture_social_network"
        case loginWith = "login_with"
        case isApproved = "is_approved"
        case isBanned = "is_banned"
        case isNotifiable = "is_notifiable"
        case userType = "user_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case cards
    }
}
