//===----------------------------------------------------------------------===//
//
// This source file is part of the AmiiboService open source project
//
// Copyright (c) 2023 Röck+Cöde VoF. and the AmiiboService project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of AmiiboService project authors
//
//===----------------------------------------------------------------------===//

import Foundation

protocol Service {
    
    // MARK:  Functions
    
    func amiibos(filter: AmiiboFilter) async throws -> [Amiibo]
    func amiiboSeries(filter: AmiiboSeriesFilter) async throws -> [AmiiboSeries]
    func amiiboTypes(filter: AmiiboTypeFilter) async throws -> [AmiiboType]
    func gameSeries(filter: GameSeriesFilter) async throws -> [GameSeries]
    func characters(filter: CharacterFilter) async throws -> [Character]
    func lastUpdated() async throws -> Date

}
