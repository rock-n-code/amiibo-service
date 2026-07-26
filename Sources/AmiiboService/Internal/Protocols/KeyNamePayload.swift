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

/// A protocol that unifies the generated payload types containing a `key` and `name` pair.
protocol KeyNamePayload {
    
    // MARK: Properties
    
    /// A hexadecimal key that uniquely identifies this payload.
    var key: String { get }
    
    /// A display name for this payload.
    var name: String { get }
    
}

// MARK: - Conformances

extension Components.Schemas.AmiiboSeries: KeyNamePayload {}
extension Components.Schemas.AmiiboType: KeyNamePayload {}
extension Components.Schemas.GameCharacter: KeyNamePayload {}
extension Components.Schemas.GameSeries: KeyNamePayload {}
