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

public struct AmiiboFilter {
    
    // MARK: Properties
    
    public let gameCharacter: String?
    public let gameSeries: String?
    public let identifier: String?
    public let name: String?
    public let series: String?
    public let showGames: Bool?
    public let showUsage: Bool?
    public let type: String?
    
    // MARK: Initialisers
    
    public init(
        identifier: String? = nil,
        name: String? = nil,
        type: String? = nil,
        series: String? = nil,
        gameCharacter: String? = nil,
        gameSeries: String? = nil,
        showGames: Bool? = nil,
        showUsage: Bool? = nil
    ) {
        self.gameCharacter = gameCharacter
        self.gameSeries = gameSeries
        self.identifier = identifier
        self.name = name
        self.series = series
        self.showGames = showGames
        self.showUsage = showUsage
        self.type = type
    }

}
