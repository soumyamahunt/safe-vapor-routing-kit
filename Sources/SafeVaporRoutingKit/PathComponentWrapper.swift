//
//  File.swift
//  
//
//  Created by Soumya Ranjan Mahunt on 15/11/21.
//

import Foundation

@propertyWrapper
public struct PathComponentWrapper<T: LosslessStringConvertible> {

    public var wrappedValue: String
    public var projectedValue: PathParseContainer<T> {
        return PathParseContainer(key: wrappedValue)
    }

    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
