//
//  TermsAndConditionViewModel.swift
//  MammothTag
//
//  Created by Anwar Hajji on 10/08/2022.
//

import Foundation

struct TermsAndConditionsViewModel {
    
    var bindViewModelDataToController: (SettingsModel) -> () = {_ in}
    
//    private(set) var settingsModel = SettingsModel(terms: "", conditions: "") {
//        didSet {
//            self.bindViewModelDataToController(self.settingsModel)
//        }
//    }
//    
//    mutating func getTermsAndCondditions () {
//        AuthenticationService.sharedInstance.getTermsAndCondition { SettingsModel in
//            self.settingsModel = SettingsModel
//        }
//    }
    
}
