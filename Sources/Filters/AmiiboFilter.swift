public struct AmiiboFilter {
    
    // MARK: Properties
    
    private let id: String?
    private let head: String?
    private let tail: String?
    private let name: String?
    private let type: String?
    private let gameSeries: String?
    private let amiiboSeries: String?
    private let character: String?
    private let showExtras: ShowExtras
    
    // MARK: Initialisers
    
    public init(
        id: String? = nil,
        head: String? = nil,
        tail: String? = nil,
        name: String? = nil,
        type: String? = nil,
        gameSeries: String? = nil,
        amiiboSeries: String? = nil,
        character: String? = nil,
        showExtras: ShowExtras = .none
    ) {
        self.id = id
        self.head = head
        self.tail = tail
        self.name = name
        self.type = type
        self.gameSeries = gameSeries
        self.amiiboSeries = amiiboSeries
        self.character = character
        self.showExtras = showExtras
    }
    
}

// MARK: - Filter

extension AmiiboFilter: Filter {
    
    // MARK: Functions
    
    func makeParameters() -> [String : String?] {
        var parameters: [String : String?] = [:]
        
        if let id {
            parameters[.Key.id] = id
        }
        
        if let head {
            parameters[.Key.head] = head
        }
        
        if let tail {
            parameters[.Key.tail] = tail
        }
        
        if let name {
            parameters[.Key.name] = name
        }
        
        if let type {
            parameters[.Key.type] = type
        }
        
        if let gameSeries {
            parameters[.Key.gameSeries] = gameSeries
        }
        
        if let amiiboSeries {
            parameters[.Key.amiiboSeries] = amiiboSeries
        }
        
        if let character {
            parameters[.Key.character] = character
        }
        
        switch showExtras {
        case .games:
            parameters[.Key.showGames] = nil
        case .usage:
            parameters[.Key.showUsage] = nil
        default:
            break
        }

        return parameters
    }
    
}

// MARK: - Enumerations

public enum ShowExtras {
    case none
    case games
    case usage
}

// MARK: - String+Key

private extension String {
    enum Key {
        static let id = "id"
        static let head = "head"
        static let tail = "tail"
        static let name = "name"
        static let type = "type"
        static let gameSeries = "gameSeries"
        static let amiiboSeries = "amiiboSeries"
        static let character = "character"
        static let showGames = "showgames"
        static let showUsage = "showusage"
    }
}
