//
//  OpenFirstServerResponseModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 03/09/2022.
//

import Foundation

// MARK: - OpenFirstCardServerResponseModel
struct OpenFirstCardServerResponseModel: Codable {
    let result: Bool?
    let message: String?
    let data: DataClassOpenFirstCard?

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
struct DataClassOpenFirstCard: Codable {
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
