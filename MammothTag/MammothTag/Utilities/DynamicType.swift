//
//  DynamicType.swift
//  MammothTag
//
//  Created by Anwar Hajji on 08/08/2022.
//

import Foundation

class Dynamic<T> {
    
    var bind :(T) -> () = { _ in }
    
    var value :T? {
        didSet {
            bind(value!)
        }
    }
    
    init(_ v :T) {
        value = v
    }
    
}

