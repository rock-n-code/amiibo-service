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

import Foundation

extension Amiibo {
    /// A model that represents a collection of release dates related to an amiibo item.
    public struct Release: Sendable {
        
        // MARK: Properties
        
        /// A release date for North America, if any.
        public let america: Date?

        /// A release date for Australia, if any.
        public let australia: Date?

        /// A release date for Europe, if any.
        public let europe: Date?

        /// A release date for Japan, if any.
        public let japan: Date?
        
        // MARK: Initializers

        /// Initializes this model from a given payload.
        /// - Parameter payload: A payload that contains the values for the model.
        init(_ payload: Components.Schemas.AmiiboRelease) {
            self.america = payload.na
            self.australia = payload.au
            self.europe = payload.eu
            self.japan = payload.jp
        }
        
    }
}
