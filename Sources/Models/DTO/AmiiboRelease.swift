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

extension DTO.Amiibo {
    
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

// MARK: - Codable

extension DTO.Amiibo.Release: Codable {
    
    // MARK: Keys
    
    enum CodingKeys: String, CodingKey {
        case australia = "au"
        case europe = "eu"
        case japan = "jp"
        case america = "na"
    }

}
