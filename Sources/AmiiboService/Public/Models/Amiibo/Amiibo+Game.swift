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

extension Amiibo {
    /// A model that represents a game related to an amiibo.
    public struct Game: Sendable {
        
        // MARK: Properties
        
        /// A list of identifiers.
        public let identifiers: [String]
        
        /// A name.
        public let name: String
        
        /// A list of amiibo usages, if any.
        public let usages: [Usage]?
        
        // MARK: Initializers

        /// Initializes this model from a given payload.
        /// - Parameter payload: A payload that contains the values for the model.
        init(_ payload: Components.Schemas.AmiiboGame) {
            self.identifiers = payload.gameID
            self.name = payload.gameName
            self.usages = {
                guard let usages = payload.amiiboUsage else {
                    return nil
                }
                
                return usages.map { .init($0) }
            }()
        }
        
    }
}
