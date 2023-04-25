<center style="margin: 48px 96px;">
    <picture>
        <source srcset="imgs/amiiboservice-logo-dark.svg" media="(prefers-color-scheme: dark)">
        <img src="imgs/amiiboservice-logo-light.svg" alt="Shows the hand-drawn AmiiboService package logo centered in the page.">
    </picture>
</center>

# AmiiboService: Amiibo API service written in Swift

Ready-to-use service that retrieves data as decoded models from any of the [Amiibo API](https://www.amiiboapi.com) available endpoints.

## Installation

It is possible to add this package to other libraries and applications by adding it as a dependency in a `Package.swift` file or in a Xcode project, through the *Package dependencies* interface.

This package has minimum platform requirements that are important to take into account:
* *iOS 15.0 or higher*;
* *macOS 12.0 or higher*;
* *tvOS 15.0 or higher*;
* *watchOS 8.0 or higher*.

### Package file

In the intended `Package.swift` file, it is required to add the following dependency:

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

### Xcode 

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

### Other considerations

This library is fully supported on Apple platforms only for the time being: *iOS*, *macOS*, *tvOS*, and *watchOS*. Support for other platforms such as *Linux* or *Windows* might be added in the future, depending on the type of changes those platforms require but this needs to be researched first. 

⚠️ Please notice that this library only supports the [Swift Package Manager](https://www.swift.org/package-manager/), and that support for other dependency managers such as *Cocoapods* and *Carthage* has not been prioritised. 

## Further documentation

For further information about how to use this service or reference documentation about any of its components, please refer to the [AmiiboService documentation](https://rock-n-code.github.io/amiibo-service/documentation/amiiboservice/) available online.

For further information about the API, please refer to the [Amiibo API documentation](https://www.amiiboapi.com/docs/) available online.
