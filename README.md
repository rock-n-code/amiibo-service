[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frock-n-code%2Famiibo-service%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/rock-n-code/amiibo-service)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frock-n-code%2Famiibo-service%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/rock-n-code/amiibo-service)

# Amiibo Service

A library written entirely with [Swift](https://www.swift.org) that provides everything the developer needs to interact with the [Amiibo API](https://www.amiiboapi.org) backend service.

## Installation

To use this library, add it as a dependency in the `Package.swift` file:

```swift
let package = Package(
    // name, platforms, products, etc.
    dependencies: [
        .package(url: "https://github.com/rock-n-code/amiibo-service", from: "1.4.1"),
        // other dependencies
    ],
    targets: [
        .target(
            name: "SomeTarget", 
            dependencies: [
                .product(name: "AmiiboService", package: "amiibo-service"),
            ]
        )
        // other targets
    ]
)
```

It is also possible to use this library with your app in Xcode by adding it as a dependency in your Xcode project.

> [!IMPORTANT]
> Swift 5.10 or higher is required in order to build this library.

## Usage

```swift
import AmiiboService

let service = AmiiboService()

// Fetch all amiibos
let amiibos = try await service.getAmiibos()

// Fetch amiibos filtered by name
let zeldaAmiibos = try await service.getAmiibos(.init(name: "zelda"))

// Fetch amiibo series, types, game characters, and game series
let series = try await service.getAmiiboSeries()
let types = try await service.getAmiiboTypes()
let characters = try await service.getGameCharacters()
let gameSeries = try await service.getGameSeries()

// Fetch the last updated timestamp
let lastUpdated = try await service.getLastUpdated()
```

## Caching

The [Amiibo API](https://www.amiiboapi.org) recommends that consumers who call the API regularly implement caching on their systems. Pass a custom `URLSessionTransport` with a cache-configured `URLSession` to `AmiiboLiveClient`:

```swift
import OpenAPIURLSession

let configuration = URLSessionConfiguration.default

configuration.urlCache = URLCache(
    memoryCapacity: 5_000_000,
    diskCapacity: 50_000_000
)

let transport = URLSessionTransport(
    configuration: .init(
        session: URLSession(configuration: configuration)
    )
)

let service = AmiiboService(
    client: AmiiboLiveClient(transport: transport)
)
```

## Testing

The `AmiiboClient` protocol enables creating custom mock clients for unit testing without network calls. Conform to `AmiiboClient` and inject it into `AmiiboService` via its `init(client:)` initializer:

```swift
import AmiiboService

struct MyMockClient: AmiiboClient {
    var error: AmiiboServiceError?

    func getAmiibos(
        by filter: AmiiboFilter
    ) async throws(AmiiboServiceError) -> [Amiibo] {
        if let error { throw error }
        return []
    }

    // Implement remaining protocol requirements...
}

let service = AmiiboService(client: MyMockClient())
```

## Documentation

Please refer to the [online documentation](https://rock-n-code.github.io/amiibo-service/documentation/amiiboservice/) for further information about this library.
