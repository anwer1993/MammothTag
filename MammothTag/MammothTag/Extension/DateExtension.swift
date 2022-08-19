//
//  DateExtension.swift
//  MammothTag
//
//  Created by Anwar Hajji on 19/08/2022.
//

import Foundation


extension Date {
    
    
    var age: Int? {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year
    }
    
}
