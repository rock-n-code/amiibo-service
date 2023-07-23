//===----------------------------------------------------------------------===//
//
// This source file is part of the AmiiboService open source project
//
// Copyright (c) 2023 Röck+Cöde VoF. and the AmiiboService project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of AmiiboService project authors
//
//===----------------------------------------------------------------------===//

extension DTO.Amiibo {
    
    /// This model structs represents a game that is related to an amiibo, when requested to the respective [remote API endpoint](https://www.amiiboapi.com/docs/#showGames).
    public struct Game {
        
        // MARK: Properties
        
        /// The list of identifiers associated to the game.
        public let ids: [String]
        
        /// The name of the game.
        public let name: String
        
        /// The list of usages that explains how the amiibo is being used in the game.
        public let usage: [Usage]?
        
    }

}

// MARK: - Decodable

extension DTO.Amiibo.Game: Decodable {
    enum CodingKeys: String, CodingKey {
        case ids = "gameID"
        case name = "gameName"
        case usage = "amiiboUsage"
    }
}
