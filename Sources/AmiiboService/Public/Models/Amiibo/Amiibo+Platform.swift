// ===----------------------------------------------------------------------===
// 
// This source file is part of the Amiibo Service open source project
// 
// Copyright (c) 2026 Röck+Cöde VoF. and the Amiibo Service project authors
// Licensed under Apache license v2.0
// 
// See LICENSE for license information
// See CONTRIBUTORS for the list of Amiibo Service project authors
//
// SPDX-License-Identifier: Apache-2.0
// 
// ===----------------------------------------------------------------------===

extension Amiibo {
    /// A model that represents a collection of `Switch`, `Switch 2`, `3DS`, and `Wii U` games related to an amiibo.
    public struct Platform: Sendable, Hashable {
        
        // MARK: Properties
        
        /// A list of `Switch` games related to an amiibo.
        public let `switch`: [Game]
        
        /// A list of `Switch 2` games related to an amiibo.
        public let switch2: [Game]

        /// A list of `3DS` games related to an amiibo.
        public let threeDS: [Game]
        
        /// A list of `Wii U` games related to an amiibo.
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
        ///   - wiiU: A list of `Wii U` games related to an amiibo, if any.
        init?(
            _ `switch`: [Components.Schemas.AmiiboGame]?,
            _ switch2: [Components.Schemas.AmiiboGame]?,
            _ threeDS: [Components.Schemas.AmiiboGame]?,
            _ wiiU: [Components.Schemas.AmiiboGame]?
        ) {
            guard `switch`?.isEmpty == false
                    || switch2?.isEmpty == false
                    || threeDS?.isEmpty == false
                    || wiiU?.isEmpty == false
            else {
                return nil
            }
            
            self.switch = `switch`?.map { .init($0) } ?? []
            self.switch2 = switch2?.map { .init($0) } ?? []
            self.threeDS = threeDS?.map { .init($0) } ?? []
            self.wiiU = wiiU?.map { .init($0) } ?? []
        }

    }
}
