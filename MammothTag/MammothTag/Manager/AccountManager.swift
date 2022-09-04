//
//  AccountManager.swift
//  MammothTag
//
//  Created by Anwar Hajji on 12/08/2022.
//

import Foundation
import UIKit

class AccountManager {
    
    static var shared = AccountManager()
    
    var isActiveNFC: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "isActiveNFC")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isActiveNFCs")
            UserDefaults.standard.synchronize()
        }
    }
    
    var profileMode: ProfileMode? {
        get {
            let mode = UserDefaults.standard.integer(forKey: "profileMode")
            guard let profileMode = ProfileMode(rawValue: mode) else {
                return nil
            }
            return profileMode
        }
        set {
            UserDefaults.standard.set(newValue?.rawValue, forKey: "profileMode")
            UserDefaults.standard.synchronize()
        }
    }
    
    var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "token")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "token")
            UserDefaults.standard.synchronize()
        }
    }
    
    var email: String? {
        get {
            return UserDefaults.standard.string(forKey: "email")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "email")
            UserDefaults.standard.synchronize()
        }
    }
    
    var password: String? {
        get {
            return UserDefaults.standard.string(forKey: "password")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "password")
            UserDefaults.standard.synchronize()
        }
    }
    
    var selectedOption: Int = 0
    
}

enum ProfileMode: Int {
    case Public = 0
    case Private = 1
}


protocol SubViewConroller: UIViewController {
    
    var handleTapWhenDismiss: () -> Void {get set}
    
}
