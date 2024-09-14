// swift-tools-version: 5.9

//===----------------------------------------------------------------------===
//
// This source file is part of the AmiiboAPI open source project
//
// Copyright (c) 2024 Röck+Cöde VoF. and the AmiiboAPI project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE for license information
// See CONTRIBUTORS for the list of AmiiboAPI project authors
//
//===----------------------------------------------------------------------===

import PackageDescription

let package = Package(
    name: AmiiboAPI.package,
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .visionOS(.v1),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: AmiiboAPI.package,
            targets: [
                AmiiboAPI.target
            ]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-openapi-generator.git",
            from: "1.3.0"
        ),
        .package(
            url: "https://github.com/apple/swift-openapi-runtime",
            from: "1.5.0"
        ),
        .package(
            url: "https://github.com/apple/swift-openapi-urlsession",
            from: "1.0.2"
        )
    ],
    targets: [
        .target(
            name: AmiiboAPI.target,
            dependencies: [
                .product(
                    name: "OpenAPIRuntime",
                    package: "swift-openapi-runtime"
                ),
                .product(
                    name: "OpenAPIURLSession",
                    package: "swift-openapi-urlsession"
                )
            ],
            path: "Sources",
            plugins: [
                .plugin(
                    name: "OpenAPIGenerator",
                    package: "swift-openapi-generator"
                ),
            ]
        ),
        .testTarget(
            name: AmiiboAPI.test,
            dependencies: [
                .byName(name: AmiiboAPI.target)
            ],
            path: "Tests"
        ),
    ]
)

// MARK: - Constants

enum AmiiboAPI {
    static let package = "amiibo-api"
    static let target = "AmiiboAPI"
    static let test = "\(AmiiboAPI.target)Tests"
}
