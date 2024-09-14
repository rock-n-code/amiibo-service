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

public protocol APIClient {
    
    // MARK: Functions
    
    func getAmiibos(by filter: AmiiboFilter) async throws -> [Amiibo]
    func getAmiiboSeries(by filter: AmiiboSeriesFilter) async throws -> [AmiiboSeries]
    func getAmiiboTypes(by filter: AmiiboTypeFilter) async throws -> [AmiiboType]
    func getGameCharacters(by filter: GameCharacterFilter) async throws -> [GameCharacter]
    func getGameSeries(by filter: GameSeriesFilter) async throws -> [GameSeries]
    func getLastUpdated() async throws -> Date
    
}
