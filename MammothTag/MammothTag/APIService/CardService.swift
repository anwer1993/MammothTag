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
    
    func getCards(token: String, completion: @escaping(ServerResponseModel<[CardModel]>) -> Void) {
        AF.request("\(URLRequest.GET_CARDS_URL.url)\(token)", method: .get).validate().responseDecodable(of: ServerResponseModel<[CardModel]>.self) { data in
            if let data = data.value {
                completion(data)
            }
        }
    }
    
    func addCard(cardName: String, cardType: String, cardPrivacy: String, token: String, completion: @escaping(ServerResponseModel<CardModel>) -> Void) {
        let parameters = ["name": cardName,
                          "type": "\(Int(cardType) ?? 1)",
                          "privacy": "\(Int(cardPrivacy) ?? 1)"] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.ADD_CARDS_URL.url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: ServerResponseModel<CardModel>.self) { data in
            if let data = data.value {
                completion(data)
            }
        }
    }
    
    func editCard(editcardModel: CardModel, token: String, completion: @escaping(ServerResponseModel<CardModel>) -> Void) {
        let parameters = ["name": editcardModel.name ?? "",
                          "type": editcardModel.type ?? "",
                          "privacy": editcardModel.privacy ?? "",
                          "card_id": editcardModel.id ?? 0] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.EDIT_CARDS_URL.url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: ServerResponseModel<CardModel>.self) { data in
            if let data = data.value {
                completion(data)
            }
        }
    }
    
    func deleteCard(cardId: Int, token: String, completion: @escaping(ServerResponseModel<CardModel>) -> Void) {
        let parameters = ["card_id": cardId] as Parameters
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(URLRequest.DELETE_CARDS_URL.url, method: .post, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: ServerResponseModel<CardModel>.self) { data in
            if let data = data.value {
                completion(data)
            }
        }
    }
    
    
}
