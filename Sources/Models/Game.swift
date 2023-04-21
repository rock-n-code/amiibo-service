public struct Game {
    public let ids: [String]
    public let name: String
    public let usage: [Usage]?
}

// MARK: - Decodable

extension Game: Decodable {
    enum CodingKeys: String, CodingKey {
        case ids = "gameID"
        case name = "gameName"
        case usage = "amiiboUsage"
    }
}
