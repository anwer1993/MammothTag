//
//  CardServerResponseModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 27/08/2022.
//

import Foundation

struct AddCardResponse: Codable {
    let result: Bool?
    let message: String?
    let data: CardModel?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}

// MARK: - ListCardServerResponseModel
struct ListCardServerResponseModel: Codable {
    let result: Bool?
    let message: String?
    let data: [DatumCard]?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}

// MARK: - Datum
struct DatumCard: Codable {
    let id: Int?
    let userID: String?
    let name: String?
    let type: String?
    let privacy: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userID = "user_id"
        case name = "name"
        case type = "type"
        case privacy = "privacy"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct ListCardResponse: Codable {
    let result: Bool?
    let message: String?
    let data: [CardModel]?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}

struct CardModel: Codable {
    let userID: Int?
    let name: String?
    let type: String?
    let privacy: String?
    let updatedAt: String?
    let createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name = "name"
        case type = "type"
        case privacy = "privacy"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id = "id"
    }
}

// MARK: - EditCardServerResponseModel
struct EditCardServerResponseModel: Codable {
    let result: Bool?
    let message: String?
    let data: DataClassEditCard?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}

// MARK: - DataClass
struct DataClassEditCard: Codable {
    let id: Int?
    let userID: String?
    let name: String?
    let type: String?
    let privacy: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case userID = "user_id"
        case name = "name"
        case type = "type"
        case privacy = "privacy"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


//struct EditCardServerResponseModel: Codable {
//    let result: Bool?
//    let message: String?
//    let data: CardModel?
//
//    enum CodingKeys: String, CodingKey {
//        case result = "result"
//        case message = "message"
//        case data = "data"
//    }
//}


// MARK: - AddNetworkServerResponseModel
struct AddNetworkServerResponseModel: Codable {
    let result: Bool?
    let message: String?
    let data: DataClass?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let cardID: String?
    let socialNetworkID: String?
    let link: String?
    let updatedAt: String?
    let createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case cardID = "card_id"
        case socialNetworkID = "social_network_id"
        case link = "link"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id = "id"
    }
}


// MARK: - EditNetworkServerResponseModel
struct EditNetworkServerResponseModel: Codable {
    let result: Bool?
    let message: String?
    let data: EditCard?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}

// MARK: - DataClass
struct EditCard: Codable {
    let id: Int?
    let cardID: String?
    let socialNetworkID: String?
    let link: String?
    let status: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cardID = "card_id"
        case socialNetworkID = "social_network_id"
        case link = "link"
        case status = "status"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


// MARK: - DeleteNetworkServerResponseModel
struct DeleteNetworkServerResponseModel: Codable {
    let result: Bool?
    let message: String?
    let data: [String]?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}


// MARK: - ListCardNetworkServerResponseModel
struct ListCardNetworkServerResponseModel: Codable {
    let result: Bool?
    let message: String?
    let data: [Datum]?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int?
    let cardID: String?
    let socialNetworkID: String?
    let link: String?
    let status: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cardID = "card_id"
        case socialNetworkID = "social_network_id"
        case link = "link"
        case status = "status"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
