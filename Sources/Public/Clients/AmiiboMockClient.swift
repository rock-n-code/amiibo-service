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

public struct AmiiboMockClient {
    
    // MARK: Properties
    
    private let amiibos: [Amiibo]?
    private let amiiboSeries: [AmiiboSeries]?
    private let amiiboTypes: [AmiiboType]?
    private let error: AmiiboServiceError?
    private let gameCharacters: [GameCharacter]?
    private let gameSeries: [GameSeries]?
    private let lastUpdated: Date?
    
    // MARK: Initialisers
    
    public init(
        amiibos: [Amiibo]? = nil,
        amiiboSeries: [AmiiboSeries]? = nil,
        amiiboTypes: [AmiiboType]? = nil,
        gameCharacters: [GameCharacter]? = nil,
        gameSeries: [GameSeries]? = nil,
        lastUpdated: Date? = nil,
        error: AmiiboServiceError? = nil
    ) {
        self.amiibos = amiibos
        self.amiiboSeries = amiiboSeries
        self.amiiboTypes = amiiboTypes
        self.error = error
        self.gameCharacters = gameCharacters
        self.gameSeries = gameSeries
        self.lastUpdated = lastUpdated
    }
    
}

// MARK: - APIClient

extension AmiiboMockClient: APIClient {
    
    // MARK: Functions

    public func getAmiibos(by filter: AmiiboFilter) async throws -> [Amiibo] {
        try throwErrorIfExists()

        guard let amiibos else {
            throw AmiiboServiceError.notFound
        }
        
        return amiibos
    }
    
    public func getAmiiboSeries(by filter: AmiiboSeriesFilter) async throws -> [AmiiboSeries] {
        try throwErrorIfExists()

        guard let amiiboSeries else {
            throw AmiiboServiceError.notFound
        }
        
        return amiiboSeries
    }
    
    public func getAmiiboTypes(by filter: AmiiboTypeFilter) async throws -> [AmiiboType] {
        try throwErrorIfExists()

        guard let amiiboTypes else {
            throw AmiiboServiceError.notFound
        }
        
        return amiiboTypes
    }
    
    public func getGameCharacters(by filter: GameCharacterFilter) async throws -> [GameCharacter] {
        try throwErrorIfExists()

        guard let gameCharacters else {
            throw AmiiboServiceError.notFound
        }
        
        return gameCharacters
    }
    
    public func getGameSeries(by filter: GameSeriesFilter) async throws -> [GameSeries] {
        try throwErrorIfExists()

        guard let gameSeries else {
            throw AmiiboServiceError.notFound
        }
        
        return gameSeries
    }
    
    public func getLastUpdated() async throws -> Date {
        try throwErrorIfExists()

        guard let lastUpdated else {
            throw AmiiboServiceError.notFound
        }
        
        return lastUpdated
    }
    
    
}

// MARK: - Helpers

private extension AmiiboMockClient {
    
    // MARK: Functions
    
    func throwErrorIfExists() throws {
        if let error {
            throw error
        }
    }
    
}
