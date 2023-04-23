/// This model is a concrete genetic definition that represents the following models: ``AmiiboSeries``, ``AmiiboType``, ``Character`` and ``GameSeries``.
public struct KeyName {
    
    // MARK: Properties
    
    /// The key of the model.
    public let key: String
    
    /// The name of the model.
    public let name: String

}

// MARK: - Type aliases

/// This model represents the series an amiibo belongs to.
public typealias AmiiboSeries = KeyName

/// This model represents the type an amiibo belongs to.
public typealias AmiiboType = KeyName

/// This model represents the character an amiibo is associated to.
public typealias Character = KeyName

/// This model represents the games series an amiibo is associated to.
public typealias GameSeries = KeyName

// MARK: - Decodable

extension KeyName: Decodable {}
