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
    case GET_CARDS_URL
    case ADD_CARDS_URL
    case EDIT_CARDS_URL
    case DELETE_CARDS_URL
    case UPDATE_PASSWORD
    case SETTINGS
    case FORGOT_PASSWORD
    case CHANGE_FORGOT_PASSWORD
    //Car
    case ADD_CARD_NETWORK
    case EDIT_CARD_NETWORK
    case DELETE_CARD_NETWORK
    case LIST_CARD_NETWORK
    
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
        case .GET_CARDS_URL:
            return "http://mubadiroun.com/Mammouth/public/api/v1/card/en?token="
        case .ADD_CARDS_URL:
            return "http://mubadiroun.com/Mammouth/public/api/v1/card/add/en"
        case .EDIT_CARDS_URL:
            return "http://mubadiroun.com/Mammouth/public/api/v1/card/edit/en"
        case .DELETE_CARDS_URL:
            return "http://mubadiroun.com/Mammouth/public/api/v1/card/delete/en"
        case .UPDATE_PASSWORD:
            return "http://mubadiroun.com/Mammouth/public/api/v1/user/change_pass/en"
        case .SETTINGS:
            return "http://mubadiroun.com/Mammouth/public/api/v1/general/settings/en"
        case .FORGOT_PASSWORD:
            return "http://mubadiroun.com/Mammouth/public/api/v1/user/forgot_pass/en"
        case .CHANGE_FORGOT_PASSWORD:
            return "http://mubadiroun.com/Mammouth/public/api/v1/user/forgot_change_pass/en"
        case .ADD_CARD_NETWORK:
            return "http://mubadiroun.com/Mammouth/public/api/v1/card/network/add/en"
        case .EDIT_CARD_NETWORK:
            return "http://mubadiroun.com/Mammouth/public/api/v1/card/network/edit/en"
        case .DELETE_CARD_NETWORK:
            return "http://mubadiroun.com/Mammouth/public/api/v1/card/network/delete/en"
        case .LIST_CARD_NETWORK:
            return "http://mubadiroun.com/Mammouth/public/api/v1/card/"
        }
    }
}
