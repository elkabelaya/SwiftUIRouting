// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUIRouting",
    platforms: [
            .iOS(.v18)
        ],
    products: [
        .library(
            name: "SwiftUIRouting",
            targets: ["SwiftUIRouting"]
        ),
    ],
    targets: [
        .target(
            name: "SwiftUIRouting",
            path: "Sources/SwiftUIRouting"
        ),
        .testTarget(
            name: "SwiftUIRoutingTests",
            dependencies: ["SwiftUIRouting"]
        )
    ],
    swiftLanguageModes: [.v6]
)
