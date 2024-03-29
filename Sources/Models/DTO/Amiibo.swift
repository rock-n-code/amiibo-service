//===----------------------------------------------------------------------===//
//
// This source file is part of the AmiiboService open source project
//
// Copyright (c) 2023 Röck+Cöde VoF. and the AmiiboService project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of AmiiboService project authors
//
//===----------------------------------------------------------------------===//

import Foundation

extension DTO {
    
    /// This model struct represents an amiibo that is retrieved from the respective [remote API endpoint](https://www.amiiboapi.com/docs/#amiibo).
    public struct Amiibo {
        
        // MARK: Properties
        
        /// The type the amiibo belongs to.
        public let type: String
        
        /// The first 8 values of the hexadecimal that identifies the amiibo.
        public let head: String
        
        /// The last 8 values of the hexadecimal that identifies the amiibo.
        public let tail: String
        
        /// The name of the amiibo.
        public let name: String
        
        /// The character of the amiibo.
        public let character: String
        
        /// The series the amiibo belongs to.
        public let series: String
        
        /// The game series of the amiibo.
        public let gameSeries: String
        
        /// The URL to an image of the amiibo.
        public let imageURL: URL
        
        /// The release dates of the amiibo (if released) in Australia, Europe, Japan and North America.
        public let release: Release
        
        /// The games related to the amiibo, if requested.
        public let games: Games?
    }

}

// MARK: - Structs

extension DTO.Amiibo {
    
    /// This model represents the list of games related to a particular amiibo, grouped by system.
    public struct Games: Decodable {
        
        // MARK: Properties
        
        /// A list of [Nintendo 3DS system](https://en.wikipedia.org/wiki/Nintendo_3DS) games the amiibo can be used with.
        public let n3ds: [Game]
        
        /// A list of [Nintendo WiiU system](https://en.wikipedia.org/wiki/Wii_U) games the amiibo can be used with.
        public let wiiu: [Game]
        
        /// /// A list of [Nintendo Switch system](https://en.wikipedia.org/wiki/Nintendo_Switch) games the amiibo can be used with.
        public let `switch`: [Game]
    }

}

// MARK: - Codable

extension DTO.Amiibo: Codable {
    
    // MARK: Keys
    
    enum CodingKeys: String, CodingKey {
        case type
        case head
        case tail
        case name
        case character
        case series = "amiiboSeries"
        case gameSeries
        case imageURL = "image"
        case release
        case games3DS
        case gamesWiiU
        case gamesSwitch
    }
    
    // MARK: Decoding
    
    /// Initialises this model by decoding from the given decoder.
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: A `DecodingError` error in case the decode failed at decoding data into an expected model type.
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let games3ds = try container.decodeIfPresent([Game].self, forKey: .games3DS)
        let gamesWiiU = try container.decodeIfPresent([Game].self, forKey: .gamesWiiU)
        let gamesSwitch = try container.decodeIfPresent([Game].self, forKey: .gamesSwitch)
        
        self.type = try container.decode(String.self, forKey: .type)
        self.head = try container.decode(String.self, forKey: .head)
        self.tail = try container.decode(String.self, forKey: .tail)
        self.name = try container.decode(String.self, forKey: .name)
        self.character = try container.decode(String.self, forKey: .character)
        self.series = try container.decode(String.self, forKey: .series)
        self.gameSeries = try container.decode(String.self, forKey: .gameSeries)
        self.imageURL = try container.decode(URL.self, forKey: .imageURL)
        self.release = try container.decode(Release.self, forKey: .release)
        self.games = {
            if let games3ds, let gamesWiiU, let gamesSwitch {
                return .init(
                    n3ds: games3ds,
                    wiiu: gamesWiiU,
                    switch: gamesSwitch
                )
            } else {
                return nil
            }
        }()
    }
    
    // MARK: Encoding
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(head, forKey: .head)
        try container.encode(tail, forKey: .tail)
        try container.encode(name, forKey: .name)
        try container.encode(character, forKey: .character)
        try container.encode(series, forKey: .series)
        try container.encode(gameSeries, forKey: .gameSeries)
        try container.encode(imageURL, forKey: .imageURL)
        try container.encode(release, forKey: .release)
        
        if let games {
            try container.encode(games.n3ds, forKey: .games3DS)
            try container.encode(games.wiiu, forKey: .gamesWiiU)
            try container.encode(games.switch, forKey: .gamesSwitch)
        }
    }

}
