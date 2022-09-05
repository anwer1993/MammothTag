//
//  SettingsViewModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 18/08/2022.
//

import Foundation

struct SettingsViewModel {
    
    
    var bindViewModelDataToController: (String?,DataClassProfile?, String) -> () = {_,_,_  in}
    
    func getProfile() {
        if let token = AccountManager.shared.token {
            AuthenticationService.sharedInstance.getUserProfile(token: token) { data in
                if let data = data {
                    if data.result == true {
                        if let resp = data.data {
                            bindViewModelDataToController("success", resp, "")
                        } else if let message = data.message {
                            bindViewModelDataToController("success",nil, message)
                            print("Error: \(message)")
                        }
                    } else if let message = data.message {
                        bindViewModelDataToController("success", nil, message)
                        print("Error: \(message)")
                    }
                } else {
                    bindViewModelDataToController(nil, nil, "")
                }
            }
        }
    }
    
    
    
}
