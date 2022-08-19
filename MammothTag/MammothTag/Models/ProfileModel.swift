//
//  ProfileModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 19/08/2022.
//

import Foundation

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
