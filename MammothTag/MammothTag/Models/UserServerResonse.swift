//
//  UserServerResonse.swift
//  MammothTag
//
//  Created by Anwar Hajji on 02/09/2022.
//

import Foundation

// MARK: - ListContactServerResponseModel
struct UserServerResponseModel: Codable {
    let result: Bool?
    let message: String?
    let data: DataClassUser?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseDataClass { response in
//     if let dataClass = response.result.value {
//       ...
//     }
//   }

// MARK: - DataClass
struct DataClassUser: Codable {
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
    let cards: [Card]?
    let isFriend: Bool?

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
        case cards = "cards"
        case isFriend = "is_friend"
    }
}

// MARK: - Card
struct Card: Codable {
    let id: Int?
    let userID: String?
    let name: String?
    let type: String?
    let privacy: String?
    let createdAt: String?
    let updatedAt: String?
    let cardNetworks: [CardNetwork]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userID = "user_id"
        case name = "name"
        case type = "type"
        case privacy = "privacy"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case cardNetworks = "card_networks"
    }
}

// MARK: - CardNetwork
struct CardNetwork: Codable {
    let id: Int?
    let cardID: String?
    let socialNetworkID: String?
    let link: String?
    let status: String?
    let isOpenFirst: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cardID = "card_id"
        case socialNetworkID = "social_network_id"
        case link = "link"
        case status = "status"
        case isOpenFirst = "is_open_first"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
