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
import Foundation
import Testing

@Suite("Model conformances")
struct ModelConformanceTests {

    // MARK: Identifiable tests

    @Test("identifies an amiibo by its identifier")
    func amiiboID() {
        // GIVEN
        let amiibos = Fixtures.amiibos

        // WHEN
        // THEN
        #expect(amiibos.map(\.id) == amiibos.map(\.identifier))
    }

    @Test("identifies key-name models by their keys")
    func keyNameIDs() {
        // GIVEN
        // WHEN
        // THEN
        #expect(Fixtures.amiiboSeries.map(\.id) == Fixtures.amiiboSeries.map(\.key))
        #expect(Fixtures.amiiboTypes.map(\.id) == Fixtures.amiiboTypes.map(\.key))
        #expect(Fixtures.gameCharacters.map(\.id) == Fixtures.gameCharacters.map(\.key))
        #expect(Fixtures.gameSeries.map(\.id) == Fixtures.gameSeries.map(\.key))
    }

    // MARK: Codable tests

    @Test("round-trips amiibos through JSON")
    func amiibosRoundTrip() throws {
        // GIVEN
        let amiibos = Fixtures.amiibos

        // WHEN
        let decoded = try roundTrip(amiibos)

        // THEN
        #expect(decoded == amiibos)
        #expect(decoded.first?.platform?.switch.first?.usages?.isEmpty == false)
    }

    @Test("round-trips key-name models through JSON")
    func keyNameRoundTrip() throws {
        // GIVEN
        // WHEN
        // THEN
        #expect(try roundTrip(Fixtures.amiiboSeries) == Fixtures.amiiboSeries)
        #expect(try roundTrip(Fixtures.amiiboTypes) == Fixtures.amiiboTypes)
        #expect(try roundTrip(Fixtures.gameCharacters) == Fixtures.gameCharacters)
        #expect(try roundTrip(Fixtures.gameSeries) == Fixtures.gameSeries)
    }

}

// MARK: - Helpers

private extension ModelConformanceTests {

    // MARK: Functions

    /// Encodes a value to JSON and decodes it back.
    func roundTrip<Value: Codable>(_ value: Value) throws -> Value {
        try JSONDecoder().decode(Value.self, from: JSONEncoder().encode(value))
    }

}
