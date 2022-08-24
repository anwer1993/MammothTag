//
//  ServerResponseModeel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 19/08/2022.
//

import Foundation

struct ServerResponseModel<T: Codable>: Codable {
    
    let result: Bool?
    let message: String?
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case data = "data"
    }
    
}

struct LogoutServerResponseModel: Codable {
    
    let success: Bool?
    let message: String?
//    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
//        case data = "data"
    }
    
}

struct ProfilModelG<T: Codable>: Codable {
    
    let success: Bool?
    let message: String?
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
}


