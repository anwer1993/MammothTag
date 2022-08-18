//
//  StringExtension.swift
//  MammothTag
//
//  Created by Anwar Hajji on 10/08/2022.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var isEmptyString: Bool {
        return self == "" || self == " "
    }
    
    
    
}


extension Optional where Wrapped == String {
    
    var isEmptyString: Bool {
        return self == nil || self == "" || self == " "
    }
}
