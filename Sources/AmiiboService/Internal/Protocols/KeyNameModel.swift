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

/// A protocol that defines decodable models containing the `key` and `name` properties.
protocol KeyNameModel: Sendable {
    
    // MARK: Properties
    
    /// A key.
    var key: String { get }
    
    /// A name.
    var name: String { get }
    
    // MARK: Initializers
    
    /// Initializes this model from a given payload.
    /// - Parameter payload: A payload that contains the values for the model.
    init(_ payload: Components.Schemas.Tuple)
    
}
