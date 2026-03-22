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
    
    @Test("returns empty amiibos when mock provides an empty list")
    func getAmiibosEmpty() async throws {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(amiibos: []))
        
        // WHEN
        let amiibos = try await service.getAmiibos()
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test("throws notFound when mock provides no amiibos")
    func getAmiibosNotFound() async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient())
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getAmiibos()
        }
    }
    
    @Test("throws error for amiibos when mock is configured with error", arguments: Errors.all)
    func getAmiibosThrows(error: AmiiboServiceError) async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(error: error))
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.getAmiibos()
        }
    }
    
    // MARK: Get Amiibo Series tests
    
    @Test("returns empty amiibo series when mock provides an empty list")
    func getAmiiboSeriesEmpty() async throws {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(amiiboSeries: []))
        
        // WHEN
        let amiiboSeries = try await service.getAmiiboSeries()
        
        // THEN
        #expect(amiiboSeries.isEmpty)
    }
    
    @Test("throws notFound when mock provides no amiibo series")
    func getAmiiboSeriesNotFound() async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient())
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getAmiiboSeries()
        }
    }
    
    @Test("throws error for amiibo series when mock is configured with error", arguments: Errors.all)
    func getAmiiboSeriesThrows(error: AmiiboServiceError) async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(error: error))
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.getAmiiboSeries()
        }
    }
    
    // MARK: Get Amiibo Types tests
    
    @Test("returns empty amiibo types when mock provides an empty list")
    func getAmiiboTypesEmpty() async throws {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(amiiboTypes: []))
        
        // WHEN
        let amiiboTypes = try await service.getAmiiboTypes()
        
        // THEN
        #expect(amiiboTypes.isEmpty)
    }
    
    @Test("throws notFound when mock provides no amiibo types")
    func getAmiiboTypesNotFound() async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient())
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getAmiiboTypes()
        }
    }
    
    @Test("throws error for amiibo types when mock is configured with error", arguments: Errors.all)
    func getAmiiboTypesThrows(error: AmiiboServiceError) async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(error: error))
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.getAmiiboTypes()
        }
    }
    
    // MARK: Get Game Characters tests
    
    @Test("returns empty game characters when mock provides an empty list")
    func getGameCharactersEmpty() async throws {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(gameCharacters: []))
        
        // WHEN
        let gameCharacters = try await service.getGameCharacters()
        
        // THEN
        #expect(gameCharacters.isEmpty)
    }
    
    @Test("throws notFound when mock provides no game characters")
    func getGameCharactersNotFound() async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient())
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getGameCharacters()
        }
    }
    
    @Test("throws error for game characters when mock is configured with error", arguments: Errors.all)
    func getGameCharactersThrows(error: AmiiboServiceError) async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(error: error))
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.getGameCharacters()
        }
    }
    
    // MARK: Get Game Series tests
    
    @Test("returns empty game series when mock provides an empty list")
    func getGameSeriesEmpty() async throws {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(gameSeries: []))
        
        // WHEN
        let gameSeries = try await service.getGameSeries()
        
        // THEN
        #expect(gameSeries.isEmpty)
    }
    
    @Test("throws notFound when mock provides no game series")
    func getGameSeriesNotFound() async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient())
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getGameSeries()
        }
    }
    
    @Test("throws error for game series when mock is configured with error", arguments: Errors.all)
    func getGameSeriesThrows(error: AmiiboServiceError) async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient(error: error))
        
        // WHEN
        // THEN
        await #expect(throws: error) {
            try await service.getGameSeries()
        }
    }
    
    // MARK: Get Last Updated tests
    
    @Test("returns date when mock provides a last updated date")
    func getLastUpdated() async throws {
        // GIVEN
        let expectedDate = Date(timeIntervalSince1970: 1_700_000_000)
        let service = AmiiboService(client: AmiiboMockClient(lastUpdated: expectedDate))
        
        // WHEN
        let lastUpdated = try await service.getLastUpdated()
        
        // THEN
        #expect(lastUpdated == expectedDate)
    }
    
    @Test("throws notFound when mock provides no last updated date")
    func getLastUpdatedNotFound() async {
        // GIVEN
        let service = AmiiboService(client: AmiiboMockClient())
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getLastUpdated()
        }
    }
    
    @Test("throws error for last updated when mock is configured with error", arguments: Errors.all)
    func getLastUpdatedThrows(error: AmiiboServiceError) async {
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
        .unknown
    ]
}
