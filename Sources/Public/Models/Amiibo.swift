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

import Foundation

public struct Amiibo: Sendable {
    
    // MARK: Properties
    
    public let gameCharacter: String
    public let gameSeries: String
    public let head: String
    public let image: String
    public let name: String
    public let platform: Platform?
    public let release: Release
    public let series: String
    public let tail: String
    public let type: String
    
    // MARK: Initialisers

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
    
    public var identifier: String {
        head + tail
    }
    
    public var imageURL: URL? {
        .init(string: image)
    }

}
