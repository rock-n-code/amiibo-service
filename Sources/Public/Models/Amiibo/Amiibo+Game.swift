//===----------------------------------------------------------------------===
//
// This source file is part of the AmiiboAPI open source project
//
// Copyright (c) 2024 Röck+Cöde VoF. and the AmiiboAPI project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE for license information
// See CONTRIBUTORS for the list of AmiiboAPI project authors
//
//===----------------------------------------------------------------------===

extension Amiibo {
    public struct Game: Sendable {
        
        // MARK: Properties
        
        public let identifiers: [String]
        public let name: String
        public let usages: [Usage]?
        
        // MARK: Initialisers
        
        init(_ payload: Components.Schemas.AmiiboGame) {
            self.identifiers = payload.gameID
            self.name = payload.gameName
            self.usages = {
                guard let usages = payload.amiiboUsage else {
                    return nil
                }
                
                return usages.map { .init($0) }
            }()
        }
        
    }
}
