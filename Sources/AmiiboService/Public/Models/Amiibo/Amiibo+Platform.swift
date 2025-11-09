// ===----------------------------------------------------------------------===
// 
// This source file is part of the Amiibo Service open source project
// 
// Copyright (c) 2025 Röck+Cöde VoF. and the Amiibo Service project authors
// Licensed under Apache license v2.0
// 
// See LICENSE for license information
// See CONTRIBUTORS for the list of Amiibo Service project authors
//
// SPDX-License-Identifier: Apache-2.0
// 
// ===----------------------------------------------------------------------===

extension Amiibo {
    /// A model that represents a collection of  `Switch`,  `Switch 2`, `3DS`, and `WiiU` games related to an amiibo.
    public struct Platform: Sendable {
        
        // MARK: Properties
        
        /// A list of `Switch` games related to an amiibo.
        public let `switch`: [Game]
        
        /// A list of `Switch 2` games related to an amiibo.
        public let switch2: [Game]

        /// A list of `3DS` games related to an amiibo.
        public let threeDS: [Game]
        
        /// A list of `WiiU` games related to an amiibo.
        public let wiiU: [Game]
        
        // MARK: Initializers
        
        /// Initializes this model.
        ///
        /// > important: In case no data is provided, then an instance of this model is not created.
        ///
        /// - Parameters:
        ///   - switch: A list of `Switch` games related to an amiibo, if any.
        ///   - switch2: A list of `Switch 2` games related to an amiibo, if any.
        ///   - threeDS: A list of `3DS` games related to an amiibo, if any.
        ///   - wiiU: A list of `WiiU` games related to an amiibo, if any.
        init?(
            _ `switch`: [Components.Schemas.AmiiboGame]?,
            _ switch2: [Components.Schemas.AmiiboGame]?,
            _ threeDS: [Components.Schemas.AmiiboGame]?,
            _ wiiU: [Components.Schemas.AmiiboGame]?
        ) {
            guard (`switch` != nil && `switch`?.isEmpty == false)
                    || (switch2 != nil && switch2?.isEmpty == false)
                    || (threeDS != nil && threeDS?.isEmpty == false)
                    || (wiiU != nil && wiiU?.isEmpty == false)
            else {
                return nil
            }
            
            self.switch = {
                guard let `switch` else { return [] }
                return `switch`.map { .init($0) }
            }()
            self.switch2 = {
                guard let switch2 else { return [] }
                return switch2.map { .init($0) }
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
