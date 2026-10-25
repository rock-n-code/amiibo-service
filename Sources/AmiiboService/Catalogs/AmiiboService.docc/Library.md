# ``AmiiboService``

A Swift client for the Amiibo API.

## Overview

`AmiiboService` fetches data from the [Amiibo API](https://www.amiiboapi.org) and returns it as Swift models.

``AmiiboService`` offers one method per resource: each takes a typed filter, returns sorted models, and throws ``AmiiboServiceError``.

## Installation

Add the package and the `AmiiboService` product to `Package.swift`:

```swift
let package = Package(
    // name, platforms, products, etc.
    dependencies: [
        .package(url: "https://github.com/rock-n-code/amiibo-service", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "SomeTarget",
            dependencies: [
                .product(name: "AmiiboService", package: "amiibo-service"),
            ]
        ),
    ]
)
```

In Xcode, add the package URL under **File › Add Package Dependencies…**.

> Important: Requires Swift 6.2 or later, and iOS 13, macOS 10.15, tvOS 13, visionOS 1, or watchOS 6 or later.

## Usage

Create an ``AmiiboService`` and call its methods. When you omit the filter, the method returns every item:

```swift
import AmiiboService

let service = AmiiboService()

// All amiibos
let amiibos = try await service.getAmiibos()

// Amiibos whose name contains "zelda"
let zeldaAmiibos = try await service.getAmiibos(.init(name: "zelda"))

// Amiibo series, types, game characters, and game series
let series = try await service.getAmiiboSeries()
let types = try await service.getAmiiboTypes()
let characters = try await service.getGameCharacters()
let gameSeries = try await service.getGameSeries()

// Date of the last data update (UTC)
let lastUpdated = try await service.getLastUpdated()
```

Results are sorted in ascending order by ``Amiibo/identifier`` or by `key`.

## Error handling

Every method throws ``AmiiboServiceError``. When nothing matches, ``AmiiboService/getAmiibos(_:)`` returns an empty array, while the other list methods throw ``AmiiboServiceError/notFound``:

```swift
do throws(AmiiboServiceError) {
    let series = try await service.getAmiiboSeries(.init(key: "0x01"))
} catch .notFound {
    // No amiibo series has this key.
} catch {
    // .badRequest, .cancelled, .decoding, .notAvailable, .undocumented, or .unknown
}
```

## Caching

The library has no built-in cache, and the Amiibo API asks regular consumers to cache responses. To cache at the HTTP level, give ``AmiiboLiveClient`` a transport backed by a `URLCache`:

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

Models are `Codable`, so you can also store them yourself.

## Testing

To test without network access, pass a mock ``AmiiboClient`` to ``AmiiboService/init(client:)``. ``AmiiboClient`` refines `Sendable`, so the mock must be `Sendable`, too:

```swift
import AmiiboService

struct MockClient: AmiiboClient {
    var error: AmiiboServiceError?

    func getAmiibos(
        by filter: AmiiboFilter
    ) async throws(AmiiboServiceError) -> [Amiibo] {
        if let error { throw error }
        return []
    }

    // Implement the remaining requirements...
}

let service = AmiiboService(client: MockClient())
```

## Topics

### Service

- ``AmiiboService``

### Clients

- ``AmiiboClient``
- ``AmiiboLiveClient``

### Models

- ``Amiibo``
- ``AmiiboSeries``
- ``AmiiboType``
- ``GameCharacter``
- ``GameSeries``

### Filters

- ``AmiiboFilter``
- ``AmiiboSeriesFilter``
- ``AmiiboTypeFilter``
- ``GameCharacterFilter``
- ``GameSeriesFilter``

### Errors

- ``AmiiboServiceError``
