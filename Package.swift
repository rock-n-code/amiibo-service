// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "AmiiboService",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "AmiiboService",
            targets: [
                "AmiiboService"
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/rock-n-code/swift-libs.git", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "AmiiboService",
            dependencies: [
                .product(name: "SwiftLibs", package: "swift-libs")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "AmiiboServiceTests",
            dependencies: [
                "AmiiboService",
                .product(name: "SwiftLibs", package: "swift-libs")
            ],
            path: "Tests"
        ),
    ]
)
