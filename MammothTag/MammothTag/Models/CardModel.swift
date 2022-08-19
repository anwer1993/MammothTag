//
//  CardModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 19/08/2022.
//

import Foundation


struct CardModel: Codable {
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
