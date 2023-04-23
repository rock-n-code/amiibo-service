extension Amiibo {
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

extension Amiibo.Game: Decodable {
    enum CodingKeys: String, CodingKey {
        case ids = "gameID"
        case name = "gameName"
        case usage = "amiiboUsage"
    }
}
