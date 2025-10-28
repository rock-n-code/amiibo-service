// ===----------------------------------------------------------------------===
// 
// This source file is part of the Amiibo Service open source project
// 
// Copyright (c) 2025 Röck+Cöde VoF. and the Amiibo Service project authors
// Licensed under Apache license v2.0
// 
// See LICENSE for license information
// See CONTRIBUTORS for the list of Amiibo Service project authors
//
// SPDX-License-Identifier: Apache-2.0
// 
// ===----------------------------------------------------------------------===

/// A model that represents a game character.
public struct GameCharacter: KeyNameModel {

    // MARK: Properties

    /// A game character key.
    public let key: String

    /// A game character  name.
    public let name: String
    
    // MARK: Initializers

    /// Initializes this model from a given payload.
    /// - Parameter payload: A payload that contains the values for the model.
    init(_ payload: Components.Schemas.Tuple) {
        self.key = payload.key
        self.name = payload.name
    }
    
}
