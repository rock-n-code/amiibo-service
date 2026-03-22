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

/// A model that represents a game series.
public struct GameSeries: KeyNameModel {

    // MARK: Properties

    /// The hexadecimal key that uniquely identifies this game series.
    public let key: String

    /// The name of this game series.
    public let name: String
    
    // MARK: Initializers
    
    /// Initializes this model from a given payload.
    /// - Parameter payload: A payload that contains the values for the model.
    init(_ payload: Components.Schemas.Tuple) {
        self.key = payload.key
        self.name = payload.name
    }
    
}
