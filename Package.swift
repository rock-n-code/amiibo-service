// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: AmiiboAPI.package,
    products: [
        .library(
            name: AmiiboAPI.package,
            targets: [
                AmiiboAPI.target
            ]
        )
    ],
    targets: [
        .target(
            name: AmiiboAPI.target,
            path: "Sources"
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
