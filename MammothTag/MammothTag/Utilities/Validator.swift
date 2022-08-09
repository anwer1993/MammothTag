//
//  Validator.swift
//  MammothTag
//
//  Created by Anwar Hajji on 08/08/2022.
//

import Foundation

struct BrokenRule {
    var propertyName :BrokenRulesEnum
}

enum BrokenRulesEnum {
    case email
    case password
}

protocol ValidatorProtocol {
    var brokenRules :[BrokenRule] { get set}
    var isValid :Bool { mutating get }
}
