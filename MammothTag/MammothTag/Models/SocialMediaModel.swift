//
//  SocialMediaModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 28/08/2022.
//

import Foundation

struct SocialMediaModel: Codable {
    
    var imageName: String?
    var socialMediaName: String?
    var socialMediaId: Int?
    
}

// MARK: - AddCardNetworkServerResponseModel
struct AddCardNetworkServerResponseModel: Codable {
    let result: Bool?
    let message: String?
    let data: DataClassAddCardNetwork?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}

// MARK: - DataClass
struct DataClassAddCardNetwork: Codable {
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

// MARK: - EditCardNetworkServerResponseModel
struct EditCardNetworkServerResponseModel: Codable {
    let result: Bool?
    let message: String?
    let data: DataClassEditCardNetwork?

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
struct DataClassEditCardNetwork: Codable {
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


// MARK: - ListCardNetworkServerResponseModel
struct ListCardNetworkServerResponseModel: Codable {
    let result: Bool?
    let message: String?
    let data: [DatumListCardNetwork]?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}

// MARK: - Datum
struct DatumListCardNetwork: Codable {
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


// MARK: - DeleteCardNetworkServerResponseModel
struct DeleteCardNetworkServerResponseModel: Codable {
    let result: Bool?
    let message: String?
    let data: [String]?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}
