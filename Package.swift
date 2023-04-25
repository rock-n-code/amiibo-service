// swift-tools-version: 5.5
//
// This source file is part of the AmiiboService open source project
//
// Copyright (c) 2023 Röck+Cöde VoF. and the AmiiboService project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of AmiiboService project authors
//

import PackageDescription

let package = Package(
    name: "AmiiboService",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
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
        .package(url: "https://github.com/rock-n-code/swift-libs.git", from: "0.1.0"),
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.1.0"),
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
