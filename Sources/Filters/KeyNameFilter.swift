/// This filter provides all the possible parameters (and combinations) available at the remote API applies when filtering amiibos series (``AmiiboSeriesFilter``), amiibo types (``AmiiboTypeFilter``), characters (``CharacterFilter``), or game series (``GameSeriesFilter``).
public struct KeyNameFilter {
    
    // MARK: Properties
    
    private let key: String?
    private let name: String?
    
    // MARK: Initialisers
    
    /// Initialises this filter.
    /// - Parameters:
    ///   - key: A `key` value to match against.
    ///   - name: A `name` value to match against.
    public init(
        key: String? = nil,
        name: String? = nil
    ) {
        self.key = key
        self.name = name
    }

}

// MARK: - Type aliases

/// This filter provides all the possible parameters (and combinations) available at the remote API applies when filtering amiibos series.
public typealias AmiiboSeriesFilter = KeyNameFilter

/// This filter provides all the possible parameters (and combinations) available at the remote API applies when filtering amiibo types.
public typealias AmiiboTypeFilter = KeyNameFilter

/// This filter provides all the possible parameters (and combinations) available at the remote API applies when filtering characters.
public typealias CharacterFilter = KeyNameFilter

/// This filter provides all the possible parameters (and combinations) available at the remote API applies when filtering game series.
public typealias GameSeriesFilter = KeyNameFilter

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

// MARK: - String+Key

private extension String {
    enum Key {
        static let key = "key"
        static let name = "name"
    }
}
