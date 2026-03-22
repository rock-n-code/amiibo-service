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

/// A protocol that defines models containing a `key` and `name` pair.
protocol KeyNameModel: Sendable, Hashable {
    
    // MARK: Properties
    
    /// A hexadecimal key that uniquely identifies this model.
    var key: String { get }
    
    /// A display name for this model.
    var name: String { get }
    
    // MARK: Initializers
    
    /// Initializes this model from a given payload.
    /// - Parameter payload: A payload that contains the values for the model.
    init(_ payload: Components.Schemas.Tuple)
    
}
