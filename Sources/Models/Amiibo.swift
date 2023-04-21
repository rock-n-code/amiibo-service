public struct Amiibo {
    public let type: String
    public let head: String
    public let tail: String
    public let name: String
    public let character: String
    public let series: String
    public let gameSeries: String
    public let image: String
    public let release: Release
    public let games: Games?
}

// MARK: - Structs

extension Amiibo {
    public struct Games: Decodable {
        public let n3ds: [Game]
        public let wiiu: [Game]
        public let `switch`: [Game]
    }
}

// MARK: - Decodable

extension Amiibo: Decodable {
    
    // MARK: Enumerations
    
    enum CodingKeys: String, CodingKey {
        case type
        case head
        case tail
        case name
        case character
        case series = "amiiboSeries"
        case gameSeries
        case image
        case release
        case games3DS
        case gamesWiiU
        case gamesSwitch
    }
    
    // MARK: Initialisers
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let games3ds = try container.decodeIfPresent([Game].self, forKey: .games3DS)
        let gamesWiiU = try container.decodeIfPresent([Game].self, forKey: .gamesWiiU)
        let gamesSwitch = try container.decodeIfPresent([Game].self, forKey: .gamesSwitch)
        
        self.type = try container.decode(String.self, forKey: .type)
        self.head = try container.decode(String.self, forKey: .head)
        self.tail = try container.decode(String.self, forKey: .tail)
        self.name = try container.decode(String.self, forKey: .name)
        self.character = try container.decode(String.self, forKey: .character)
        self.series = try container.decode(String.self, forKey: .series)
        self.gameSeries = try container.decode(String.self, forKey: .gameSeries)
        self.image = try container.decode(String.self, forKey: .image)
        self.release = try container.decode(Release.self, forKey: .release)
        self.games = {
            if let games3ds, let gamesWiiU, let gamesSwitch {
                return .init(
                    n3ds: games3ds,
                    wiiu: gamesWiiU,
                    switch: gamesSwitch
                )
            } else {
                return nil
            }
        }()
    }

}
