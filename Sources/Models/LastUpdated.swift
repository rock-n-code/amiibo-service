import Foundation

public struct LastUpdated {
    public let timestamp: Date
}

// MARK: - Decodable

extension LastUpdated: Decodable {
    enum CodingKeys: String, CodingKey {
        case timestamp = "lastUpdated"
    }
}
