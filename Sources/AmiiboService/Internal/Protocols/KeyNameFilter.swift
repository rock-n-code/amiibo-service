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

/// A protocol that defines filters that might contain `key` and/or `name` values.
protocol KeyNameFilter {
    
    // MARK: Properties
    
    /// A key to return, if any.
    var key: String? { get }
    
    /// A name to return, if any.
    var name: String? { get }
    
    // MARK: Initializers
    
    /// Initializes this filter without key or name values.
    init()

    /// Initializes this filter with a key value.
    /// - Parameter key: A key to return.
    init(key: String)
    
    /// Initializes this filter with a name value.
    /// - Parameter name: A name to return.
    init(name: String)
    
}
