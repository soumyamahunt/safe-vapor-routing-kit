//
//  File.swift
//  
//
//  Created by Soumya Ranjan Mahunt on 15/11/21.
//

import Vapor

@dynamicMemberLookup
public struct ParsedParameters<ComponentGroup: ComponentGroupSource> {

    public var base: Parameters
}

public extension ParsedParameters {

    typealias PATH = PathComponentContainer<ComponentGroup>

    subscript(dynamicMember member: KeyPath<ComponentGroup, String>) -> String? {
        get { base.get(PATH.allData[keyPath: member]) }
        set { base.set(PATH.allData[keyPath: member], to: newValue) }
    }

    subscript<T: LosslessStringConvertible>(
        dynamicMember member: KeyPath<ComponentGroup, String>
    ) -> T? {
        get { base.get(PATH.allData[keyPath: member]) }
        set { base.set(PATH.allData[keyPath: member], to: newValue?.description) }
    }
}

public extension ParsedParameters {

    subscript(
        dynamicMember member: KeyPath<ComponentGroup, PathParseContainer<String>>
    ) -> String {
        get throws {
            guard let item = base.get(PATH.allData[keyPath: member].key) else {
                throw Abort(.internalServerError)
            }
            return item
        }
    }

    subscript<T: LosslessStringConvertible>(
        dynamicMember member: KeyPath<ComponentGroup, PathParseContainer<T>>
    ) -> T {
        get throws {
            guard let item: T = base.get(PATH.allData[keyPath: member].key) else {
                throw Abort(.badRequest)
            }
            return item
        }
    }
}

public extension ParsedParameters {

    subscript<T>(dynamicMember member: KeyPath<Parameters, T>) -> T {
        get { return base[keyPath: member] }
    }

    subscript<T>(dynamicMember member: WritableKeyPath<Parameters, T>) -> T {
        get { return base[keyPath: member] }
        set { base[keyPath: member] = newValue }
    }

    subscript<T>(
        dynamicMember member: ReferenceWritableKeyPath<Parameters, T>
    ) -> T {
        get { return base[keyPath: member] }
        set { base[keyPath: member] = newValue }
    }
}
