//
//  AddUserServerResponseModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 06/09/2022.
//

import Foundation

// MARK: - AddUserServerResponseModel
struct AddUserServerResponseModel: Codable {
    let result: Bool?
    let message: String?
    let data: [String]?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}
