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
    case emptyPassword
    case passwordTooShort
    case emptyConfirmPassword
    case confirmPassword
    case firstName
    case lastName
    case dateOfBirth
    case phone
    case picture
}

protocol ValidatorProtocol {
    var brokenRules :[BrokenRule] { get set}
    var isValid :Bool { mutating get }
}
