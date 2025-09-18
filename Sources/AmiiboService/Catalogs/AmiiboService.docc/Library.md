# ``AmiiboService``

A library that provides everything the developer needs to interacts with the **Amiibo API** backend service.

## Overview

The `AmiiboService` library is a Swift Package Manager package dependency aims at allowing the developer to interact with the [Amiibo API](https://www.amiiboapi.com) backend service seamlessly, by not only providing the *service* type but also any possible *clients*, *models*, *filters* and *errors* types that might be needed during implementation.

## Design

Although it could have been possible to generate a one-to-one RESTful client based on the Open API specification document that describe the available endpoints of the backend service, it was decided to design a `AmiiboService` service type that removes the complexities of the API design imposed by the backend service, and provides the developer with a simple interface, and a seamless experience.

## Installation

To use the `AmiiboService` library with your package, then add it as a dependency in the `Package.swift` file:

```swift
let package = Package(
    // name, platforms, products, etc.
    dependencies: [
        .package(url: "https://github.com/rock-n-code/amiibo-service", from: "1.0.0"),
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

It is also possible to use the `AmiiboService` library with your app in Xcode, then add it as a dependency in your Xcode project.

> important: Swift 5.10 or higher is required in order to compile this library.

## Tasks

This library offers a set of ready-to-use project management tasks that the developer could use from the command line. To show the list of tasks on the `Terminal` app, plus display some explanations about each and every one of them; please enter the following command:

```bash
$ make
```

## Topics

### Service

- ``AmiiboService``

### Clients

- ``AmiiboClient``
- ``AmiiboLiveClient``

### Models

- ``Amiibo``
- ``Amiibo/Game``
- ``Amiibo/Platform``
- ``Amiibo/Release``
- ``Amiibo/Usage``
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
