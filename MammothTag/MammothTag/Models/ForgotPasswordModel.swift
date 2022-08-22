//
//  ForgotPasswordModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 21/08/2022.
//

import Foundation

struct ForgotPasswordModel: Codable {
    
    let phone: String = ""
    let code: String = ""

    enum CodingKeys: String, CodingKey {
        case phone = "phone"
        case code = "code"
    }
}
