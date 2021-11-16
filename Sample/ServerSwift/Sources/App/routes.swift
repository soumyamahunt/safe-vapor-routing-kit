import Vapor
import SafeVaporRoutingKit

struct GreetingRoute: ComponentGroupSource {
    typealias Component = PathComponentWrapper

    let hello = "hello"
    @Component<String> var name = "name"
}


func routes(_ app: Application) throws {
    typealias PATH = PathComponentContainer<GreetingRoute>

    app.get { req in
        return "It works!"
    }

    app.get(PATH.hello) { req -> String in
        return "Hello, world!"
    }

    app.get(PATH.hello.$name) { req -> String in
        let name = try req.parameters.$name
        return "Hello, \(name)!"
    }

    let apis = app.grouped(PathComponentContainer<CourseRoute>.api)
    Course.addCourseRoutes(on: apis)
}
