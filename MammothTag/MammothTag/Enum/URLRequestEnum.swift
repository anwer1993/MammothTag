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
    case PUPBLIC_ALL_CARD
    case OPEN_FIRST
    case DEACTIVATE_NFC_URL
    case ACTIVATE_NFC_URL
    case USER_BY_NFC_URL
    case ADD_USER_URL
    //Car
    case ADD_CARD_NETWORK
    case EDIT_CARD_NETWORK
    case DELETE_CARD_NETWORK
    case LIST_CARD_NETWORK
    
    // Request
    case LIST_REQUESTS
    case ADD_REQUEST
    case ACCEPT_REQUEST
    case DELETE_REQUEST
    case LIST_CONTACT_URL
    case DELETE_CONTACT
    case GET_USER_BY_ID_URL
    
    case DELETE_ACCOUNT_URL
    
    var url: String {
        switch self {
        case .REGISTER_URL:
            return "https://mammoth-app.net/mobile/public/api/v1/user/register/en"
        case .LOGIN_URL:
            return "https://mammoth-app.net/mobile/public/api/v1/user/login/en"
        case .LOGOUT_URL:
            return "https://mammoth-app.net/mobile/public/api/v1/user/logout/en?token="
        case .GET_USER_URL:
            return "https://mammoth-app.net/mobile/public/api/v1/user/en?token="
        case .UPDATE_USER_URL:
            return "https://mammoth-app.net/mobile/public/api/v1/user/update/en"
        case .GET_CARDS_URL:
            return "https://mammoth-app.net/mobile/public/api/v1/card/en?token="
        case .ADD_CARDS_URL:
            return "https://mammoth-app.net/mobile/public/api/v1/card/add/en"
        case .EDIT_CARDS_URL:
            return "https://mammoth-app.net/mobile/public/api/v1/card/edit/en"
        case .DELETE_CARDS_URL:
            return "https://mammoth-app.net/mobile/public/api/v1/card/delete/en"
        case .UPDATE_PASSWORD:
            return "https://mammoth-app.net/mobile/public/api/v1/user/change_pass/en"
        case .SETTINGS:
            return "https://mammoth-app.net/mobile/public/api/v1/general/settings/en"
        case .FORGOT_PASSWORD:
            return "https://mammoth-app.net/mobile/public/api/v1/user/forgot_pass/en"
        case .CHANGE_FORGOT_PASSWORD:
            return "https://mammoth-app.net/mobile/public/api/v1/user/forgot_change_pass/en"
        case .ADD_CARD_NETWORK:
            return "https://mammoth-app.net/mobile/public/api/v1/card/network/add/en"
        case .EDIT_CARD_NETWORK:
            return "https://mammoth-app.net/mobile/public/api/v1/card/network/edit/en"
        case .DELETE_CARD_NETWORK:
            return "https://mammoth-app.net/mobile/public/api/v1/card/network/delete/en"
        case .LIST_CARD_NETWORK:
            return "https://mammoth-app.net/mobile/public/api/v1/card/"
        case .LIST_REQUESTS:
            return "https://mammoth-app.net/mobile/public/api/v1/contact/requests/en?token="
        case .ADD_REQUEST:
            return "https://mammoth-app.net/mobile/public/api/v1/contact/request/add/en"
        case .ACCEPT_REQUEST:
            return "https://mammoth-app.net/mobile/public/api/v1/contact/request/accept/en"
        case .DELETE_REQUEST:
            return "https://mammoth-app.net/mobile/public/api/v1/contact/request/delete/en"
        case .LIST_CONTACT_URL:
            return "https://mammoth-app.net/mobile/public/api/v1/contact/en?token="
        case .DELETE_CONTACT:
            return "https://mammoth-app.net/mobile/public/api/v1/contact/delete/en"
        case .GET_USER_BY_ID_URL:
            return "https://mammoth-app.net/mobile/public/api/v1/user/profile/en?token="
        case .PUPBLIC_ALL_CARD:
            return "https://mammoth-app.net/mobile/public/api/v1/card/network/all/en"
        case .OPEN_FIRST:
            return "https://mammoth-app.net/mobile/public/api/v1/card/network/first/en"
        case .DEACTIVATE_NFC_URL:
            return  "https://mammoth-app.net/mobile/public/api/v1/user/nfc/delete/en"
        case .ACTIVATE_NFC_URL:
            return "https://mammoth-app.net/mobile/public/api/v1/user/nfc/update/en"
        case .USER_BY_NFC_URL:
            return "https://mammoth-app.net/mobile/public/api/v1/user/profile/nfc/en?token="
        case .ADD_USER_URL:
            return "https://mammoth-app.net/mobile/public/api/v1/contact/add/en"
        case .DELETE_ACCOUNT_URL:
            return "https://mammoth-app.net/mobile/public/api/v1/user/remove/en"
        }
    }
}
