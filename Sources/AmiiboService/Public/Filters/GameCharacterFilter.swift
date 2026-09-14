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

/// A filter for game character requests.
public struct GameCharacterFilter: KeyNameFilter, Sendable {

    // TODO: Remove the documentation from the properties and initializers of this type as the `--enable-inherited-docs` flag when generating DocC documentation is not working as intended (?).

    // MARK: Properties

    /// A hexadecimal key in `0x` format, such as `0x0001`, to match exactly, if any.
    public let key: String?

    /// A name, or part of one, to match, if any.
    public let name: String?

    // MARK: Initializers

    /// Initializes a filter that matches every game character.
    public init() {
        self.key = nil
        self.name = nil
    }

    /// Initializes a filter that matches the game character with a given key.
    /// - Parameter key: A hexadecimal key in `0x` format, such as `0x0001`.
    public init(key: String) {
        self.key = key
        self.name = nil
    }

    /// Initializes a filter that matches game characters by name.
    /// - Parameter name: A name, or part of one.
    public init(name: String) {
        self.key = nil
        self.name = name
    }
    
}
