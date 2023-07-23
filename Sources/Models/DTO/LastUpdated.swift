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

public extension DTO {

    /// This model represents the latest date when the remote API has been updated.
    struct LastUpdated {
        
        // MARK: Properties
        
        /// The date of the latest update of the remote API.
        public let timestamp: Date
        
    }

}

// MARK: - Decodable

extension DTO.LastUpdated: Decodable {
    enum CodingKeys: String, CodingKey {
        case timestamp = "lastUpdated"
    }
}
