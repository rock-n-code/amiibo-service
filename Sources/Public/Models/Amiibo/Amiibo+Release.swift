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

import Foundation

extension Amiibo {
    public struct Release: Sendable {
        
        // MARK: Properties
        
        public let america: Date?
        public let australia: Date?
        public let europe: Date?
        public let japan: Date?
        
        // MARK: Initialisers
        
        init(_ payload: Components.Schemas.AmiiboRelease) {
            self.america = payload.na
            self.australia = payload.au
            self.europe = payload.eu
            self.japan = payload.jp
        }
        
    }
}
