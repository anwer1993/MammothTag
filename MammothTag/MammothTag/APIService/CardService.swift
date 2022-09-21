//
//  CardService.swift
//  MammothTag
//
//  Created by Anwar Hajji on 19/08/2022.
//

import Foundation
import Alamofire

class CardService {
    
    static var shared = CardService()
    
    func getCards(token: String, completion: @escaping(ListCardServerResponseModel?) -> Void) {
        AF.request("\(URLRequest.GET_CARDS_URL.url)\(token)", method: .get)
            .validate()
            .responseDecodable(of: ListCardServerResponseModel.self) { data in
            completion(data.value)
        }
    }
    
    func addCard(cardName: String, cardType: String, cardPrivacy: String, token: String, completion: @escaping(AddCardResponse?) -> Void) {
        let parameters = ["name": cardName,
                          "type": "\(Int(cardType) ?? 1)",
                          "privacy": "\(Int(cardPrivacy) ?? 1)"] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.ADD_CARDS_URL.url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: AddCardResponse.self) { data in
                completion(data.value)
        }
    }
    
    func editCard(editcardModel: CardProfile, token: String, completion: @escaping(EditCardServerResponseModel?) -> Void) {
        let parameters = ["name": editcardModel.name ?? "",
                          "type": editcardModel.type ?? "",
                          "privacy": editcardModel.privacy ?? "",
                          "card_id": editcardModel.id ?? 0] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.EDIT_CARDS_URL.url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: EditCardServerResponseModel.self) { data in
                completion(data.value)
        }
    }
    
    func deleteCard(cardId: Int, token: String, completion: @escaping(DeleteNetworkServerResponseModel?) -> Void) {
        let parameters = ["card_id": cardId] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.DELETE_CARDS_URL.url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: DeleteNetworkServerResponseModel.self) { data in
                completion(data.value)
        }
    }
    
    func addCardNetwork(card_id: String, social_network_id: String, link: String, status: String, token: String, completion: @escaping(AddCardNetworkServerResponseModel?) -> Void) {
        let parameters = ["card_id": card_id,
                          "social_network_id": social_network_id,
                          "link": link,
                          "status": status] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.ADD_CARD_NETWORK.url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: AddCardNetworkServerResponseModel.self) { data in
                completion(data.value)
        }
    }
    
    func editCardNetwork(card_id: String, social_network_id: String, link: String, status: String, card_network_id: String, token: String, completion: @escaping(EditCardNetworkServerResponseModel?) -> Void) {
        let parameters = ["card_id": card_id,
                          "social_network_id": social_network_id,
                          "link": link,
                          "status": status,
                          "card_network_id": card_network_id] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.EDIT_CARD_NETWORK.url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: EditCardNetworkServerResponseModel.self) { data in
                completion(data.value)
        }
    }
    
    func getListCardNetwork(card_id: String, token: String, completion: @escaping(ListCardNetworkServerResponseModel?) -> Void) {
        AF.request("\(URLRequest.LIST_CARD_NETWORK.url)\(card_id)/network/en?token=\(token)", method: .get)
            .validate()
            .responseDecodable(of: ListCardNetworkServerResponseModel.self) { data in
                completion(data.value)
        }
    }
    
    func deleteCardNetwork(card_network_id: String, token: String, completion: @escaping(DeleteNetworkServerResponseModel?) -> Void) {
        let parameters = ["card_network_id": card_network_id] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.DELETE_CARD_NETWORK.url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: DeleteNetworkServerResponseModel.self) { data in
                completion(data.value)
        }
    }
    
    func shareAllCard(card_id: String, token: String, completion: @escaping(DeleteNetworkServerResponseModel?) -> Void) {
        let parameters = ["card_id": card_id] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.PUPBLIC_ALL_CARD.url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: DeleteNetworkServerResponseModel.self) { data in
                completion(data.value)
        }
    }
    
    func openFirstCard(card_id: String, card_network_id: String, token: String, completion: @escaping(OpenFirstCardServerResponseModel?) -> Void) {
        let parameters = ["card_id": card_id,
                          "card_network_id": card_network_id] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.OPEN_FIRST.url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: OpenFirstCardServerResponseModel.self) { data in
                completion(data.value)
        }
    }
    
}
