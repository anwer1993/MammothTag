//
//  ContactsViewModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//

import Foundation
import UIKit

extension ContactListViewController {
    
    func getRequestList() {
        if let token = AccountManager.shared.token {
            showOrHideLoader(done: false)
            ContactService.shared.getRequests(token: token) { [weak self] resp in
                guard let this = self else {return}
                this.showOrHideLoader(done: true)
                if let resp = resp {
                    if let done = resp.result, let message = resp.message, let data = resp.data {
                        if done {
                            this.requestList = data
                            this.emptyView.isHidden = !data.isEmpty
                            this.contactsTableView.isHidden = data.isEmpty
                            this.contactsTableView.reloadData()
                        }else {
                            this.showAlertWithOk(withTitle: "Error", withMessage: message)
                        }
                    } else {
                        this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: "SESSION_EXPIRED".localized) {
                            this.expireSession(isExppired: true)
                        }
                    }
                } else {
                    this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: "SESSION_EXPIRED".localized) {
                        this.expireSession(isExppired: true)
                    }
                }
            }
        }
    }
    
    func getContactList() {
        if let token = AccountManager.shared.token {
            showOrHideLoader(done: false)
            ContactService.shared.getContactList(token: token) { [weak self] resp in
                guard let this = self else {return}
                this.showOrHideLoader(done: true)
                if let resp = resp {
                    if let done = resp.result, let message = resp.message, let data = resp.data {
                        if done {
                            this.contactList = data
                            this.emptyView.isHidden = !data.isEmpty
                            this.contactsTableView.isHidden = data.isEmpty
                            this.contactsTableView.reloadData()
                        }else {
                            this.showAlertWithOk(withTitle: "Error", withMessage: message)
                        }
                    } else {
                        this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: "SESSION_EXPIRED".localized) {
                            this.expireSession(isExppired: true)
                        }
                    }
                } else {
                    this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: "SESSION_EXPIRED".localized) {
                        this.expireSession(isExppired: true)
                    }
                }
            }
        }
    }
    
    func deleteRequest(user_id: String) {
        if let token = AccountManager.shared.token {
            showOrHideLoader(done: false)
            ContactService.shared.deleteRequest(user_id: user_id, token: token) { [weak self] resp in
                guard let this = self else {return}
                this.showOrHideLoader(done: true)
                if let resp = resp {
                    if let done = resp.result, let message = resp.message{
                        if done {
                            if this.selectedItem == 0 {
                                this.getContactList()
                            } else {
                                this.getRequestList()
                            }
                        }else {
                            this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: message)
                        }
                    } else {
                        this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: "SESSION_EXPIRED".localized) {
                            this.expireSession(isExppired: true)
                        }
                    }
                } else {
                    this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: "SESSION_EXPIRED".localized) {
                        this.expireSession(isExppired: true)
                    }
                }
            }
        }
    }
    
    func deleteContact(user_id: String) {
        if let token = AccountManager.shared.token {
            showOrHideLoader(done: false)
            ContactService.shared.deleteContact(user_id: user_id, token: token) { [weak self] resp in
                guard let this = self else {return}
                this.showOrHideLoader(done: true)
                if let resp = resp {
                    if let done = resp.result, let message = resp.message{
                        if done {
                            if this.selectedItem == 0 {
                                this.getContactList()
                            } else {
                                this.getRequestList()
                            }
                        }else {
                            this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: message)
                        }
                    } else {
                        this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: "SESSION_EXPIRED".localized) {
                            this.expireSession(isExppired: true)
                        }
                    }
                } else {
                    this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: "SESSION_EXPIRED".localized) {
                        this.expireSession(isExppired: true)
                    }
                }
            }
        }
    }

    func acceptRequest(user_id: String) {
        if let token = AccountManager.shared.token {
            showOrHideLoader(done: false)
            ContactService.shared.acceptRequest(user_id: user_id, token: token) { [weak self] resp in
                guard let this = self else {return}
                this.showOrHideLoader(done: true)
                if let resp = resp {
                    if let done = resp.result, let message = resp.message{
                        if done {
                            if this.selectedItem == 0 {
                                this.getContactList()
                            } else {
                                this.getRequestList()
                            }
                        }else {
                            this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: message)
                        }
                    } else {
                        this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: "SESSION_EXPIRED".localized) {
                            this.expireSession(isExppired: true)
                        }
                    }
                } else {
                    this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: "SESSION_EXPIRED".localized) {
                        this.expireSession(isExppired: true)
                    }
                }
            }
        }
    }
    
    func getUserByNFCTag(nfc_tag: String) {
        if let token = AccountManager.shared.token {
            showOrHideLoader(done: false)
            AuthenticationService.sharedInstance.getUserByNFCTag(nfc_tag: nfc_tag, token: token) {[weak self] resp in
                guard let this = self else {return}
                this.showOrHideLoader(done: true)
                if let resp = resp {
                    if let done = resp.result, let message = resp.message, let data = resp.data{
                        if done {
                            let user_id = data.id ?? 0
                            if this.from == 0 {
                                this.AddUser(user_id: "\(user_id)")
                            } else {
                                Router.shared.push(with: this.navigationController, screen: .ContactDetails(user_id: "\(user_id)"), animated: true)
                            }
                            
                        }else {
                            this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: message)
                        }
                    } else {
                        this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: "SESSION_EXPIRED".localized) {
                            this.expireSession(isExppired: true)
                        }
                    }
                } else {
                    this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: "SESSION_EXPIRED".localized) {
                        this.expireSession(isExppired: true)
                    }
                }
            }
        }
    }
    
    func AddUser(user_id: String) {
        if let token = AccountManager.shared.token {
            showOrHideLoader(done: false)
            AuthenticationService.sharedInstance.addUser(user_id: user_id, token: token) { [weak self] resp in
                guard let this = self else {return}
                this.showOrHideLoader(done: true)
                if let resp = resp {
                    if let done = resp.result, let message = resp.message{
                        if done {
                            this.getContactList()
                        }else {
                            this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: message)
                        }
                    } else {
                        this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: "SESSION_EXPIRED".localized) {
                            this.expireSession(isExppired: true)
                        }
                    }
                } else {
                    this.showAlertWithOk(withTitle: "ERROR".localized, withMessage: "SESSION_EXPIRED".localized) {
                        this.expireSession(isExppired: true)
                    }
                }
            }
        }
    }
    
    
}


extension ContactListViewController: contactProtocol {
    
    func deleteRequest(request: DatumListRequest) {
        let alert = UIAlertController(title: "PLEASE_CONFIRM".localized, message: "DELETE_REQUEST_ALERT".localized, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "CANCEL".localized, style: .cancel)
        let confirmAction = UIAlertAction(title: "DELETE".localized, style: .destructive) { _ in
            self.deleteRequest(user_id: "\(request.id ?? 0)")
        }
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }
    
    func acceptRequest(request: DatumListRequest) {
        acceptRequest(user_id: "\(request.id ?? 0)")
    }
    
    func deleteContact(contact: DatumListContact) {
        let alert = UIAlertController(title: "PLEASE_CONFIRM".localized, message: "DELETE_CONTACT_ALERT".localized, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "CANCEL".localized, style: .cancel)
        let confirmAction = UIAlertAction(title: "DELETE".localized, style: .destructive) { _ in
            self.deleteContact(user_id: "\(contact.id ?? 0)")
        }
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
        
    }
    
    
    
}
