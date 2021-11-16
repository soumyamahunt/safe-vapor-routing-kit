//
//  File.swift
//  
//
//  Created by Soumya Ranjan Mahunt on 15/11/21.
//

import RoutingKit

public extension Router {

    mutating func register<ComponentGroup: ComponentGroupSource>(
        _ output: Output, at path: PathComponentContainer<ComponentGroup>
    ) {
        self.register(output, at: path.components)
    }

    func route<ComponentGroup: ComponentGroupSource>(
        path: [String],
        parameters: inout ParsedParameters<ComponentGroup>
    ) -> Output? {
        return self.route(path: path, parameters: &parameters.base)
    }
}
