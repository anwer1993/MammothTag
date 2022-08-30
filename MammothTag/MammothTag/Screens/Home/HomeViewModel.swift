//
//  HomeViewModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 13/08/2022.
//

import Foundation

struct HomeViewModel {
    
    
    var cardName: String = ""
    var cardTyp: CardTypeEnum = .Digital
    var cardPrivacy: CardPrivacy = .Public
    var cardId: Int = 0
    
    var updateUIWhenAddCard: (Bool, String) -> () = {_,_ in }
    var updateUIWhenDeleteCard: (Bool, String) -> () = {_,_ in }
    var updateUIWhenGetCard: (Bool, [DatumCard]?,  String) -> () = {_,_,_ in }
    
    mutating func validateCardName() -> Bool {
        return cardName.isEmptyString == false
    }
    
    func addCard() {
        if let token = AccountManager.shared.token {
            CardService.shared.addCard(cardName: cardName, cardType: cardTyp.rawValue, cardPrivacy: cardPrivacy.rawValue, token: token) { response in
                if let response = response {
                    if let done = response.result, let message = response.message {
                        updateUIWhenAddCard(done, message)
                    } else {
                        updateUIWhenAddCard(false, "Fail")
                    }
                } else {
                    updateUIWhenAddCard(false, "Fail")
                }
            }
        }
    }
    
    func getCards() {
        if let token = AccountManager.shared.token {
            CardService.shared.getCards(token: token) { resp in
                if let response = resp {
                    if let done = response.result, let message = response.message, let data = response.data {
                        updateUIWhenGetCard(done, data, message)
                    } else {
                        updateUIWhenGetCard(false, nil, "Fail")
                    }
                } else {
                    updateUIWhenGetCard(false, nil, "Fail")
                }
            }
        }
    }
    
    func deleteCard(card: DatumCard) {
        if let token = AccountManager.shared.token {
            CardService.shared.deleteCard(cardId: card.id ?? 0, token: token) { resp in
                if let response = resp {
                    if let done = response.result, let message = response.message {
                        updateUIWhenDeleteCard(done, message)
                    } else {
                        updateUIWhenDeleteCard(false, "Fail")
                    }
                } else {
                    updateUIWhenDeleteCard(false, "Fail")
                }
            }
        }
    }
    
    func editCard() {
        if let token = AccountManager.shared.token {
            let card = CardModel(userID: 0, name: cardName, type: cardTyp.rawValue, privacy: cardPrivacy.rawValue
                                 , updatedAt: "", createdAt: "", id: cardId)
            CardService.shared.editCard(editcardModel: card, token: token) { resp in
                if let response = resp {
                    if let done = response.result, let message = response.message {
                        updateUIWhenAddCard(done, message)
                    } else {
                        updateUIWhenAddCard(false, "Fail")
                    }
                } else {
                    updateUIWhenAddCard(false, "Fail")
                }
            }
        }
    }
    
    
}
