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
