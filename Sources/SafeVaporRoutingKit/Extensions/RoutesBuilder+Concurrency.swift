//
//  File.swift
//  
//
//  Created by Soumya Ranjan Mahunt on 16/11/21.
//

import Vapor

#if compiler(>=5.5) && canImport(_Concurrency)
@available(macOS 12, iOS 15, watchOS 8, tvOS 15, *)
public extension RoutesBuilder {

    @discardableResult
    func get<Response, ComponentGroup>(
        _ path: PathComponentContainer<ComponentGroup>,
        use closure: @escaping (ParsedRequest<ComponentGroup>) async throws -> Response
    ) -> Route where Response: AsyncResponseEncodable,
                     ComponentGroup: ComponentGroupSource
    {
        return self.get(path.components) { request in
            return try await closure(ParsedRequest<ComponentGroup>(base: request))
        }
    }

    @discardableResult
    func post<Response, ComponentGroup>(
        _ path: PathComponentContainer<ComponentGroup>,
        use closure: @escaping (ParsedRequest<ComponentGroup>) async throws -> Response
    ) -> Route where Response: AsyncResponseEncodable,
                     ComponentGroup: ComponentGroupSource
    {
        return self.post(path.components) { request in
            return try await closure(ParsedRequest<ComponentGroup>(base: request))
        }
    }

    @discardableResult
    func patch<Response, ComponentGroup>(
        _ path: PathComponentContainer<ComponentGroup>,
        use closure: @escaping (ParsedRequest<ComponentGroup>) async throws -> Response
    ) -> Route where Response: AsyncResponseEncodable,
                     ComponentGroup: ComponentGroupSource
    {
        return self.patch(path.components) { request in
            return try await closure(ParsedRequest<ComponentGroup>(base: request))
        }
    }

    @discardableResult
    func put<Response, ComponentGroup>(
        _ path: PathComponentContainer<ComponentGroup>,
        use closure: @escaping (ParsedRequest<ComponentGroup>) async throws -> Response
    ) -> Route where Response: AsyncResponseEncodable,
                     ComponentGroup: ComponentGroupSource
    {
        return self.put(path.components) { request in
            return try await closure(ParsedRequest<ComponentGroup>(base: request))
        }
    }

    @discardableResult
    func delete<Response, ComponentGroup>(
        _ path: PathComponentContainer<ComponentGroup>,
        use closure: @escaping (ParsedRequest<ComponentGroup>) async throws -> Response
    ) -> Route where Response: AsyncResponseEncodable,
                     ComponentGroup: ComponentGroupSource
    {
        return self.delete(path.components) { request in
            return try await closure(ParsedRequest<ComponentGroup>(base: request))
        }
    }

    @discardableResult
    func on<Response, ComponentGroup>(
        _ method: HTTPMethod,
        _ path: PathComponentContainer<ComponentGroup>,
        body: HTTPBodyStreamStrategy = .collect,
        use closure: @escaping (ParsedRequest<ComponentGroup>) async throws -> Response
    ) -> Route where Response: AsyncResponseEncodable,
                     ComponentGroup: ComponentGroupSource
    {
        return self.on(method, path.components, body: body, use: { request in
            return try await closure(ParsedRequest<ComponentGroup>(base: request))
        })
    }
}
#endif
