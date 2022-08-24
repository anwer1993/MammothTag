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
    
    var updateUIWhenAddCard: (Bool, String) -> () = {_,_ in }
    
    mutating func validateCardName() -> Bool {
        return cardName.isEmptyString == false
    }
    
    func addCard() {
        if let token = AccountManager.shared.token {
            CardService.shared.addCard(cardName: cardName, cardType: cardTyp.rawValue, cardPrivacy: cardPrivacy.rawValue, token: token) { response in
                if let done = response.result, let message = response.message {
                    updateUIWhenAddCard(done, message)
                } else {
                    updateUIWhenAddCard(false, "Fail")
                }
            }
        }
        
    }
    
    
}
