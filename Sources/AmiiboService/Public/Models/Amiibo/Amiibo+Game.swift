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
    /// A model that represents a game related to an amiibo.
    public struct Game: Sendable, Hashable, Codable {
        
        // MARK: Properties
        
        /// A list of game identifiers associated with this game.
        public let identifiers: [String]
        
        /// The name of this game.
        public let name: String
        
        /// A list of amiibo usages within this game, or `nil` unless the request sets ``AmiiboFilter/showUsage``.
        public let usages: [Usage]?
        
        // MARK: Initializers

        /// Initializes this model.
        package init(
            identifiers: [String],
            name: String,
            usages: [Usage]? = nil
        ) {
            self.identifiers = identifiers
            self.name = name
            self.usages = usages
        }

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
