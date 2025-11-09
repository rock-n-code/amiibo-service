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

import AmiiboService
import Foundation
import Testing

@Suite("Amiibo Service", .tags(.live))
struct AmiiboServiceLiveTests {
    
    // MARK: Properties
    
    private let service: AmiiboService
    
    // MARK: Initializers
    
    init() {
        self.service = .init()
    }
    
    // MARK: Functions tests
    
#if swift(>=6.2)
    @Test(arguments: zip(
        Input.amiibos,
        Output.amiibos
    ))
    func `get amiibos`(
        filter: AmiiboFilter,
        expects numberOfItems: Int
    ) async throws {
        try await assertAmiibos(
            with: filter,
            expects: numberOfItems
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
        expects numberOfItems: Int
    ) async throws {
        try await assertAmiiboSeries(
            with: filter,
            expects: numberOfItems
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
        expects numberOfItems: Int
    ) async throws {
        try await assertAmiiboTypes(
            with: filter,
            expects: numberOfItems
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
        expects numberOfItems: Int
    ) async throws {
        try await assertGameCharacters(
            with: filter,
            expects: numberOfItems
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
        expects numberOfItems: Int
    ) async throws {
        try await assertGameSeries(
            with: filter,
            expects: numberOfItems
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
            day: 7,
            month: 11,
            year: 2025
        )
    }
#else
    @Test("get amiibos", arguments: zip(
        Input.amiibos,
        Output.amiibos
    ))
    func getAmiibos(
        filter: AmiiboFilter,
        expects numberOfItems: Int
    ) async throws {
        try await assertAmiibos(
            with: filter,
            expects: numberOfItems
        )
    }
    
    @Test("get amiibos throws", arguments: zip(
        Input.amiibosThrows,
        Output.amiibosThrows
    ))
    func getAmiibosThrows(
        filter: AmiiboFilter,
        expects error: AmiiboServiceError
    ) async throws {
        try await assertsAmiibosThrows(
            error: error,
            when: filter
        )
    }
    
    @Test("get amiibo series", arguments: zip(
        Input.amiiboSeries,
        Output.amiiboSeries
    ))
    func getAmiiboSeries(
        filter: AmiiboSeriesFilter,
        expects numberOfItems: Int
    ) async throws {
        try await assertAmiiboSeries(
            with: filter,
            expects: numberOfItems
        )
    }
    
    @Test("get amiibo series throws", arguments: zip(
        Input.amiiboSeriesThrows,
        Output.amiiboSeriesThrows
    ))
    func getAmiiboSeriesThrows(
        filter: AmiiboSeriesFilter,
        expects error: AmiiboServiceError
    ) async throws {
        try await assertsAmiiboSeriesThrows(
            error: error,
            when: filter
        )
    }

    @Test("get amiibo types", arguments: zip(
        Input.amiiboTypes,
        Output.amiiboTypes
    ))
    func getAmiiboTypes(
        filter: AmiiboTypeFilter,
        expects numberOfItems: Int
    ) async throws {
        try await assertAmiiboTypes(
            with: filter,
            expects: numberOfItems
        )
    }
    
    @Test("get amiibo types throws", arguments: zip(
        Input.amiiboTypesThrows,
        Output.amiiboTypesThrows
    ))
    func getAmiiboTypesThrows(
        filter: AmiiboTypeFilter,
        expects error: AmiiboServiceError
    ) async throws {
        try await assertsAmiiboTypesThrows(
            error: error,
            when: filter
        )
    }

    @Test("get game characters", arguments: zip(
        Input.gameCharacters,
        Output.gameCharacters
    ))
    func getGameCharacters(
        filter: GameCharacterFilter,
        expects numberOfItems: Int
    ) async throws {
        try await assertGameCharacters(
            with: filter,
            expects: numberOfItems
        )
    }
    
    @Test("get game characters throws", arguments: zip(
        Input.gameCharactersThrows,
        Output.gameCharactersThrows
    ))
    func getGameCharactersThrows(
        filter: GameCharacterFilter,
        expects error: AmiiboServiceError
    ) async throws {
        try await assertsGameCharactersThrows(
            error: error,
            when: filter
        )
    }

    @Test("get game series", arguments: zip(
        Input.gameSeries,
        Output.gameSeries
    ))
    func getGameSeries(
        filter: GameSeriesFilter,
        expects numberOfItems: Int
    ) async throws {
        try await assertGameSeries(
            with: filter,
            expects: numberOfItems
        )
    }
    
    @Test("get game series throws", arguments: zip(
        Input.gameSeriesThrows,
        Output.gameSeriesThrows
    ))
    func getGameSeriesThrows(
        filter: GameSeriesFilter,
        expects error: AmiiboServiceError
    ) async throws {
        try await assertsGameSeriesThrows(
            error: error,
            when: filter
        )
    }
    
    @Test("get last updated timestamp")
    func getLastUpdated() async throws {
        try await assertLastUpdated(
            day: 7,
            month: 11,
            year: 2025
        )
    }
#endif
    
}

// MARK: - Assertions

private extension AmiiboServiceLiveTests {
    
    // MARK: Functions
    
    /// Asserts the number of items returned by the `amiibos` endpoint that matched a given filter.
    /// - Parameters:
    ///   - filter: An amiibo filter type.
    ///   - numberOfItems: An expected number of items returned.
    func assertAmiibos(
        with filter: AmiiboFilter,
        expects numberOfItems: Int
    ) async throws {
        // GIVEN
        // WHEN
        let amiibos = try await service.getAmiibos(filter)
        
        // THEN
        #expect(amiibos.count == numberOfItems)
        
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
    ///   - numberOfItems: An expected number of items returned.
    func assertAmiiboSeries(
        with filter: AmiiboSeriesFilter,
        expects numberOfItems: Int
    ) async throws {
        // GIVEN
        // WHEN
        let amiiboSeries = try await service.getAmiiboSeries(filter)
        
        // THEN
        #expect(amiiboSeries.count == numberOfItems)
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
    ///   - numberOfItems: An expected number of items returned.
    func assertAmiiboTypes(
        with filter: AmiiboTypeFilter,
        expects numberOfItems: Int
    ) async throws {
        // GIVEN
        // WHEN
        let amiiboTypes = try await service.getAmiiboTypes(filter)
        
        // THEN
        #expect(amiiboTypes.count == numberOfItems)
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
    ///   - numberOfItems: An expected number of items returned.
    func assertGameCharacters(
        with filter: GameCharacterFilter,
        expects numberOfItems: Int
    ) async throws {
        // GIVEN
        // WHEN
        let gameCharacters = try await service.getGameCharacters(filter)
        
        // THEN
        #expect(gameCharacters.count == numberOfItems)
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
    ///   - numberOfItems: An expected number of items returned.
    func assertGameSeries(
        with filter: GameSeriesFilter,
        expects numberOfItems: Int
    ) async throws {
        // GIVEN
        // WHEN
        let gameSeries = try await service.getGameSeries(filter)
        
        // THEN
        #expect(gameSeries.count == numberOfItems)
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
    
    /// Asserts the date returned by the `lastUpdated` endpoint.
    /// - Parameters:
    ///   - day: A number of day of the last updated date.
    ///   - month: A number of month of the last updated date.
    ///   - year: A number of year of the last updated date.
    func assertLastUpdated(
        day: Int,
        month: Int,
        year: Int
    ) async throws {
        // GIVEN
        // WHEN
        let dateLastUpdated = try await service.getLastUpdated()
        
        // THEN
        let dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: dateLastUpdated
        )
        
        #expect(dateComponents.year == year)
        #expect(dateComponents.month == month)
        #expect(dateComponents.day == day)
    }
    
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
    /// A list of number of items that are expected from the `assertAmiibos` assertion.
    static let amiibos: [Int] = [.totalAmiibos, 7, 7, 1, 1, 1, .zero, .zero, 5, .zero, 7, .totalAmiibos, 237, 237, .zero, .zero, .zero, .zero, 96, 26, .zero, .zero, 63, .totalAmiibos, 12, 6, .zero, .zero, .zero, .totalAmiibos, 49, 32, .zero, .zero, 147, .totalAmiibos, .totalAmiibos, .totalAmiibos]
    /// A list of errors are expected to be thrown from the `assertAmiibosThrows` assertion.
    static let amiibosThrows: [AmiiboServiceError] = [.badRequest, .badRequest, .badRequest, .badRequest, .badRequest, .badRequest, .badRequest]
    /// A list of number of items that are expected from the `assertAmiiboSeries` assertion.
    static let amiiboSeries: [Int] = [.totalAmiiboSeries, 1, 1, 1, .totalAmiiboSeries]
    /// A list of errors are expected to be thrown from the `assertAmiiboSeriesThrows` assertion.
    static let amiiboSeriesThrows: [AmiiboServiceError] = [.notFound, .badRequest, .badRequest, .notFound]
    /// A list of number of items that are expected from the `assertAmiiboTypes` assertion.
    static let amiiboTypes: [Int] = [.totalAmiiboTypes, 1, 1, 1, .totalAmiiboTypes]
    /// A list of errors are expected to be thrown from the `assertAmiiboTypesThrows` assertion.
    static let amiiboTypesThrows: [AmiiboServiceError] = [.notFound, .badRequest, .badRequest, .notFound]
    /// A list of number of items that are expected from the `assertGameCharacters` assertion.
    static let gameCharacters: [Int] = [.totalGameCharacters, 1, 1, 1, .totalGameCharacters]
    /// A list of errors are expected to be thrown from the `assertGameCharactersThrows` assertion.
    static let gameCharactersThrows: [AmiiboServiceError] = [.notFound, .badRequest, .badRequest, .notFound]
    /// A list of number of items that are expected from the `assertGameSeries` assertion.
    static let gameSeries: [Int] = [.totalGameSeries, 1, 1, 1, .totalGameSeries]
    /// A list of errors are expected to be thrown from the `assertGameSeriesThrows` assertion.
    static let gameSeriesThrows: [AmiiboServiceError] = [.notFound, .badRequest, .badRequest, .notFound]
}

// MARK: - Constants

private extension Int {
    /// A number that represents the total number of amiibo items currently available at the live service.
    static let totalAmiibos = 929
    /// A number that represents the total number of amiibo series currently available at the live service.
    static let totalAmiiboSeries = 29
    /// A number that represents the total number of amiibo types currently available at the live service.
    static let totalAmiiboTypes = 5
    /// A number that represents the total number of game characters currently available at the live service.
    static let totalGameCharacters = 675
    /// A number that represents the total number of game series currently available at the live service.
    static let totalGameSeries = 117
}

private extension String {
    /// An empty string.
    static let empty = ""
}
