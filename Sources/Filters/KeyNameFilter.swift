public struct KeyNameFilter {
    
    // MARK: Properties
    
    private let key: String?
    private let name: String?
    
    // MARK: Initialisers
    
    public init(
        key: String? = nil,
        name: String? = nil
    ) {
        self.key = key
        self.name = name
    }

}

// MARK: - Filter

extension KeyNameFilter: Filter {
    
    // MARK: Functions
    
    func makeParameters() -> [String : String?] {
        var parameters: [String : String?] = [:]
        
        if let key {
            parameters[.Key.key] = key
        }
        
        if let name {
            parameters[.Key.name] = name
        }
        
        return parameters
    }
    
}

// MARK: - Type aliases

public typealias AmiiboSeriesFilter = KeyNameFilter
public typealias AmiiboTypeFilter = KeyNameFilter
public typealias CharacterFilter = KeyNameFilter
public typealias GameSeriesFilter = KeyNameFilter

// MARK: - String+Key

private extension String {
    enum Key {
        static let key = "key"
        static let name = "name"
    }
}
