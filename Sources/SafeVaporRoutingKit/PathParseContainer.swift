//
//  File.swift
//  
//
//  Created by Soumya Ranjan Mahunt on 15/11/21.
//

import Foundation

public struct PathParseContainer<T: LosslessStringConvertible> {

    let key: String
    var component: String { ":\(key)" }

    public init(key: String) {
        self.key = key
    }
}
