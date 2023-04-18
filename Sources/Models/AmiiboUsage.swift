extension Amiibo {
    public struct Usage {
        public let explanation: String
        public let isWritable: Bool
    }
}

// MARK: - Decodable

extension Amiibo.Usage: Decodable {
    enum CodingKeys: String, CodingKey {
        case explanation = "Usage"
        case isWritable = "write"
    }
}
