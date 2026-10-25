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

@Suite("Amiibo Service [Mock]", .tags(.mock))
struct AmiiboServiceMockTests {

    // MARK: Get Amiibos tests
    
    @Test
    func `returns empty amiibos when mock provides an empty list`() async throws {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(amiibos: []))
        
        // WHEN
        let amiibos = try await service.getAmiibos()
        
        // THEN
        #expect(amiibos.isEmpty)
    }

    @Test
    func `returns amiibos when mock provides a list`() async throws {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(amiibos: Fixtures.amiibos))

        // WHEN
        let amiibos = try await service.getAmiibos()

        // THEN
        #expect(amiibos == Fixtures.amiibos)
        #expect(amiibos.first?.identifier == "0100000000040002")
        #expect(amiibos.first?.imageURL != nil)
    }

    @Test
    func `throws notFound when mock provides no amiibos`() async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient())
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getAmiibos()
        }
    }
    
    @Test(arguments: Errors.all)
    func `throws error for amiibos when mock is configured with error`(error: AmiiboServiceError) async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(error: error))
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.getAmiibos()
        }
    }
    
    // MARK: Get Amiibo Series tests
    
    @Test
    func `returns empty amiibo series when mock provides an empty list`() async throws {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(amiiboSeries: []))
        
        // WHEN
        let amiiboSeries = try await service.getAmiiboSeries()
        
        // THEN
        #expect(amiiboSeries.isEmpty)
    }

    @Test
    func `returns amiibo series when mock provides a list`() async throws {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(amiiboSeries: Fixtures.amiiboSeries))

        // WHEN
        let amiiboSeries = try await service.getAmiiboSeries()

        // THEN
        #expect(amiiboSeries == Fixtures.amiiboSeries)
    }

    @Test
    func `throws notFound when mock provides no amiibo series`() async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient())
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getAmiiboSeries()
        }
    }
    
    @Test(arguments: Errors.all)
    func `throws error for amiibo series when mock is configured with error`(error: AmiiboServiceError) async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(error: error))
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.getAmiiboSeries()
        }
    }
    
    // MARK: Get Amiibo Types tests
    
    @Test
    func `returns empty amiibo types when mock provides an empty list`() async throws {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(amiiboTypes: []))
        
        // WHEN
        let amiiboTypes = try await service.getAmiiboTypes()
        
        // THEN
        #expect(amiiboTypes.isEmpty)
    }

    @Test
    func `returns amiibo types when mock provides a list`() async throws {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(amiiboTypes: Fixtures.amiiboTypes))

        // WHEN
        let amiiboTypes = try await service.getAmiiboTypes()

        // THEN
        #expect(amiiboTypes == Fixtures.amiiboTypes)
    }

    @Test
    func `throws notFound when mock provides no amiibo types`() async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient())
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getAmiiboTypes()
        }
    }
    
    @Test(arguments: Errors.all)
    func `throws error for amiibo types when mock is configured with error`(error: AmiiboServiceError) async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(error: error))
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.getAmiiboTypes()
        }
    }
    
    // MARK: Get Game Characters tests
    
    @Test
    func `returns empty game characters when mock provides an empty list`() async throws {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(gameCharacters: []))
        
        // WHEN
        let gameCharacters = try await service.getGameCharacters()
        
        // THEN
        #expect(gameCharacters.isEmpty)
    }

    @Test
    func `returns game characters when mock provides a list`() async throws {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(gameCharacters: Fixtures.gameCharacters))

        // WHEN
        let gameCharacters = try await service.getGameCharacters()

        // THEN
        #expect(gameCharacters == Fixtures.gameCharacters)
    }

    @Test
    func `throws notFound when mock provides no game characters`() async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient())
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getGameCharacters()
        }
    }
    
    @Test(arguments: Errors.all)
    func `throws error for game characters when mock is configured with error`(error: AmiiboServiceError) async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(error: error))
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.getGameCharacters()
        }
    }
    
    // MARK: Get Game Series tests
    
    @Test
    func `returns empty game series when mock provides an empty list`() async throws {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(gameSeries: []))
        
        // WHEN
        let gameSeries = try await service.getGameSeries()
        
        // THEN
        #expect(gameSeries.isEmpty)
    }

    @Test
    func `returns game series when mock provides a list`() async throws {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(gameSeries: Fixtures.gameSeries))

        // WHEN
        let gameSeries = try await service.getGameSeries()

        // THEN
        #expect(gameSeries == Fixtures.gameSeries)
    }

    @Test
    func `throws notFound when mock provides no game series`() async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient())
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getGameSeries()
        }
    }
    
    @Test(arguments: Errors.all)
    func `throws error for game series when mock is configured with error`(error: AmiiboServiceError) async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(error: error))
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.getGameSeries()
        }
    }
    
    // MARK: Get Last Updated tests
    
    @Test
    func `returns date when mock provides a last updated date`() async throws {
        // GIVEN
        let expectedDate = Date(timeIntervalSince1970: 1_700_000_000)
        let service = AmiiboService(client: AmiiboMockClient(lastUpdated: expectedDate))
        
        // WHEN
        let lastUpdated = try await service.getLastUpdated()
        
        // THEN
        #expect(lastUpdated == expectedDate)
    }
    
    @Test
    func `throws notFound when mock provides no last updated date`() async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient())
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getLastUpdated()
        }
    }
    
    @Test(arguments: Errors.all)
    func `throws error for last updated when mock is configured with error`(error: AmiiboServiceError) async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(error: error))
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.getLastUpdated()
        }
    }
    
}

// MARK: - Arguments

private enum Errors {
    /// All possible errors that can be thrown by the service.
    static let all: [AmiiboServiceError] = [
        .badRequest,
        .cancelled,
        .decoding,
        .notAvailable,
        .notFound,
        .undocumented(500),
        .unknown("An underlying error description.")
    ]
}
