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

extension Amiibo.Game {
    /// This model struct represents how an amiibo is used with a particular game, when requested to the respective [remote API endpoint](https://www.amiiboapi.com/docs/#showUsage).
    public struct Usage {
        
        // MARK: Properties
        
        /// The explanation on how an amiibo is being used with a particular game.
        public let explanation: String
        
        /// A flag that indicates whether an amiibo is only read-only or the game can also write information to the amiibo.
        public let isWritable: Bool
        
    }
}

// MARK: - Decodable

extension Amiibo.Game.Usage: Decodable {
    enum CodingKeys: String, CodingKey {
        case explanation = "Usage"
        case isWritable = "write"
    }
}
