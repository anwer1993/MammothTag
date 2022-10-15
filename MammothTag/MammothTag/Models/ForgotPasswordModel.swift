//
//  ForgotPasswordModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 21/08/2022.
//

import Foundation

struct ForgotPasswordResponse: Codable {
    let result: Bool?
    let message: String?
    let data: [ForgotPasswordModel]?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
}

struct ForgotPasswordModel: Codable {
    let email: String?
    let code: String?

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case code = "code"
    }
}
