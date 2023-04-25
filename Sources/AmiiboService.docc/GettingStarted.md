# Getting Started

Install the package and start using the service to retrieve any available data from the [Amiibo API](https://www.amiiboapi.com).

## Installing the package

It is possible to add this package to other libraries and applications by adding it as a dependency in a `Package.swift` file or in a Xcode project, through the *Package dependencies* interface.

It is also important to highlight that this package has minimum platform requirements that must be taken into account:
* *iOS 15.0 or higher*;
* *macOS 12.0 or higher*;
* *tvOS 15.0 or higher*;
* *watchOS 8.0 or higher*.

### The "Package.swift" file way

In the intended `Package.swift` file, it is required to add the dependency, as demonstrated below:

```swift
dependencies: [
    // ...
    .package(url: "https://github.com/rock-n-code/amiibo-service.git", from: "1.0.1")
    // ...
],
```

Then it is required to add the package to your target, like this:

```swift
targets: [
    .target(
        // ...
        dependencies: [
            .product(name: "AmiiboService", package: "amiibo-service")
        ],
        // ...
    ),
]
```

### The "Package dependencies" in Xcode way

In an opened Xcode project, it is required to follow these steps to install the package:

1. click on the Xcode project file in the sidebar to display *Project* and *Targets*;
2. select the project under the *Project* section to show the *Info*, *Build Settings* and *Package Dependencies* options in the center menu just right on top;
3. select the *Package Dependencies* option to show the defined dependencies of the project;
4. press on the *+* (plus) button to add dependencies to the project;
5. enter the URL `https://github.com/rock-n-code/amiibo-service` into the *Search or Enter Package URL* located in the upper right corner;
6. select the retrieved option;
7. define the dependency rule (the *Up to Next Major Version* option and the *1.0.1* text are recommended);
8. select the target to which the dependency will be applied (if required);
9. wait for the package to be resolved and included in the project;
10. now you should be ready to start using this package!

## Using the service

Now that this package is installed in the project, the ``AmiiboService/AmiiboService`` service will be available after importing the package into your source code, like this:

```swift
import AmiiboService
```

This service requires a ``URLSessionConfiguration`` instance to initialise, which is included into the ``Foundation`` framework. Although it is possible to initialise the service as simple as this:

```swift
private let service = AmiiboService(configuration: .default)
```

It is recommendable to add cache support for the configuration instance before initialising the service with it, especially in case of making regular calls to the remote API service (as recommended by the [Amiibo API documentation](https://www.amiiboapi.com/docs/#info)). 

This service provides these following functions, which all basically are meant to be making requests based on a given filter criteria to the remote API, handling the responses, and decoding the retrieved data into models/entities structs, or throws errors if necessary:

- ``AmiiboService/amiibos(filter:)`` that interacts with the respective [Amiibo API endpoint](https://www.amiiboapi.com/docs/#amiibo);
- ``AmiiboService/amiiboSeries(filter:)`` that interacts with the respective [Amiibo API endpoint](https://www.amiiboapi.com/docs/#series);
- ``AmiiboService/amiiboTypes(filter:)`` that interacts with the respective [Amiibo API endpoint](https://www.amiiboapi.com/docs/#type);
- ``AmiiboService/characters(filter:)`` that interacts with the respective [Amiibo API endpoint](https://www.amiiboapi.com/docs/#character);
- ``AmiiboService/gameSeries(filter:)`` that interacts with the respective [Amiibo API endpoint](https://www.amiiboapi.com/docs/#gameSeries);
- ``AmiiboService/lastUpdated()`` that interacts with the respective [Amiibo API endpoint](https://www.amiiboapi.com/docs/#lastUpdated).

It is certainly important to highlight two points here:

1. these functions support the `async/await` feature of the Swift programming language, thus they should be called within a context that already uses this feature;
2. these functions would throw an error in case any issue occurred while they are executing, so it is recommendable to handle the error appropriately to guarantee the proper continuation of the application and also, a proper user experience.
