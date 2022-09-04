//
//  CardTypeEnum.swift
//  MammothTag
//
//  Created by Anwar Hajji on 24/08/2022.
//

import Foundation

enum CardTypeEnum: String {
    case Digital = "1"
    case Business = "2"
    case Job = "3"
    case Family = "4"
}

enum CardPrivacy: String {
    case Public = "0"
    case Private = "1"
    
    var rowValue: String {
        switch self {
        case .Public:
            return "Public"
        case .Private:
            return "Private"
        }
    }
}
