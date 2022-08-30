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
    
    func editCard(editcardModel: CardModel, token: String, completion: @escaping(EditCardServerResponseModel?) -> Void) {
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
    
    
}
