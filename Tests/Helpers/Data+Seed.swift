import Foundation

extension Data {
    enum Seed {
        static let dataUnrelated = "{\"something\":\"Something goes in here...\"}".data(using: .utf8)
        static let dataWithoutTimestamp = "{\"timestamp\":null}".data(using: .utf8)
        static let dataWithDateOnly = "{\"timestamp\":\"2023-03-23\"}".data(using: .utf8)
        static let dataWithDateAndTime = "{\"timestamp\":\"2023-03-23T13:11:20.382254\"}".data(using: .utf8)
    }
}
