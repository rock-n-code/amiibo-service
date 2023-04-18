import Foundation

extension Amiibo {
    public struct Release {
        public let australia: Date?
        public let europe: Date?
        public let japan: Date?
        public let america: Date?
    }
}

// MARK: - Decodable

extension Amiibo.Release: Decodable {
    enum CodingKeys: String, CodingKey {
        case australia = "au"
        case europe = "eu"
        case japan = "jp"
        case america = "na"
    }
}
