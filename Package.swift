// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "OrderedSet",
    products: [
        .library(
            name: "OrderedSet",
            targets: ["OrderedSet"]
        ),
    ],
    targets: [
        .target(
            name: "OrderedSet",
            dependencies: []
        ),
        .testTarget(
            name: "OrderedSetTests",
            dependencies: ["OrderedSet"]
        ),
    ]
)
