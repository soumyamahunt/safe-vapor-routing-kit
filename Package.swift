// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "safe-vapor-routing-kit",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "SafeVaporRoutingKit",
            targets: ["SafeVaporRoutingKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/routing-kit.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "SafeVaporRoutingKit",
            dependencies: [
                .product(name: "RoutingKit", package: "routing-kit"),
                .product(name: "Vapor", package: "vapor")
            ]
        ),
        .testTarget(
            name: "SafeVaporRoutingKitTests",
            dependencies: ["SafeVaporRoutingKit"]),
    ]
)
