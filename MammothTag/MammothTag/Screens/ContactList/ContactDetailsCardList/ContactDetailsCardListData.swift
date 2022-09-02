//
//  ContactDetailsCardListData.swift
//  MammothTag
//
//  Created by Anwar Hajji on 02/09/2022.
//

import Foundation
import UIKit

extension ContactDetailsCardListViewController {
    
    
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
                            if let dob = data.birthday?.dateFromString, let age = dob.age {
                                this.ageLbl.text = "\(age)"
                            }
                            this.countryLbl.text = "Tunisia"
                            this.cards = data.cards?.filter({$0.privacy == "1"}) ?? []
                            this.cardsTableView.isHidden = this.cards.isEmpty
                            this.emptyDisLbl.isHidden = !this.cards.isEmpty
                            this.cardsTableView.reloadData()
                        }else {
                            this.showAlertWithOk(withTitle: "Error", withMessage: message)
                        }
                    } else {
                        this.showAlertWithOk(withTitle: "Error", withMessage: "An error occured please try again"){
                            this.expireSession(isExppired: true)
                        }
                    }
                } else {
                    this.showAlertWithOk(withTitle: "Error", withMessage: "An error occured please try again"){
                        this.expireSession(isExppired: true)
                    }
                }
            }
        }
    }
    
}
