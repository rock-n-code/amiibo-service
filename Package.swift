// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "AmiiboService",
    products: [
        .library(
            name: "AmiiboService",
            targets: [
                "AmiiboService"
            ]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AmiiboService",
            dependencies: [],
            path: "Sources"
        ),
        .testTarget(
            name: "AmiiboServiceTests",
            dependencies: [
                "AmiiboService"
            ],
            path: "Tests"
        ),
    ]
)
