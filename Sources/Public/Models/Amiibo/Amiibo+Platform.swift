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
    public struct Platform: Sendable {
        
        // MARK: Properties
        
        public let `switch`: [Game]
        public let threeDS: [Game]
        public let wiiU: [Game]
        
        // MARK: Initialisers
        
        init?(
            _ `switch`: [Components.Schemas.AmiiboGame]?,
            _ threeDS: [Components.Schemas.AmiiboGame]?,
            _ wiiU: [Components.Schemas.AmiiboGame]?
        ) {
            guard (`switch` != nil && `switch`?.isEmpty == false)
                    || (threeDS != nil && threeDS?.isEmpty == false)
                    || (wiiU != nil && wiiU?.isEmpty == false)
            else {
                return nil
            }
            
            self.switch = {
                guard let `switch` else { return [] }
                return `switch`.map { .init($0) }
            }()
            self.threeDS = {
                guard let threeDS else { return [] }
                return threeDS.map { .init($0) }
            }()
            self.wiiU = {
                guard let wiiU else { return [] }
                return wiiU.map { .init($0) }
            }()
        }

    }
}
