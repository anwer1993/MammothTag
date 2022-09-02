//
//  ContactModels.swift
//  MammothTag
//
//  Created by Anwar Hajji on 31/08/2022.
//

import Foundation

// MARK: - ListRequestServerResponseModel
struct ListRequestServerResponseModel: Codable {
    let result: Bool?
    let message: String?
    let data: [DatumListRequest]?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}

// MARK: - Datum
struct DatumListRequest: Codable {
    let id: Int?
    let name: String?
    let username: String?
    let birthday: String?
    let email: String?
    let phone: String?
    let picture: String?
    let deviceToken: String?
    let code: String?
    let nfcTag: String?
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
        case nfcTag = "nfc_tag"
        case isApproved = "is_approved"
        case isBanned = "is_banned"
        case isNotifiable = "is_notifiable"
        case userType = "user_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


// MARK: - AddRequestServerResponseModel
struct AddRequestServerResponseModel: Codable {
    let result: Bool?
    let message: String?
    let data: [String]?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}


// MARK: - ListContactServerResponseModel
struct ListContactServerResponseModel: Codable {
    let result: Bool?
    let message: String?
    let data: [DatumListContact]?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}

// MARK: - Datum
struct DatumListContact: Codable {
    let id: Int?
    let name: String?
    let username: String?
    let birthday: String?
    let email: String?
    let phone: String?
    let picture: String?
    let deviceToken: String?
    let code: String?
    let nfcTag: String?
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
        case nfcTag = "nfc_tag"
        case isApproved = "is_approved"
        case isBanned = "is_banned"
        case isNotifiable = "is_notifiable"
        case userType = "user_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
