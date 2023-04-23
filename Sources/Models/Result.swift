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

struct Result<Model: Decodable> {
    let items: [Model]
}

// MARK: - Decodable

extension Result: Decodable {
    
    // MARK: Enumerations
    
    enum CodingKeys: String, CodingKey {
        case amiibo
    }
    
    // MARK: Initialisers
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.items = try container.decode([Model].self, forKey: .amiibo)
        } catch {
            self.items = [try container.decode(Model.self, forKey: .amiibo)]
        }
    }
    
}
