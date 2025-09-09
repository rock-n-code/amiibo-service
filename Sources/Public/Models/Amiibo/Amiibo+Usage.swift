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

extension Amiibo {
    /// A model that represents the usage of an amiibo item within a certain game.
    public struct Usage: Sendable {
        
        // MARK: Properties
        
        /// An explanation of how to use an amiibo item.
        public let explanation: String
        
        /// A flag that indicates whether an amiibo item can save game data in it.
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
