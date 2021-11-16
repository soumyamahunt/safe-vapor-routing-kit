//
//  File.swift
//  
//
//  Created by Soumya Ranjan Mahunt on 15/11/21.
//

import RoutingKit

public protocol ComponentGroupSource {
    init()
}

@dynamicMemberLookup
public struct PathComponentContainer<ComponentGroup: ComponentGroupSource> {

    static var allData: ComponentGroup { ComponentGroup() }
    let components: [PathComponent]
}

public extension PathComponentContainer {

    static subscript(
        dynamicMember member: KeyPath<ComponentGroup, String>
    ) -> PathComponentContainer {
        return PathComponentContainer(
            components: [
                PathComponent(stringLiteral: Self.allData[keyPath: member])
            ]
        )
    }

    subscript(
        dynamicMember member: KeyPath<ComponentGroup, String>
    ) -> PathComponentContainer {
        return PathComponentContainer(
            components: components
            + [PathComponent(stringLiteral: Self.allData[keyPath: member])]
        )
    }

    static subscript<T: LosslessStringConvertible>(
        dynamicMember member: KeyPath<ComponentGroup, PathParseContainer<T>>
    ) -> PathComponentContainer {
        return PathComponentContainer(
            components: [
                PathComponent(
                    stringLiteral: Self.allData[keyPath: member].component
                )
            ]
        )
    }

    subscript<T: LosslessStringConvertible>(
        dynamicMember member: KeyPath<ComponentGroup, PathParseContainer<T>>
    ) -> PathComponentContainer {
        return PathComponentContainer(
            components: components
            + [
                PathComponent(
                    stringLiteral: Self.allData[keyPath: member].component
                )
            ]
        )
    }
}
