//
//  File.swift
//  
//
//  Created by Soumya Ranjan Mahunt on 14/11/21.
//

import Foundation
import Vapor
import SafeVaporRoutingKit

struct CourseRoute: ComponentGroupSource {
    typealias Component = PathComponentWrapper

    let api = "api"
    let courses = "courses"
    @Component<Int> var id = "id"
}

struct Course: Codable {
    static var courses: Set<Self> = []
    
    let id: Int
    var name: String
}

extension Course: Hashable {

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Course: Content {
    
}

extension Course: Validatable {

    struct CourseNameData: Codable, Validatable {
        let name: String

        static func validations(_ validations: inout Validations) {
            validations.add(.init(with: CodingKeys.name),
                            as: String.self,
                            is: .count(3...) && .alphanumeric)
        }
    }

    static func validations(_ validations: inout Validations) {
        CourseNameData.validations(&validations)
    }
}

extension Course {

    static func addCourse(for req: Request) throws -> Self {
        try CourseNameData.validate(content: req)
        let course = try req.content.decode(Self.self)
        return try Self.courses.insert(course: course)
    }
}

extension Course {

    typealias CourseRequest = ParsedRequest<CourseRoute>

    static func getCourse(for req: CourseRequest) throws -> Self {
        let id = try req.parameters.$id
        let course = try Self.courses.first(byId: id)
        return course
    }
}

extension Course {

    static func updateCourse(for req: CourseRequest) throws -> Self {
        let id = try req.parameters.$id
        try CourseNameData.validate(content: req.base)
        let courseData = try req.content.decode(CourseNameData.self)
        return try Self.courses.update(courseId: id, name: courseData.name)
    }
}

extension Course {

    static func deleteCourse(for req: CourseRequest) throws -> Self {
        let id = try req.parameters.$id
        let index = try Self.courses.firstIndex(byId: id)
        let course = Self.courses.remove(at: index)
        return course
    }
}

extension Course {

    static func addCourseRoutes(on route: RoutesBuilder) {
        typealias PATH = PathComponentContainer<CourseRoute>
        let courses = route.grouped(PATH.courses)

        courses.post(use: addCourse)
        courses.get { _ in Self.courses.map { $0 } }
        courses.get(PATH.$id, use: getCourse)
        courses.put(PATH.$id, use: updateCourse)
        courses.delete(PATH.$id, use: deleteCourse)
    }
}

extension Abort {
    static let invalidId = Abort(.badRequest, reason: "Expecting integer as id")

    static let noCourse = Abort(.badRequest,
                                reason: "No course present with given id")

    static let coursePresent = Abort(.badRequest,
                                     reason: "Course already present with given id")
}

extension ValidationKey {

    init(with key: CodingKey) {
        self = .string(key.stringValue)
    }
}

extension Set where Element == Course {

    func firstIndex(byId id: Int) throws -> Index {
        guard let index = firstIndex(where: { $0.id == id }) else {
            throw Abort.noCourse
        }
        return index
    }

    func first(byId id: Int) throws -> Element {
        guard let item = first(where: { $0.id == id }) else {
            throw Abort.noCourse
        }
        return item
    }

    @discardableResult
    mutating func insert(course: Element) throws -> Element {
        let (inserted, newCourse) = insert(course)
        guard inserted else { throw Abort.coursePresent }
        return newCourse
    }

    @discardableResult
    mutating func update(courseId id: Int, name: String) throws -> Element {
        let course = Course(id: id, name: name)
        guard update(with: course) != nil else { throw Abort.invalidId }
        return course
    }
}
