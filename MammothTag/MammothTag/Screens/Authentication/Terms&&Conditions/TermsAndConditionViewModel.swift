//
//  TermsAndConditionViewModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 10/08/2022.
//

import Foundation

struct TermsAndConditionsViewModel {
    
    var bindViewModelDataToController: (Bool, SettingsModel?, String) -> () = {_,_,_ in}
    
    func getTerms() {
        AuthenticationService.sharedInstance.getSettings { response in
            if let done = response.result, let message = response.message {
                if done {
                    self.bindViewModelDataToController(true, response.data, "")
                } else {
                    self.bindViewModelDataToController(false, nil, message)
                }
            } else {
                
            }
        }
    }
}
