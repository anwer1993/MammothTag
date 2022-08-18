//
//  Constant.swift
//  MammothTag
//
//  Created by Anwar Hajji on 18/08/2022.
//

import Foundation


enum URLRequest: String {
    
    case REGISTER_URL
    case LOGIN_URL
    case LOGOUT_URL
    case GET_USER_URL
    case UPDATE_USER_URL
    
    var url: String {
        switch self {
        case .REGISTER_URL:
            return "http://mubadiroun.com/Mammouth/public/api/v1/user/register/en"
        case .LOGIN_URL:
            return "http://mubadiroun.com/Mammouth/public/api/v1/user/login/en"
        case .LOGOUT_URL:
            return "http://mubadiroun.com/Mammouth/public/api/v1/user/logout/en?token="
        case .GET_USER_URL:
            return "http://mubadiroun.com/Mammouth/public/api/v1/user/en?token="
        case .UPDATE_USER_URL:
            return "http://mubadiroun.com/Mammouth/public/api/v1/user/update/en"
        }
    }
}
