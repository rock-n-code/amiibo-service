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

import Foundation

/// A model that represents an amiibo item.
public struct Amiibo: Sendable {
    
    // MARK: Properties
    
    /// A game character.
    public let gameCharacter: String
    
    /// A game series.
    public let gameSeries: String

    /// The first 8 hexadecimal characters of an identifier.
    public let head: String
    
    /// An image link.
    public let image: String

    /// An amiibo name.
    public let name: String

    /// A game platform type, if any.
    public let platform: Platform?
    
    /// A release date.
    public let release: Release

    /// An amiibo series.
    public let series: String
    
    /// The last 8 hexadecimal characters of an identifier.
    public let tail: String
    
    /// An amiibo type.
    public let type: String
    
    // MARK: Initializers
    
    /// Initializes this model from a given payload.
    /// - Parameter payload: A payload that contains the values for the model.
    init(_ payload: Components.Schemas.Amiibo) {
        self.gameCharacter = payload.character
        self.gameSeries = payload.gameSeries
        self.head = payload.head
        self.image = payload.image
        self.name = payload.name
        self.platform = .init(
            payload.gamesSwitch,
            payload.games3DS,
            payload.gamesWiiU
        )
        self.release = .init(payload.release)
        self.series = payload.amiiboSeries
        self.tail = payload.tail
        self.type = payload._type
    }
    
    // MARK: Computed
    
    /// An identifier.
    public var identifier: String {
        head + tail
    }
    
    /// A URL related to an image link, if any.
    public var imageURL: URL? {
        .init(string: image)
    }

}
