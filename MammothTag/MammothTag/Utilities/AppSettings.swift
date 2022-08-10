//
//  AppSettings.swift
//  MammothTag
//
//  Created by Anwar Hajji on 10/08/2022.
//

import Foundation


enum AppLanguage: String {
    case AR = "ar"
    case EN = "en"
}

struct AppSettings {
    
    var appLanguage : AppLanguage? {
        get {
            let appLang = Locale.preferredLanguages[0]
            return AppLanguage(rawValue: appLang)
        }
    }
    
}
