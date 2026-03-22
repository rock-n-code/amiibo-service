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

import Foundation

/// A model that represents an amiibo.
public struct Amiibo: Sendable, Hashable {
    
    // MARK: Properties
    
    /// The name of the game character associated with this amiibo.
    public let gameCharacter: String
    
    /// The name of the game series associated with this amiibo.
    public let gameSeries: String

    /// The first 8 hexadecimal characters of the amiibo identifier.
    public let head: String
    
    /// A URL string pointing to the image of this amiibo.
    public let image: String

    /// The name of this amiibo.
    public let name: String

    /// The game platform data for this amiibo, if available.
    public let platform: Platform?
    
    /// The release dates of this amiibo across different regions.
    public let release: Release

    /// The name of the amiibo series this amiibo belongs to.
    public let series: String
    
    /// The last 8 hexadecimal characters of the amiibo identifier.
    public let tail: String
    
    /// The type of this amiibo (e.g., Figure, Card, Yarn, Band).
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
            payload.gamesSwitch2,
            payload.games3DS,
            payload.gamesWiiU
        )
        self.release = .init(payload.release)
        self.series = payload.amiiboSeries
        self.tail = payload.tail
        self.type = payload._type
    }
    
    // MARK: Computed
    
    /// The full 16-character hexadecimal identifier, composed of the ``head`` and ``tail``.
    public var identifier: String {
        head + tail
    }
    
    /// A URL constructed from the ``image`` string, if valid.
    public var imageURL: URL? {
        .init(string: image)
    }

}
