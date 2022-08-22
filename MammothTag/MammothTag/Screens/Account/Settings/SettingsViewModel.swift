//
//  SettingsViewModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 18/08/2022.
//

import Foundation

struct SettingsViewModel {
    
    
    var bindViewModelDataToController: (ProfileModel?, String) -> () = {_,_  in}
    
    func getProfile() {
        if let token = AccountManager.shared.token {
            AuthenticationService.sharedInstance.getUserProfile(token: token) { data in
                if data.result == true {
                    if let resp = data.data {
                        bindViewModelDataToController(resp, "")
                    } else if let message = data.message {
                        bindViewModelDataToController(nil, message)
                        print("Error: \(message)")
                    }
                } else if let message = data.message {
                    bindViewModelDataToController(nil, message)
                    print("Error: \(message)")
                }
            }
        }
    }
    
    
    
}
