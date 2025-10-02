//===----------------------------------------------------------------------===
//
// This source file is part of the AmiiboService open source project
//
// Copyright (c) 2024-2025 Röck+Cöde VoF. and the AmiiboAPI project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE for license information
// See CONTRIBUTORS for the list of AmiiboAPI project authors
//
//===----------------------------------------------------------------------===

/// A type that contains values to fine-tune a response when requesting amiibo series.
public struct AmiiboSeriesFilter: KeyNameFilter, Sendable {
    
    // TODO: Remove the documentation from the properties and initializers of this type as the `--enable-inherited-docs` flag when generating DocC documentation is not working as intended (?).

    // MARK: Properties

    /// A key to return, if any.
    public let key: String?

    /// A name to return, if any.
    public let name: String?
    
    // MARK: Initializers

    /// Initializes this filter without key or name values.
    public init() {
        self.key = nil
        self.name = nil
    }

    /// Initializes this filter with a key value.
    /// - Parameter key: A key to return.
    public init(key: String) {
        self.key = key
        self.name = nil
    }

    /// Initializes this filter with a name value.
    /// - Parameter name: A name to return.
    public init(name: String) {
        self.key = nil
        self.name = name
    }
    
}
