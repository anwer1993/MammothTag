//
//  SettingsViewModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 18/08/2022.
//

import Foundation


extension SettingsViewController {
    func getProfile() {
        if let profile = AccountManager.shared.profile {
            updateUIWhenGetProfile(profile: profile)
        } else if let token = AccountManager.shared.token {
            AuthenticationService.sharedInstance.getUserProfile(token: token) {[weak self] data in
                guard let this = self else {return}
                if let data = data {
                    if let resp = data.data , let done = data.result{
                        if data.result == true {
                            this.updateUIWhenGetProfile(profile: resp)
                        } else if let message = data.message {
                            this.showAlert(withTitle: "Error", withMessage: message)
                        }
                    } else {
                        this.showAlertWithOk(withTitle: "Error", withMessage: "An error occured please try again") {
                            this.expireSession(isExppired: true)
                        }
                    }
                } else {
                    this.showAlertWithOk(withTitle: "Error", withMessage: "An error occured please try again") {
                        this.expireSession(isExppired: true)
                    }
                }
            }
        }
    }
    
}
//
//struct SettingsViewModel {
//
//
//    var bindViewModelDataToController: (String?,DataClassProfile?, String) -> () = {_,_,_  in}
//
//    func getProfile() {
//        if let profile = AccountManager.shared.profile {
//            bindViewModelDataToController("success", profile, "")
//        } else if let token = AccountManager.shared.token {
//            AuthenticationService.sharedInstance.getUserProfile(token: token) { data in
//                if let data = data {
//                    if data.result == true {
//                        if let resp = data.data {
//                            bindViewModelDataToController("success", resp, "")
//                        } else if let message = data.message {
//                            bindViewModelDataToController("success",nil, message)
//                            print("Error: \(message)")
//                        }
//                    } else if let message = data.message {
//                        bindViewModelDataToController("success", nil, message)
//                        print("Error: \(message)")
//                    }
//                } else {
//                    bindViewModelDataToController(nil, nil, "")
//                }
//            }
//        }
//    }
//
//
//
//
//
//}
