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

extension Amiibo {
    /// A model that represents the usage of an amiibo within a certain game.
    public struct Usage: Sendable, Hashable {
        
        // MARK: Properties
        
        /// A description of how the amiibo is used within the game.
        public let explanation: String
        
        /// A flag that indicates whether the amiibo can save game data.
        public let isWriteable: Bool
        
        // MARK: Initializers

        /// Initializes this model from a given payload.
        /// - Parameter payload: A payload that contains the values for the model.
        init(_ payload: Components.Schemas.AmiiboUsage) {
            self.explanation = payload.Usage
            self.isWriteable = payload.write
        }
        
    }
}
