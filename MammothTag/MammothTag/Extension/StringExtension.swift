//
//  StringExtension.swift
//  MammothTag
//
//  Created by Anwar Hajji on 10/08/2022.
//

import Foundation

extension String {
    
    var localized: String {
        return LocalizationSystem.sharedInstance.localizedStringForKey(key: self, comment: "")
//        return NSLocalizedString(self, comment: "")
    }
    
    var isEmptyString: Bool {
        return self == "" || self == " "
    }
    
    var dateFromString: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
    
    var stringFromDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self) ?? Date()
        return dateFormatter.string(from: date)
    }
    
    
    func subString() -> (String, String){
        let str = self
        if str.contains(" ") {
            let index = str.firstIndex(of: " ")!
            let first_name_end_index = str.index(index, offsetBy: -1)
            let last_name_start_index = str.index(index, offsetBy: 1)
            var first_name = String(str [...first_name_end_index])
            let last_name  = String(str [last_name_start_index...])
            return (first_name, last_name)
        }
        return ("","")
    }
}


extension Optional where Wrapped == String {
    
    var isEmptyString: Bool {
        return self == nil || self == "" || self == " "
    }
}
