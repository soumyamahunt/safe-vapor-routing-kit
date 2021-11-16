//
//  File.swift
//  
//
//  Created by Soumya Ranjan Mahunt on 15/11/21.
//

import Vapor

public extension RoutesBuilder {

    func grouped<ComponentGroup>(
        _ path: PathComponentContainer<ComponentGroup>
    ) -> RoutesBuilder {
        return self.grouped(path.components)
    }

    func group<ComponentGroup>(
        _ path: PathComponentContainer<ComponentGroup>,
        configure: (RoutesBuilder) throws -> ()) rethrows {
            try self.group(path.components, configure: configure)
    }
}

public extension RoutesBuilder {

    @discardableResult
    func get<Response, ComponentGroup>(
        _ path: PathComponentContainer<ComponentGroup>,
        use closure: @escaping (ParsedRequest<ComponentGroup>) throws -> Response
    ) -> Route where Response: ResponseEncodable,
                     ComponentGroup: ComponentGroupSource
    {
        return self.get(path.components) { request in
            return try closure(ParsedRequest<ComponentGroup>(base: request))
        }
    }

    @discardableResult
    func post<Response, ComponentGroup>(
        _ path: PathComponentContainer<ComponentGroup>,
        use closure: @escaping (ParsedRequest<ComponentGroup>) throws -> Response
    ) -> Route where Response: ResponseEncodable,
                     ComponentGroup: ComponentGroupSource
    {
        return self.post(path.components) { request in
            return try closure(ParsedRequest<ComponentGroup>(base: request))
        }
    }

    @discardableResult
    func patch<Response, ComponentGroup>(
        _ path: PathComponentContainer<ComponentGroup>,
        use closure: @escaping (ParsedRequest<ComponentGroup>) throws -> Response
    ) -> Route where Response: ResponseEncodable,
                     ComponentGroup: ComponentGroupSource
    {
        return self.patch(path.components) { request in
            return try closure(ParsedRequest<ComponentGroup>(base: request))
        }
    }

    @discardableResult
    func put<Response, ComponentGroup>(
        _ path: PathComponentContainer<ComponentGroup>,
        use closure: @escaping (ParsedRequest<ComponentGroup>) throws -> Response
    ) -> Route where Response: ResponseEncodable,
                     ComponentGroup: ComponentGroupSource
    {
        return self.put(path.components) { request in
            return try closure(ParsedRequest<ComponentGroup>(base: request))
        }
    }

    @discardableResult
    func delete<Response, ComponentGroup>(
        _ path: PathComponentContainer<ComponentGroup>,
        use closure: @escaping (ParsedRequest<ComponentGroup>) throws -> Response
    ) -> Route where Response: ResponseEncodable,
                     ComponentGroup: ComponentGroupSource
    {
        return self.delete(path.components) { request in
            return try closure(ParsedRequest<ComponentGroup>(base: request))
        }
    }

    @discardableResult
    func on<Response, ComponentGroup>(
        _ method: HTTPMethod,
        _ path: PathComponentContainer<ComponentGroup>,
        body: HTTPBodyStreamStrategy = .collect,
        use closure: @escaping (ParsedRequest<ComponentGroup>) throws -> Response
    ) -> Route where Response: ResponseEncodable,
                     ComponentGroup: ComponentGroupSource
    {
        return self.on(method, path.components, body: body, use: { request in
            return try closure(ParsedRequest<ComponentGroup>(base: request))
        })
    }
}

@available(macOS 12, iOS 15, watchOS 8, tvOS 15, *)
public extension RoutesBuilder {

    @discardableResult
    func webSocket<ComponentGroup: ComponentGroupSource>(
        _ path: PathComponentContainer<ComponentGroup>,
        maxFrameSize: WebSocketMaxFrameSize = .`default`,
        shouldUpgrade: @escaping ((Request) async throws -> HTTPHeaders?) = { _ in [:] },
        onUpgrade: @escaping (Request, WebSocket) async -> ()
    ) -> Route {
        return self.webSocket(path.components,
                              maxFrameSize: maxFrameSize,
                              shouldUpgrade: shouldUpgrade,
                              onUpgrade: onUpgrade)
    }
}
