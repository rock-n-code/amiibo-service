import Foundation

/// This model represents the latest date when the remote API has been updated.
public struct LastUpdated {
    
    // MARK: Properties
    
    /// The date of the latest update of the remote API.
    public let timestamp: Date

}

// MARK: - Decodable

extension LastUpdated: Decodable {
    enum CodingKeys: String, CodingKey {
        case timestamp = "lastUpdated"
    }
}
