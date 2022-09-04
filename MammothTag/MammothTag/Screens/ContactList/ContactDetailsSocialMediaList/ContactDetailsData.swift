//
//  ContactDetailsData.swift
//  MammothTag
//
//  Created by Anwar Hajji on 04/09/2022.
//

import Foundation
import Kingfisher


extension ContactDetailsViewController {
    
    
    func getUser() {
        if let token = AccountManager.shared.token {
            showOrHideLoader(done: false)
            ContactService.shared.getUserProfile(user_id: user_id, token: token) { [weak self] resp in
                guard let this = self else {
                    return
                }
                this.showOrHideLoader(done: true)
                if let resp = resp {
                    if let done = resp.result, let message = resp.message, let data = resp.data {
                        if done {
                            this.userData = data
                            this.profileNameLbl.text = "\(data.name ?? "") \(data.username ?? "")"
                            this.emailLbl.text = data.email
                            if let picture = data.picture, picture.isEmptyString == false {
                                let url = URL(string: picture)
                                this.profileImage.kf.setImage(with: url)
                            } else {
                                this.profileImage.image = UIImage(named: "avatar")
                            }
                            this.cards = data.cards?.filter({$0.privacy == "0"}) ?? []
                            if this.selectedCard == nil {
                                this.selectedCard = this.cards.first
                            } else {
                                this.selectedCard = this.cards.first(where: {$0.id == this.selectedCard?.id})

                            }
                            if this.selectedCard == nil {
                                this.selectedCardView.isHidden = true
                                this.emptyListLbl.text = "EMPTY_DETAILS".localized
                            } else {
                                this.selectedCardView.isHidden = false
                                this.selectedCardName.text = this.selectedCard?.name ?? "Unknown card"
                            }
                            
                            let networks = this.selectedCard?.cardNetworks ?? []
                            if networks.contains(where: {$0.isOpenFirst == "1"}) {
                                if let item = networks.first(where: {$0.isOpenFirst == "1"}) {
                                    this.cardNetworkList = [item]
                                }
                            } else {
                                this.cardNetworkList = networks
                            }
                            
                            this.socielMediaCollectionView.isHidden = this.cardNetworkList.isEmpty
                            this.emptyListLbl.isHidden = !this.cardNetworkList.isEmpty
                            this.socielMediaCollectionView.reloadData()
                            this.cardsTableView.reloadData()
                        }else {
                            this.showAlertWithOk(withTitle: "Error", withMessage: message)
                        }
                    } else {
                        this.showAlertWithOk(withTitle: "Error", withMessage: "Session expired"){
                            this.expireSession(isExppired: true)
                        }
                    }
                } else {
                    this.showAlertWithOk(withTitle: "Error", withMessage: "Session expired"){
                        this.expireSession(isExppired: true)
                    }
                }
            }
        }
    }
    
}
