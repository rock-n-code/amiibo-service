public struct KeyName {
    public let key: String
    public let name: String?
}

// MARK: - Decodable

extension KeyName: Decodable {}

// MARK: - Type aliases

public typealias AmiiboType = KeyName
public typealias AmiiboSeries = KeyName
public typealias GameSeries = KeyName
public typealias Character = KeyName
