//
//  ContactsViewModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 11/08/2022.
//

import Foundation

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


extension ContactListViewController: contactProtocol {
    
    func deleteRequest(request: DatumListRequest) {
        deleteRequest(user_id: "\(request.id ?? 0)")
    }
    
    func acceptRequest(request: DatumListRequest) {
        acceptRequest(user_id: "\(request.id ?? 0)")
    }
    
    func deleteContact(contact: DatumListContact) {
        deleteContact(user_id: "\(contact.id ?? 0)")
    }
    
    
    
}
