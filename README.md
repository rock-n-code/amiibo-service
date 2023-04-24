<center style="margin: 48px 96px;">
    <picture>
        <source srcset="imgs/amiiboservice-logo-dark.svg" media="(prefers-color-scheme: dark)">
        <img src="imgs/amiiboservice-logo-light.svg" alt="Shows the hand-drawn AmiiboService package logo centered in the page.">
    </picture>
</center>

# AmiiboService: Amiibo API service written in Swift

Ready-to-use service that retrieves data as decoded models from any of the [Amiibo API](https://www.amiiboapi.com) available endpoints.

## Installation

It is possible to add this library in your projects either by explicitly add it as a dependency either in a `Package.swift` file or in your Xcode project.

This package has minimum platform requirements that are important to take into account:
* *iOS 13.0 or higher*;
* *macOS 10.15 or higher*;
* *tvOS 13.0 or higher*;
* *watchOS 8.0 or higher*;

### Package file

In the intended `Package.swift` file, it is required to add the following dependency:

```swift
dependencies: [
    // ...
    .package(url: "https://github.com/rock-n-code/amiibo-service.git", from: "1.0.0")
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

### Xcode 

In an opened Xcode project, it is required to do these steps:
1. click on your Xcode project file to display *Project* and *Targets*;
2. select the project under the *Project* section to show the *Info*, *Build Settings* and *Package Dependencies* in the center menu of the screen;
3. select the *Package Dependencies* to show the defined dependencies of the project;
4. press on the *+* (plus) button to add dependencies to the project;
5. enter the URL`https://github.com/rock-n-code/amiibo-service` into the *Search or Enter Package URL* located in the upper right corner;
6. select the given option;
7. define the dependency rule (the *Up to Next Major Version* option and the *1.0.0* text are recommended);
8. select the target to which the dependency will be applied (if required);
9. wait for the package to be resolved and included in the project;
10. done!

### Other considerations

This library is fully supported on Apple platforms only for the time being: *iOS*, *macOS*, *tvOS*, and *watchOS*. Support for other platforms such as *Linux* or *Windows* might be added in the future, depending on the type of changes those platforms require but this needs to be researched first. 

⚠️ Please notice that this library only supports the [Swift Package Manager](https://www.swift.org/package-manager/), and that support for other dependency managers such as *Cocoapods* and *Carthage* is not planned. 

## Usage

This package provides an actor called `AmiiboService` which, after is initialised, is responsible for making requests based on a given filter criteria to the remote API, handling the responses, and decoding the retrieved data into models/entities structs, or throws errors if necessary.

It is needless to say, all the necessary filters, models/entities, and enumerations are also provided in this package. 

## Further documentation

For further information about this package, please refer to the [AmiiboService documentation](https://rock-n-code.github.io/amiibo-service/documentation/amiiboservice/) available online.

For further information about the API, please refer to the [Amiibo API documentation](https://www.amiiboapi.com/docs/) available online.
