//
//  SettingsModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 21/08/2022.
//

import Foundation


struct SettingsModel: Codable {
    
    let about: String?
    let terms: String?
    let androidVersion: String?

    enum CodingKeys: String, CodingKey {
        case about = "about"
        case terms = "terms"
        case androidVersion = "android_version"
    }
}
