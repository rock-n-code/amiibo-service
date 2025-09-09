//===----------------------------------------------------------------------===
//
// This source file is part of the AmiiboService open source project
//
// Copyright (c) 2024-2025 Röck+Cöde VoF. and the AmiiboAPI project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE for license information
// See CONTRIBUTORS for the list of AmiiboAPI project authors
//
//===----------------------------------------------------------------------===

extension Amiibo {
    public struct Usage: Sendable {
        
        // MARK: Properties
        
        public let explanation: String
        public let isWriteable: Bool
        
        // MARK: Initialisers
        
        init(_ payload: Components.Schemas.AmiiboUsage) {
            self.explanation = payload.Usage
            self.isWriteable = payload.write
        }
        
    }
}
