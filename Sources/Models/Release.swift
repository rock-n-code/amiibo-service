import Foundation

public struct Release {
    public let australia: Date?
    public let europe: Date?
    public let japan: Date?
    public let america: Date?
}

// MARK: - Decodable

extension Release: Decodable {
    enum CodingKeys: String, CodingKey {
        case australia = "au"
        case europe = "eu"
        case japan = "jp"
        case america = "na"
    }
}
