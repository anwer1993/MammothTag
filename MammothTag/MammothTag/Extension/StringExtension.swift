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
    
    var dateFromString: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
    
}


extension Optional where Wrapped == String {
    
    var isEmptyString: Bool {
        return self == nil || self == "" || self == " "
    }
}
