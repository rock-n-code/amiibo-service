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

import AmiiboService
import Testing

@Suite("Filter conformances")
struct FilterConformanceTests {

    // MARK: Equatable tests

    @Test("compares amiibo filters by value")
    func amiiboFilterEquality() {
        // GIVEN
        // WHEN
        // THEN
        #expect(AmiiboFilter() == AmiiboFilter())
        #expect(AmiiboFilter(name: "zelda") == AmiiboFilter(name: "zelda"))
        #expect(AmiiboFilter(name: "zelda") != AmiiboFilter(name: "mario"))
        #expect(AmiiboFilter() != AmiiboFilter(showGames: true))
    }

    @Test("compares key-name filters by value")
    func keyNameFilterEquality() {
        // GIVEN
        // WHEN
        // THEN
        #expect(AmiiboSeriesFilter() == AmiiboSeriesFilter())
        #expect(AmiiboSeriesFilter(key: "0x01") == AmiiboSeriesFilter(key: "0x01"))
        #expect(AmiiboSeriesFilter(key: "0x01") != AmiiboSeriesFilter(name: "0x01"))
        #expect(AmiiboTypeFilter(name: "Card") != AmiiboTypeFilter(name: "Figure"))
        #expect(GameCharacterFilter(key: "0x0100") != GameCharacterFilter())
        #expect(GameSeriesFilter(name: "Pikmin") == GameSeriesFilter(name: "Pikmin"))
    }

    // MARK: Hashable tests

    @Test("hashes equal filters alike")
    func filterHashing() {
        // GIVEN
        let amiiboFilters: Set = [AmiiboFilter(name: "zelda"), AmiiboFilter(name: "zelda"), AmiiboFilter(name: "mario")]
        let seriesFilters: Set = [AmiiboSeriesFilter(key: "0x01"), AmiiboSeriesFilter(key: "0x01"), AmiiboSeriesFilter()]

        // WHEN
        // THEN
        #expect(amiiboFilters.count == 2)
        #expect(seriesFilters.count == 2)
    }

}
