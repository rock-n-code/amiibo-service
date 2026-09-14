// ===----------------------------------------------------------------------===
// 
// This source file is part of the Amiibo Service open source project
// 
// Copyright (c) 2026 Röck+Cöde VoF. and the Amiibo Service project authors
// Licensed under Apache license v2.0
// 
// See LICENSE for license information
// See CONTRIBUTORS for the list of Amiibo Service project authors
//
// SPDX-License-Identifier: Apache-2.0
// 
// ===----------------------------------------------------------------------===

/// A filter for game series requests.
public struct GameSeriesFilter: KeyNameFilter, Sendable {

    // TODO: Remove the documentation from the properties and initializers of this type as the `--enable-inherited-docs` flag when generating DocC documentation is not working as intended (?).

    // MARK: Properties

    /// A hexadecimal key in `0x` format, such as `0x001`, to match exactly, if any.
    public let key: String?

    /// A name, or part of one, to match, if any.
    public let name: String?

    // MARK: Initializers

    /// Initializes a filter that matches every game series.
    public init() {
        self.key = nil
        self.name = nil
    }

    /// Initializes a filter that matches the game series with a given key.
    /// - Parameter key: A hexadecimal key in `0x` format, such as `0x001`.
    public init(key: String) {
        self.key = key
        self.name = nil
    }

    /// Initializes a filter that matches game series by name.
    /// - Parameter name: A name, or part of one.
    public init(name: String) {
        self.key = nil
        self.name = name
    }
    
}
