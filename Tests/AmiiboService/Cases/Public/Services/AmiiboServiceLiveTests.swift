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

@Suite(
    "Amiibo Service",
    .tags(.live),
    .enabled(
        if: ProcessInfo.processInfo.environment["AMIIBO_LIVE_TESTS"] == "1",
        "Set the 'AMIIBO_LIVE_TESTS' environment variable to '1' to run these tests against the live service."
    )
)
struct AmiiboServiceLiveTests {
    
    // MARK: Properties
    
    private let service: AmiiboService
    
    // MARK: Initializers
    
    init() {
        self.service = .init()
    }
    
    // MARK: Functions tests
    
    @Test(arguments: zip(
        Input.amiibos,
        Output.amiibos
    ))
    func `get amiibos`(
        filter: AmiiboFilter,
        expects count: ExpectedCount
    ) async throws {
        try await assertAmiibos(
            with: filter,
            expects: count
        )
    }
    
    @Test(arguments: zip(
        Input.amiibosThrows,
        Output.amiibosThrows
    ))
    func `get amiibos throws`(
        filter: AmiiboFilter,
        expects error: AmiiboServiceError
    ) async throws {
        try await assertsAmiibosThrows(
            error: error,
            when: filter
        )
    }

    @Test(arguments: zip(
        Input.amiiboSeries,
        Output.amiiboSeries
    ))
    func `get amiibo series`(
        filter: AmiiboSeriesFilter,
        expects count: ExpectedCount
    ) async throws {
        try await assertAmiiboSeries(
            with: filter,
            expects: count
        )
    }
    
    @Test(arguments: zip(
        Input.amiiboSeriesThrows,
        Output.amiiboSeriesThrows
    ))
    func `get amiibo series throws`(
        filter: AmiiboSeriesFilter,
        expects error: AmiiboServiceError
    ) async throws {
        try await assertsAmiiboSeriesThrows(
            error: error,
            when: filter
        )
    }
    
    @Test(arguments: zip(
        Input.amiiboTypes,
        Output.amiiboTypes
    ))
    func `get amiibo types`(
        filter: AmiiboTypeFilter,
        expects count: ExpectedCount
    ) async throws {
        try await assertAmiiboTypes(
            with: filter,
            expects: count
        )
    }
    
    @Test(arguments: zip(
        Input.amiiboTypesThrows,
        Output.amiiboTypesThrows
    ))
    func `get amiibo types throws`(
        filter: AmiiboTypeFilter,
        expects error: AmiiboServiceError
    ) async throws {
        try await assertsAmiiboTypesThrows(
            error: error,
            when: filter
        )
    }

    @Test(arguments: zip(
        Input.gameCharacters,
        Output.gameCharacters
    ))
    func `get game characters`(
        filter: GameCharacterFilter,
        expects count: ExpectedCount
    ) async throws {
        try await assertGameCharacters(
            with: filter,
            expects: count
        )
    }
    
    @Test(arguments: zip(
        Input.gameCharactersThrows,
        Output.gameCharactersThrows
    ))
    func `get game characters throws`(
        filter: GameCharacterFilter,
        expects error: AmiiboServiceError
    ) async throws {
        try await assertsGameCharactersThrows(
            error: error,
            when: filter
        )
    }

    @Test(arguments: zip(
        Input.gameSeries,
        Output.gameSeries
    ))
    func `get game series`(
        filter: GameSeriesFilter,
        expects count: ExpectedCount
    ) async throws {
        try await assertGameSeries(
            with: filter,
            expects: count
        )
    }
    
    @Test(arguments: zip(
        Input.gameSeriesThrows,
        Output.gameSeriesThrows
    ))
    func `get game series throws`(
        filter: GameSeriesFilter,
        expects error: AmiiboServiceError
    ) async throws {
        try await assertsGameSeriesThrows(
            error: error,
            when: filter
        )
    }
    
    @Test
    func `get the last updated timestamp`() async throws {
        try await assertLastUpdated(
            onOrAfterDay: 24,
            month: 7,
            year: 2026
        )
    }
    
}

// MARK: - Assertions

private extension AmiiboServiceLiveTests {
    
    // MARK: Functions
    
    /// Asserts the number of items returned by the `amiibos` endpoint that matched a given filter.
    /// - Parameters:
    ///   - filter: An amiibo filter type.
    ///   - count: An expected count of items to be returned.
    func assertAmiibos(
        with filter: AmiiboFilter,
        expects count: ExpectedCount
    ) async throws {
        // GIVEN
        // WHEN
        let amiibos = try await service.getAmiibos(filter)
        
        // THEN
        assert(amiibos.count, matches: count)
        
        guard
            !amiibos.isEmpty,
            (filter.showGames == true || filter.showUsage == true)
        else { return }
        
        let firstAmiiboPlatform = try #require(amiibos.first?.platform)
        
        #expect(amiibos.last?.platform != nil)

        if filter.showUsage == true {
            #expect(firstAmiiboPlatform.switch.first?.usages?.isEmpty == false)
            // Given the live data is still not returning any Switch 2 games.
            #expect(firstAmiiboPlatform.switch2.isEmpty == true)
            #expect(firstAmiiboPlatform.threeDS.first?.usages?.isEmpty == false)
            #expect(firstAmiiboPlatform.wiiU.first?.usages?.isEmpty == false)
        }
    }
    
    /// Asserts the error thrown by the `amiibos` endpoint.
    /// - Parameters:
    ///   - error: An expected error.
    ///   - filter: An amiibo filter type.
    func assertsAmiibosThrows(
        error: AmiiboServiceError,
        when filter: AmiiboFilter
    ) async throws {
        // GIVEN
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.getAmiibos(filter)
        }
    }
    
    /// Asserts the number of items returned by the `amiiboSeries` endpoint that matched a given filter.
    /// - Parameters:
    ///   - filter: An amiibo series filter type.
    ///   - count: An expected count of items to be returned.
    func assertAmiiboSeries(
        with filter: AmiiboSeriesFilter,
        expects count: ExpectedCount
    ) async throws {
        // GIVEN
        // WHEN
        let amiiboSeries = try await service.getAmiiboSeries(filter)
        
        // THEN
        assert(amiiboSeries.count, matches: count)
    }
    
    /// Asserts the error thrown by the `amiiboSeries` endpoint.
    /// - Parameters:
    ///   - error: An expected error.
    ///   - filter: An amiibo series filter type.
    func assertsAmiiboSeriesThrows(
        error: AmiiboServiceError,
        when filter: AmiiboSeriesFilter
    ) async throws {
        // GIVEN
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.getAmiiboSeries(filter)
        }
    }
    
    /// Asserts the number of items returned by the `amiiboTypes` endpoint that matched a given filter.
    /// - Parameters:
    ///   - filter: An amiibo type filter type.
    ///   - count: An expected count of items to be returned.
    func assertAmiiboTypes(
        with filter: AmiiboTypeFilter,
        expects count: ExpectedCount
    ) async throws {
        // GIVEN
        // WHEN
        let amiiboTypes = try await service.getAmiiboTypes(filter)
        
        // THEN
        assert(amiiboTypes.count, matches: count)
    }
    
    /// Asserts the error thrown by the `amiiboTypes` endpoint.
    /// - Parameters:
    ///   - error: An expected error.
    ///   - filter: An amiibo type filter type.
    func assertsAmiiboTypesThrows(
        error: AmiiboServiceError,
        when filter: AmiiboTypeFilter
    ) async throws {
        // GIVEN
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.getAmiiboTypes(filter)
        }
    }
    
    /// Asserts the number of items returned by the `gameCharacters` endpoint that matched a given filter.
    /// - Parameters:
    ///   - filter: A game character filter type.
    ///   - count: An expected count of items to be returned.
    func assertGameCharacters(
        with filter: GameCharacterFilter,
        expects count: ExpectedCount
    ) async throws {
        // GIVEN
        // WHEN
        let gameCharacters = try await service.getGameCharacters(filter)
        
        // THEN
        assert(gameCharacters.count, matches: count)
    }
    
    /// Asserts the error thrown by the `gameCharacters` endpoint.
    /// - Parameters:
    ///   - error: An expected error.
    ///   - filter: A game character filter type.
    func assertsGameCharactersThrows(
        error: AmiiboServiceError,
        when filter: GameCharacterFilter
    ) async throws {
        // GIVEN
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.getGameCharacters(filter)
        }
    }
    
    /// Asserts the number of items returned by the `gameSeries` endpoint that matched a given filter.
    /// - Parameters:
    ///   - filter: A game series filter type.
    ///   - count: An expected count of items to be returned.
    func assertGameSeries(
        with filter: GameSeriesFilter,
        expects count: ExpectedCount
    ) async throws {
        // GIVEN
        // WHEN
        let gameSeries = try await service.getGameSeries(filter)
        
        // THEN
        assert(gameSeries.count, matches: count)
    }
    
    /// Asserts the error thrown by the `gameSeries` endpoint.
    /// - Parameters:
    ///   - error: An expected error.
    ///   - filter: A game series filter type.
    func assertsGameSeriesThrows(
        error: AmiiboServiceError,
        when filter: GameSeriesFilter
    ) async throws {
        // GIVEN
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.getGameSeries(filter)
        }
    }
    
    /// Asserts the date returned by the `lastUpdated` endpoint is within a plausible range.
    ///
    /// The live service updates its data over time, so this assertion checks the returned date is not before the last known update and not in the future, instead of matching an exact date that would break on every update.
    ///
    /// - Parameters:
    ///   - day: A number of day of the earliest expected last updated date.
    ///   - month: A number of month of the earliest expected last updated date.
    ///   - year: A number of year of the earliest expected last updated date.
    func assertLastUpdated(
        onOrAfterDay day: Int,
        month: Int,
        year: Int
    ) async throws {
        // GIVEN
        var calendar = Calendar(identifier: .gregorian)
        
        calendar.timeZone = try #require(TimeZone(secondsFromGMT: 0))
        
        let earliest = try #require(calendar.date(from: .init(
            year: year,
            month: month,
            day: day
        )))
        
        // WHEN
        let dateLastUpdated = try await service.getLastUpdated()
        
        // THEN
        #expect(dateLastUpdated >= earliest)
        #expect(dateLastUpdated <= .now)
    }
    
    /// Asserts an actual number of items matches an expected count.
    /// - Parameters:
    ///   - actualCount: A number of items returned by an endpoint.
    ///   - expectation: An expected count to match the number of items against.
    func assert(_ actualCount: Int, matches expectation: ExpectedCount) {
        switch expectation {
        case let .exactly(expected):
            #expect(actualCount == expected)
        case let .atLeast(minimum):
            #expect(actualCount >= minimum)
        }
    }
    
}

// MARK: - Expectations

/// An expectation about the number of items returned by an endpoint of the live service.
enum ExpectedCount {
    /// The endpoint is expected to return exactly the associated number of items.
    case exactly(Int)
    /// The endpoint is expected to return at least the associated number of items, as the data at the live service grows over time.
    case atLeast(Int)
}

// MARK: - Arguments

enum Input {
    /// A list of amiibo filters to input to the `assertAmiibos` assertion.
    static let amiibos: [AmiiboFilter] = [
        .init(),
        .init(head: "00000000"),
        .init(head: "0000"),
        .init(tail: "00000002"),
        .init(tail: "0002"),
        .init(identifier: "0000000000000002"),
        .init(identifier: "0000000000000000"),
        .init(identifier: "0000000"),
        .init(name: "zelda"),
        .init(name: "Something"),
        .init(name: "zel"),
        .init(name: .empty),
        .init(type: "0x00"),
        .init(type: "Figure"),
        .init(type: "0x0f"),
        .init(type: "something"),
        .init(type: "fig"),
        .init(type: .empty),
        .init(series: "0x00"),
        .init(series: "Legend of Zelda"),
        .init(series: "0xf9"),
        .init(series: "something"),
        .init(series: "fig"),
        .init(series: .empty),
        .init(gameCharacter: "0x00"),
        .init(gameCharacter: "Zelda"),
        .init(gameCharacter: "0xf9"),
        .init(gameCharacter: "something"),
        .init(gameCharacter: "fig"),
        .init(gameCharacter: .empty),
        .init(gameSeries: "0x00"),
        .init(gameSeries: "Legend of Zelda"),
        .init(gameSeries: "0xf9"),
        .init(gameSeries: "something"),
        .init(gameSeries: "Super"),
        .init(gameSeries: .empty),
        .init(showGames: true),
        .init(showUsage: true)
    ]
    /// A list of amiibo series filters to input to the `assertAmiibosThrows` assertion.
    static let amiibosThrows: [AmiiboFilter] = [
        .init(head: .empty),
        .init(tail: .empty),
        .init(identifier: .empty),
        .init(type: "0x"),
        .init(series: "0x"),
        .init(gameCharacter: "0x"),
        .init(gameSeries: "0x"),
    ]
    /// A list of amiibo series filters to input to the `assertAmiiboSeries` assertion.
    static let amiiboSeries: [AmiiboSeriesFilter] = [
        .init(),
        .init(key: "0x01"),
        .init(name: "Legend of Zelda"),
        .init(name: "Zelda"),
        .init(name: .empty)
    ]
    /// A list of amiibo series filters to input to the `assertAmiiboSeriesThrows` assertion.
    static let amiiboSeriesThrows: [AmiiboSeriesFilter] = [
        .init(key: "0xf9"),
        .init(key: "0x"),
        .init(key: .empty),
        .init(name: "Something")
    ]
    /// A list of amiibo type filters to input to the `assertAmiiboTypes` assertion.
    static let amiiboTypes: [AmiiboTypeFilter] = [
        .init(),
        .init(key: "0x01"),
        .init(name: "Card"),
        .init(name: "Ca"),
        .init(name: .empty)
    ]
    /// A list of amiibo type filters to input to the `assertAmiiboTypesThrows` assertion.
    static let amiiboTypesThrows: [AmiiboTypeFilter] = [
        .init(key: "0x09"),
        .init(key: "0x"),
        .init(key: .empty),
        .init(name: "Something")
    ]
    /// A list of game character filters to input to the `assertGameCharacters` assertion.
    static let gameCharacters: [GameCharacterFilter] = [
        .init(),
        .init(key: "0x0001"),
        .init(name: "Zelda"),
        .init(name: "Zeld"),
        .init(name: .empty)
    ]
    /// A list of game character filters to input to the `assertGameCharactersThrows` assertion.
    static let gameCharactersThrows: [GameCharacterFilter] = [
        .init(key: "0xffff"),
        .init(key: "0x"),
        .init(key: .empty),
        .init(name: "Something")
    ]
    /// A list of game series filters to input to the `assertGameSeries` assertion.
    static let gameSeries: [GameSeriesFilter] = [
        .init(),
        .init(key: "0x001"),
        .init(name: "Pikmin"),
        .init(name: "Pik"),
        .init(name: .empty)
    ]
    /// A list of game series filters to input to the `assertGameSeriesThrows` assertion.
    static let gameSeriesThrows: [GameSeriesFilter] = [
        .init(key: "0xffff"),
        .init(key: "0x"),
        .init(key: .empty),
        .init(name: "Something")
    ]
}

enum Output {
    /// A list of expected counts from the `assertAmiibos` assertion.
    ///
    /// Counts for filters that match a growing set of items are expressed as `atLeast` minimums, so the tests do not break whenever new amiibo items are added to the live service.
    static let amiibos: [ExpectedCount] = [
        .atLeast(.minimumAmiibos),
        .atLeast(7), .atLeast(7),
        .exactly(1), .atLeast(1),
        .exactly(1), .exactly(.zero), .exactly(.zero),
        .atLeast(5), .exactly(.zero), .atLeast(7), .atLeast(.minimumAmiibos),
        .atLeast(254), .atLeast(254), .exactly(.zero), .exactly(.zero), .exactly(.zero), .exactly(.zero),
        .atLeast(96), .atLeast(26), .exactly(.zero), .exactly(.zero), .atLeast(63), .atLeast(.minimumAmiibos),
        .atLeast(14), .atLeast(6), .exactly(.zero), .exactly(.zero), .exactly(.zero), .atLeast(.minimumAmiibos),
        .atLeast(53), .atLeast(32), .exactly(.zero), .exactly(.zero), .atLeast(152), .atLeast(.minimumAmiibos),
        .atLeast(.minimumAmiibos), .atLeast(.minimumAmiibos)
    ]
    /// A list of errors are expected to be thrown from the `assertAmiibosThrows` assertion.
    static let amiibosThrows: [AmiiboServiceError] = [.badRequest, .badRequest, .badRequest, .badRequest, .badRequest, .badRequest, .badRequest]
    /// A list of expected counts from the `assertAmiiboSeries` assertion.
    static let amiiboSeries: [ExpectedCount] = [.atLeast(.minimumAmiiboSeries), .exactly(1), .exactly(1), .exactly(1), .atLeast(.minimumAmiiboSeries)]
    /// A list of errors are expected to be thrown from the `assertAmiiboSeriesThrows` assertion.
    static let amiiboSeriesThrows: [AmiiboServiceError] = [.notFound, .badRequest, .badRequest, .notFound]
    /// A list of expected counts from the `assertAmiiboTypes` assertion.
    static let amiiboTypes: [ExpectedCount] = [.atLeast(.minimumAmiiboTypes), .exactly(1), .exactly(1), .exactly(1), .atLeast(.minimumAmiiboTypes)]
    /// A list of errors are expected to be thrown from the `assertAmiiboTypesThrows` assertion.
    static let amiiboTypesThrows: [AmiiboServiceError] = [.notFound, .badRequest, .badRequest, .notFound]
    /// A list of expected counts from the `assertGameCharacters` assertion.
    static let gameCharacters: [ExpectedCount] = [.atLeast(.minimumGameCharacters), .exactly(1), .exactly(1), .exactly(1), .atLeast(.minimumGameCharacters)]
    /// A list of errors are expected to be thrown from the `assertGameCharactersThrows` assertion.
    static let gameCharactersThrows: [AmiiboServiceError] = [.notFound, .badRequest, .badRequest, .notFound]
    /// A list of expected counts from the `assertGameSeries` assertion.
    static let gameSeries: [ExpectedCount] = [.atLeast(.minimumGameSeries), .exactly(1), .exactly(1), .exactly(1), .atLeast(.minimumGameSeries)]
    /// A list of errors are expected to be thrown from the `assertGameSeriesThrows` assertion.
    static let gameSeriesThrows: [AmiiboServiceError] = [.notFound, .badRequest, .badRequest, .notFound]
}

// MARK: - Constants

private extension Int {
    /// A number that represents the minimum number of amiibo items expected from the live service, as of July 2026.
    static let minimumAmiibos = 946
    /// A number that represents the minimum number of amiibo series expected from the live service, as of July 2026.
    static let minimumAmiiboSeries = 31
    /// A number that represents the minimum number of amiibo types expected from the live service, as of July 2026.
    static let minimumAmiiboTypes = 5
    /// A number that represents the minimum number of game characters expected from the live service, as of July 2026.
    static let minimumGameCharacters = 681
    /// A number that represents the minimum number of game series expected from the live service, as of July 2026.
    static let minimumGameSeries = 118
}

private extension String {
    /// An empty string.
    static let empty = ""
}
