// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftLimbo",
    products: [
        .executable(name: "SwiftLimbo", targets: ["SwiftWrapper"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(name: "SwiftWrapper",
            dependencies: ["Limbo"]
        ),
        .target(name: "Limbo",
            exclude: ["limbo/sqlite3/examples", "limbo/sqlite3/tests", "limbo/vendored", "limbo/target"],
            linkerSettings: [LinkerSetting.unsafeFlags(["-L./Sources/Limbo/", "-lpthread", "-ldl", "-lm"])],
            plugins: [
                .plugin(name: "LimboSourceGenPlugin")
            ]
        ),
        .plugin(
            name: "LimboSourceGenPlugin",
            capability: .buildTool()
        ),
    ]
)
