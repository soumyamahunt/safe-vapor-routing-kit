//
//  File.swift
//  
//
//  Created by Soumya Ranjan Mahunt on 15/11/21.
//

import Vapor

@dynamicMemberLookup
public struct ParsedRequest<ComponentGroup: ComponentGroupSource> {

    public var base: Request
}

public extension ParsedRequest {

    subscript(
        dynamicMember member: KeyPath<Request, Parameters>
    ) -> ParsedParameters<ComponentGroup> {
        get { return ParsedParameters(base: base[keyPath: member]) }
    }

    subscript(
        dynamicMember member: WritableKeyPath<Request, Parameters>
    ) -> ParsedParameters<ComponentGroup> {
        get { return ParsedParameters(base: base[keyPath: member]) }
        set { base[keyPath: member] = base.parameters }
    }

    subscript(
        dynamicMember member: ReferenceWritableKeyPath<Request, Parameters>
    ) -> ParsedParameters<ComponentGroup> {
        get { return ParsedParameters(base: base[keyPath: member]) }
        set { base[keyPath: member] = base.parameters }
    }
}

public extension ParsedRequest {

    subscript<T>(dynamicMember member: KeyPath<Request, T>) -> T {
        get { return base[keyPath: member] }
    }

    subscript<T>(dynamicMember member: WritableKeyPath<Request, T>) -> T {
        get { return base[keyPath: member] }
        set { base[keyPath: member] = newValue }
    }

    subscript<T>(dynamicMember member: ReferenceWritableKeyPath<Request, T>) -> T {
        get { return base[keyPath: member] }
        set { base[keyPath: member] = newValue }
    }
}
