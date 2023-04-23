import Foundation

extension Amiibo {
    /// This model struct represents a collection of official release dates (if released) of an amiibo in different markets around the world.
    public struct Release {
        
        // MARK: Properties
        
        /// The official release date (if released) of an amiibo in Australia.
        public let australia: Date?
        
        /// The official release date (if released) of an amiibo in Europe.
        public let europe: Date?
        
        /// The official release date (if released) of an amiibo in Japan.
        public let japan: Date?
        
        /// The official release date (if released) of an amiibo in North America.
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
