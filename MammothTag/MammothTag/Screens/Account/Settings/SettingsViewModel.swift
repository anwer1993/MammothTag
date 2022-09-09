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
                            this.showAlert(withTitle: "ERROR".localized, withMessage: message)
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
