//
//  ContactService.swift
//  MammothTag
//
//  Created by Anwar Hajji on 31/08/2022.
//

import Foundation
import Alamofire

class ContactService {
    
    static var shared = ContactService()
    
    func getRequests(token: String, completion: @escaping(ListRequestServerResponseModel?) -> Void) {
        AF.request("\(URLRequest.LIST_REQUESTS.url)\(token)", method: .get)
            .validate()
            .responseDecodable(of: ListRequestServerResponseModel.self) { data in
            completion(data.value)
        }
    }
    
    func getContactList(token: String, completion: @escaping(ListContactServerResponseModel?) -> Void) {
        AF.request("\(URLRequest.LIST_CONTACT_URL.url)\(token)", method: .get)
            .validate()
            .responseDecodable(of: ListContactServerResponseModel.self) { data in
            completion(data.value)
        }
    }
    
    func addRequest(user_id: String, token: String, completion: @escaping(AddRequestServerResponseModel?) -> Void) {
        let parameters = ["user_id": user_id,] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.ADD_REQUEST.url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: AddRequestServerResponseModel.self) { data in
            completion(data.value)
        }
    }
    
    func acceptRequest(user_id: String, token: String, completion: @escaping(AddRequestServerResponseModel?) -> Void) {
        let parameters = ["user_id": user_id,] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.ACCEPT_REQUEST.url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: AddRequestServerResponseModel.self) { data in
            completion(data.value)
        }
    }
    
    func deleteRequest(user_id: String, token: String, completion: @escaping(AddRequestServerResponseModel?) -> Void) {
        let parameters = ["user_id": user_id,] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.DELETE_REQUEST.url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: AddRequestServerResponseModel.self) { data in
            completion(data.value)
        }
    }
    
    func deleteContact(user_id: String, token: String, completion: @escaping(AddRequestServerResponseModel?) -> Void) {
        let parameters = ["user_id": user_id,] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.DELETE_CONTACT.url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: AddRequestServerResponseModel.self) { data in
            completion(data.value)
        }
    }
    
    func getUserProfile(user_id: String,token: String, completion: @escaping(UserServerResponseModel?) -> Void) {
        AF.request("\(URLRequest.GET_USER_BY_ID_URL.url)\(token)&user_id=\(user_id)", method: .get).validate().responseDecodable(of: UserServerResponseModel.self) { data in
            completion(data.value)
        }
    }
    
}
