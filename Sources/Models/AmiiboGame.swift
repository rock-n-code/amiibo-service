extension Amiibo {
    public struct Game {
        public let identifiers: [String]
        public let name: String
        public let usage: [Usage]
    }
}

// MARK: - Decodable

extension Amiibo.Game: Decodable {
    enum CodingKeys: String, CodingKey {
        case identifiers = "gameID"
        case name = "gameName"
        case usage = "amiiboUsage"
    }
}
