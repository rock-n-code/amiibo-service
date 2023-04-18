public struct Amiibo {
    public let type: String
    public let head: String
    public let tail: String
    public let name: String
    public let character: String
    public let amiiboSeries: String
    public let gameSeries: String
    public let image: String
    public let release: Release
    public let games3DS: [Game]?
    public let gamesWiiU: [Game]?
    public let gamesSwitch: [Game]?
}

// MARK: - Decodable

extension Amiibo: Decodable {}
