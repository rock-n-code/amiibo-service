[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frock-n-code%2Famiibo-service%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/rock-n-code/amiibo-service)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frock-n-code%2Famiibo-service%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/rock-n-code/amiibo-service)
[![](https://github.com/rock-n-code/amiibo-service/actions/workflows/ci.yml/badge.svg)](https://github.com/rock-n-code/amiibo-service/actions/workflows/ci.yml)

# Amiibo Service

A Swift client for the [Amiibo API](https://www.amiiboapi.org).

## Requirements

- Swift 6.2 or later
- iOS 13, macOS 10.15, tvOS 13, visionOS 1, or watchOS 6 or later

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

## Usage

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

Results are sorted in ascending order by identifier (amiibos) or key (everything else). Models are `Hashable`, `Codable`, and `Identifiable`; filters are `Hashable`.

## Error handling

Every call throws `AmiiboServiceError`. When nothing matches, `getAmiibos(_:)` returns an empty array, while the other list calls throw `AmiiboServiceError.notFound`:

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

The library has no built-in cache. The Amiibo API asks regular consumers to cache responses. To do that, give `AmiiboLiveClient` a transport backed by a `URLCache`:

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

To test without network access, pass a mock `AmiiboClient` to `AmiiboService(client:)`. `AmiiboClient` refines `Sendable`, so the mock must be `Sendable`, too:

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

## Development

Run `make` to list the available tasks for building, testing, and generating documentation.

The test suite runs offline by default. Tests against the live service run only if `AMIIBO_LIVE_TESTS` is set to `1`:

```shell
AMIIBO_LIVE_TESTS=1 swift test
```

In Xcode, set the variable in the scheme's **Test** action.

The live tests compare the responses against baselines recorded from the service: minimum item counts per endpoint and the earliest accepted last-updated date. These live in the `Int` extension at the bottom of `AmiiboServiceLiveTests.swift` and in the `get the last updated timestamp` test. Refresh them occasionally by fetching the current totals and the current timestamp from the service, then updating the constants and their `as of` notes:

```shell
for endpoint in amiibo amiiboseries type character gameseries; do
  printf '%s: ' "$endpoint"
  curl -s "https://www.amiiboapi.org/api/$endpoint/" | python3 -c 'import json,sys; print(len(json.load(sys.stdin)["amiibo"]))'
done
curl -s https://www.amiiboapi.org/api/lastupdated/
```

## Documentation

See the [online documentation](https://rock-n-code.github.io/amiibo-service/documentation/amiiboservice/).
