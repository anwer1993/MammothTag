////
////  HomeViewModel.swift
////  MammothTag
////
////  Created by Anwar Hajji on 13/08/2022.
////
//
import Foundation
import UIKit
//
//struct HomeViewModel {
//
//
//    var cardName: String = ""
//    var cardTyp: CardTypeEnum = .Digital
//    var cardPrivacy: CardPrivacy = .Public
//    var cardId: Int = 0
//
//    var updateUIWhenAddCard: (Bool, String) -> () = {_,_ in }
//    var updateUIWhenDeleteCard: (Bool, String) -> () = {_,_ in }
//    var updateUIWhenGetCard: (Bool, [DatumCard]?,  String) -> () = {_,_,_ in }
//
//    mutating func validateCardName() -> Bool {
//        return cardName.isEmptyString == false
//    }
//
//
//
//
//}

extension HomeViewController {
    
    func getProfile() {
        if let token  = AccountManager.shared.token  {
            DispatchQueue.main.async {
                self.showOrHideLoader(done: false)
            }
            AuthenticationService.sharedInstance.getUserProfile(token: token) {[weak self] resp in
                guard let this = self else {return}
                DispatchQueue.main.async {
                    this.showOrHideLoader(done: true)
                }
                if let resp = resp  {
                    if let done = resp.result, let message = resp.message, let data = resp.data {
                        if done {
                            this.profile = data
                            this.moreVC.profile = data
                            if this.profile?.nfcTag?.isEmptyString == false {
                                this.activateNFCLabel.text = "DEACTIVATE_NFC".localized
                                AccountManager.shared.isApproved = true
                                this.activateNFCImage.alpha = 1
                            } else {
                                this.activateNFCLabel.text = "ACTIVATE_NFC".localized
                                AccountManager.shared.isApproved = true
                                this.activateNFCImage.alpha = 0.6
                            }
                            this.cardList = data.cards  ?? []
                            if this.selectedCard == nil {
                                this.selectedCard = this.cardList.first
                                this.privilageLabl.text = this.cardList.first?.name ?? "Unknown card"
                                this.privilageLbl.text = CardPrivacy(rawValue: this.cardList.first?.privacy ?? "")?.rowValue ?? ""
                            } else {
                                if let card = this.cardList.first(where: {$0.id == this.selectedCard?.id}) {
                                    this.selectedCard = card
                                    this.privilageLabl.text = this.selectedCard?.name ?? "Unknown card"
                                    this.privilageLbl.text = CardPrivacy(rawValue: this.selectedCard?.privacy ?? "")?.rowValue ?? ""
                                } else {
                                    this.selectedCard = this.cardList.first
                                    this.privilageLabl.text = this.cardList.first?.name ?? "Unknown card"
                                    this.privilageLbl.text = CardPrivacy(rawValue: this.cardList.first?.privacy ?? "")?.rowValue ?? ""
                                }
                            }
                            this.profileModeVC.cards = this.cardList
                            this.profileModeVC.updateUIWhenSelectCard = { card in
                                this.updateSelectedCard(selectedCard: card)
                            }
                            this.profileModeVC.updateUIWhenDeleteCard = { card in
                                this.updateSelectedCard(selectedCard: card)
                            }
                            this.profileModeVC.updateUIWhenDeleteCard = { card in
                                this.deleteCard(card: card)
                            }
                            this.privilageView.isHidden = this.cardList.count == 0
                            this.privilageCard.isHidden = this.cardList.count == 0
                            
                            this.listCardNetwork = this.selectedCard?.cardNetworks?.sorted(by: {Int($0.isOpenFirst ?? "1") ?? 1 > Int($1.isOpenFirst ?? "1") ?? 1}) ?? []
                            if this.listCardNetwork.contains(where: {$0.isOpenFirst ==  "1"}) {
                                this.selectedItem = 1
                            } else {
                                this.selectedItem = 0
                            }
                            this.customSegmentControlView.isHidden = false
                            if this.listCardNetwork.isEmpty {
                                this.addSocialMediaTopConstrainte.constant = -(this.socialMediaTable.frame.height * 0.75)
                                this.addLblBottomConstrainte.constant = (this.socialMediaTable.frame.height * 0.75)
                            } else {
                                this.addSocialMediaTopConstrainte.constant = 10.0
                                this.addLblBottomConstrainte.constant = 20.0
                            }
                            this.socialMediaTable.reloadData()
                            
                        } else {
                            this.showAlertWithOk(withTitle: "Error", withMessage: message)
                            this.privilageView.isHidden = true
                        }
                    } else {
                        this.showAlertWithOk(withTitle: "Error", withMessage: "An error occured please try again")
                        this.privilageView.isHidden = true
                    }
                } else {
                    this.showAlertWithOk(withTitle: "Error", withMessage: "An error occured please try again") {
                        this.expireSession(isExppired: true)
                    }
                    this.privilageView.isHidden = true
                }
            }
        }
    }
    
    //    func getData() {
    ////        getCards { done in
    ////            if  done {
    ////                self.getCardNetworks(cardI: "\(self.selectedCard?.id ?? 0)") {
    ////                }
    ////            }
    ////        }
    //    }
    
    //    func getCards(completion: @escaping (_ done: Bool) -> ()) {
    //        if let token = AccountManager.shared.token {
    //            showOrHideLoader(done: false)
    //            CardService.shared.getCards(token: token) {[weak self] resp in
    //                guard let this = self else {return}
    //                this.showOrHideLoader(done: true)
    //                if let response = resp {
    //                    if let done = response.result, let message = response.message, let data = response.data {
    //                        this.updateUIWhenGetCard(done: done, message: message, cards: data)
    //                        completion(true)
    //                    } else {
    //                        this.showAlertWithOk(withTitle: "Error", withMessage: "An error occured please try again")
    //                        this.privilageView.isHidden = true
    //                        completion(false)
    //                    }
    //
    //                } else {
    //                    this.showOrHideLoader(done: true)
    //                    this.showAlertWithOk(withTitle: "Error", withMessage: "An error occured please try again") {
    //                        this.expireSession(isExppired: true)
    //                    }
    //                    this.privilageView.isHidden = true
    //                    completion(false)
    //                }
    //            }
    //        }
    //    }
    //
    //    func getCardNetworks(cardI: String, completion: @escaping () -> ()) {
    //        if let token = AccountManager.shared.token, let id = selectedCard?.id {
    //            self.showOrHideLoader(done: false)
    //            CardService.shared.getListCardNetwork(card_id: "\(id)", token: token) {  [weak self] resp in
    //                guard let this = self else {return}
    //                this.showOrHideLoader(done: true)
    //                if let response = resp {
    //                    if let done = response.result, let message = response.message, let data = resp?.data {
    //                        if done {
    //                            DispatchQueue.main.async {
    //                                this.listCardNetwork = data.sorted(by: {Int($0.isOpenFirst ?? "1") ?? 1 > Int($1.isOpenFirst ?? "1") ?? 1})
    //                                if this.listCardNetwork.contains(where: {$0.isOpenFirst ==  "1"}) {
    //                                    this.selectedItem = 1
    //                                } else {
    //                                    this.selectedItem = 0
    //                                }
    //                                this.customSegmentControlView.isHidden = false
    //                                if this.listCardNetwork.isEmpty {
    //                                    this.addSocialMediaTopConstrainte.constant = -(this.socialMediaTable.frame.height * 0.75)
    //                                    this.addLblBottomConstrainte.constant = (this.socialMediaTable.frame.height * 0.75)
    //                                } else {
    //                                    this.addSocialMediaTopConstrainte.constant = 10.0
    //                                    this.addLblBottomConstrainte.constant = 20.0
    //                                }
    //                                this.socialMediaTable.reloadData()
    //                            }
    //                        } else {
    //                            this.updateUIWhenAddCard(done: false, message: message)
    //                        }
    //                    } else {
    //                        this.updateUIWhenAddCard(done: false, message: "Fail")
    //                    }
    //                    completion()
    //                } else {
    //                    this.updateUIWhenAddCard(done: false, message: "Fail")
    //                    completion()
    //                }
    //            }
    //        }
    //    }
    
    func addCard(cardName: String, cardType: String, cardPrivacy: String) {
        if let token = AccountManager.shared.token {
            self.showOrHideLoader(done: false)
            CardService.shared.addCard(cardName: cardName, cardType: cardType, cardPrivacy: cardPrivacy, token: token) { [weak self] response in
                guard let this = self else {return}
                this.showOrHideLoader(done: true)
                if let response = response {
                    if let done = response.result, let message = response.message {
                        this.updateUIWhenAddCard(done: done, message: message)
                    } else {
                        this.updateUIWhenAddCard(done: false, message: "Fail")
                    }
                } else {
                    this.updateUIWhenAddCard(done: false, message: "Fail")
                }
            }
        }
    }
    
    func deleteCarde(card: CardProfile) {
        if let token = AccountManager.shared.token {
            self.showOrHideLoader(done: false)
            CardService.shared.deleteCard(cardId: card.id ?? 0, token: token) { [weak self] resp in
                guard let this = self else {return}
                this.showOrHideLoader(done: true)
                if let response = resp {
                    if let done = response.result, let message = response.message {
                        this.updateUIDeleteCared(Done: done, message: message)
                    } else {
                        this.updateUIDeleteCared(Done: false, message: "Fail")
                    }
                } else {
                    this.updateUIDeleteCared(Done: false, message: "Fail")
                }
            }
        }
    }
    
    func editCard(card: CardProfile) {
        if let token = AccountManager.shared.token {
            self.showOrHideLoader(done: false)
            CardService.shared.editCard(editcardModel: card, token: token) { [weak self] resp in
                guard let this = self else {return}
                this.showOrHideLoader(done: true)
                if let response = resp {
                    if let done = response.result, let message = response.message {
                        this.updateUIWhenAddCard(done: done, message: message)
                    } else {
                        this.updateUIWhenAddCard(done: false, message: "Fail")
                    }
                } else {
                    this.updateUIWhenAddCard(done: false, message: "Fail")
                }
            }
        }
    }
    
    func openFirstCard(card_id: String, card_network_id: String) {
        if let token = AccountManager.shared.token {
            self.showOrHideLoader(done: false)
            CardService.shared.openFirstCard(card_id: card_id, card_network_id: card_network_id, token: token) { [weak self] resp in
                guard let this = self else {return}
                this.showOrHideLoader(done: true)
                if let response = resp {
                    if let done = response.result, let message = response.message {
                        if done {
                            this.getProfile()
                        } else {
                            this.showAlertWithOk(withTitle: "Error", withMessage: message)
                        }
                    } else {
                        this.updateUIWhenAddCard(done: false, message: "Fail")
                    }
                } else {
                    this.updateUIWhenAddCard(done: false, message: "Fail")
                }
            }
        }
    }
    
    func publicAllCard(card_id: String) {
        if let token = AccountManager.shared.token {
            self.showOrHideLoader(done: false)
            CardService.shared.shareAllCard(card_id: card_id, token: token) { [weak self] resp in
                guard let this = self else {return}
                this.showOrHideLoader(done: true)
                if let response = resp {
                    if let done = response.result, let message = response.message {
                        if done {
                            this.getProfile()
                        } else {
                            this.showAlertWithOk(withTitle: "Error", withMessage: message)
                        }
                    } else {
                        this.updateUIWhenAddCard(done: false, message: "Fail")
                    }
                } else {
                    this.updateUIWhenAddCard(done: false, message: "Fail")
                }
            }
        }
    }
    
    
    func deleteNetwork(network: CardNetworkProfile) {
        if let token = AccountManager.shared.token {
            self.showOrHideLoader(done: false)
            CardService.shared.deleteCardNetwork(card_network_id: "\(network.id ?? 0)", token: token) { [weak self] resp in
                guard let this = self else {return}
                this.showOrHideLoader(done: true)
                if let response = resp {
                    if let done = response.result, let message = response.message {
                        if done {
                            this.getProfile()
                        } else {
                            this.showAlertWithOk(withTitle: "Error", withMessage: message)
                        }
                    } else {
                        this.updateUIWhenAddCard(done: false, message: "Fail")
                    }
                } else {
                    this.updateUIWhenAddCard(done: false, message: "Fail")
                }
            }
        }
    }
    
    func editNetwork(network: CardNetworkProfile) {
        if let token = AccountManager.shared.token {
            self.showOrHideLoader(done: false)
            CardService.shared.editCardNetwork(card_id: network.cardID ??  "", social_network_id: network.socialNetworkID ?? "", link: network.link ??  "", status: network.status ?? "", card_network_id: "\(network.id ?? 0)", token: token) { [weak self] resp in
                guard let this = self else {return}
                this.showOrHideLoader(done: true)
                if let response = resp {
                    if let done = response.result, let message = response.message {
                        if done {
                            this.getProfile()
                        } else {
                            this.showAlertWithOk(withTitle: "Error", withMessage: message)
                        }
                    } else {
                        this.updateUIWhenAddCard(done: false, message: "Fail")
                    }
                } else {
                    this.updateUIWhenAddCard(done: false, message: "Fail")
                }
            }
        }
    }
    
    func deactivateNFCTag() {
        if let token = AccountManager.shared.token {
            DispatchQueue.main.async {
                self.showOrHideLoader(done: false)
            }
            AuthenticationService.sharedInstance.deactivateNFCTag(token: token) {[weak self] resp in
                guard let this = self else {return}
                DispatchQueue.main.async {
                    this.showOrHideLoader(done: true)
                }
                if let resp = resp  {
                    if let done = resp.result {
                        if done {
                            this.getProfile()
                        }
                    } else {
                        this.showAlertWithOk(withTitle: "Error", withMessage: "Session expired") {
                            this.expireSession(isExppired: true)
                        }
                        this.privilageView.isHidden = true
                    }
                } else {
                    this.showAlertWithOk(withTitle: "Error", withMessage: "Session expired") {
                        this.expireSession(isExppired: true)
                    }
                    this.privilageView.isHidden = true
                }
            }
        }
    }
    
    func activateNFCTag(nfc_tag: String) {
        if let token = AccountManager.shared.token {
            DispatchQueue.main.async {
                self.showOrHideLoader(done: false)
            }
            AuthenticationService.sharedInstance.activateNFCTag(nfc_tag: nfc_tag, token: token) { [weak self] resp in
                guard let this = self else {return}
                DispatchQueue.main.async {
                    this.showOrHideLoader(done: true)
                }
                if let resp = resp  {
                    if let done = resp.result{
                        if done {
                            this.getProfile()
                        }
                    } else {
                        this.showAlertWithOk(withTitle: "Error", withMessage: "Session expired") {
                            this.expireSession(isExppired: true)
                        }
                        this.privilageView.isHidden = true
                    }
                } else {
                    this.showAlertWithOk(withTitle: "Error", withMessage: "Session expired") {
                        this.expireSession(isExppired: true)
                    }
                    this.privilageView.isHidden = true
                }
            }
        }
    }
    
    
}
