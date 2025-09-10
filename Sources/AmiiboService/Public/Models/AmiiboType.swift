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

/// A model that represents an amiibo type.
public struct AmiiboType: KeyNameModel {

    // TODO: Remove the documentation from the properties of this type as the `--enable-inherited-docs` flag when generating DocC documentation is not working as intended (?).

    // MARK: Properties

    /// A key.
    public let key: String

    /// A name.
    public let name: String
    
    // MARK: Initializers
    
    init(_ payload: Components.Schemas.Tuple) {
        self.key = payload.key
        self.name = payload.name
    }
    
}
