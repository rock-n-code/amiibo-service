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

import AmiiboService
import Foundation

/// A type that implements a mock client, for testing purposes.
struct AmiiboMockClient {
    
    // MARK: Properties
    
    /// A list of amiibo items to return, if any.
    private let amiibos: [Amiibo]?
    
    /// A list of amiibo series to return, if any.
    private let amiiboSeries: [AmiiboSeries]?
    
    /// A list of amiibo types to return, if any.
    private let amiiboTypes: [AmiiboType]?
    
    /// An error to throw, if any.
    private let error: AmiiboServiceError?
    
    /// A list of game characters to return, if any.
    private let gameCharacters: [GameCharacter]?
    
    /// A list of game series to return, if any.
    private let gameSeries: [GameSeries]?
    
    /// A last updated date to return, if any.
    private let lastUpdated: Date?
    
    // MARK: Initializers
    
    /// Initializes this client.
    /// - Parameters:
    ///   - amiibos: A list of amiibo items to return, if any.
    ///   - amiiboSeries: A list of amiibo series to return, if any.
    ///   - amiiboTypes: A list of amiibo types to return, if any.
    ///   - gameCharacters: A list of game characters to return, if any.
    ///   - gameSeries: A list of game series to return, if any.
    ///   - lastUpdated: A last updated date to return, if any.
    ///   - error: An error to throw, if any. 
    init(
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

// MARK: - AmiiboClient

extension AmiiboMockClient: AmiiboClient {
    
    // MARK: Functions

#if swift(>=6.0)
    func getAmiibos(
        by filter: AmiiboFilter
    ) async throws(AmiiboServiceError) -> [Amiibo] {
        try fetchAmiibosIfAny()
    }

    func getAmiiboSeries(
        by filter: AmiiboSeriesFilter
    ) async throws(AmiiboServiceError) -> [AmiiboSeries] {
        try fetchAmiiboSeriesIfAny()
    }

    func getAmiiboTypes(
        by filter: AmiiboTypeFilter
    ) async throws(AmiiboServiceError) -> [AmiiboType] {
        try fetchAmiiboTypesIfAny()
    }

    func getGameCharacters(
        by filter: GameCharacterFilter
    ) async throws(AmiiboServiceError) -> [GameCharacter] {
        try fetchGameCharactersIfAny()
    }

    func getGameSeries(
        by filter: GameSeriesFilter
    ) async throws(AmiiboServiceError) -> [GameSeries] {
        try fetchGameSeriesIfAny()
    }

    func getLastUpdated() async throws(AmiiboServiceError) -> Date {
        fetchLastUpdatedIfAny()
    }
#else
    func getAmiibos(
        by filter: AmiiboFilter
    ) async throws -> [Amiibo] {
        try fetchAmiibosIfAny()
    }
    
    func getAmiiboSeries(
        by filter: AmiiboSeriesFilter
    ) async throws -> [AmiiboSeries] {
        try fetchAmiiboSeriesIfAny()
    }
    
    func getAmiiboTypes(
        by filter: AmiiboTypeFilter
    ) async throws -> [AmiiboType] {
        try fetchAmiiboTypesIfAny()
    }
    
    func getGameCharacters(
        by filter: GameCharacterFilter
    ) async throws -> [GameCharacter] {
        try fetchGameCharactersIfAny()
    }
    
    func getGameSeries(
        by filter: GameSeriesFilter
    ) async throws -> [GameSeries] {
        try fetchGameSeriesIfAny()
    }

    func getLastUpdated() async throws -> Date {
        try fetchLastUpdatedIfAny()
    }
#endif
    
}

// MARK: - Helpers

private extension AmiiboMockClient {
    
    // MARK: Functions
    
    /// Fetches a list of amiibo items, if any.
    /// - Returns: A list of amiibo items.
    /// - Throws: An ``AmiiboServiceError`` error in case an error has been provided.
    func fetchAmiibosIfAny() throws -> [Amiibo] {
        try throwErrorIfExists()
        
        guard let amiibos else {
            throw AmiiboServiceError.notFound
        }
        
        return amiibos
    }
    
    /// Fetches a list of amiibo series, if any.
    /// - Returns: A list of amiibo series.
    /// - Throws: An ``AmiiboServiceError`` error in case an error has been provided.
    func fetchAmiiboSeriesIfAny() throws -> [AmiiboSeries] {
        try throwErrorIfExists()
        
        guard let amiiboSeries else {
            throw AmiiboServiceError.notFound
        }
        
        return amiiboSeries
    }
    
    /// Fetches a list of amiibo types, if any.
    /// - Returns: A list of amiibo types.
    /// - Throws: An ``AmiiboServiceError`` error in case an error has been provided.
    func fetchAmiiboTypesIfAny() throws -> [AmiiboType] {
        try throwErrorIfExists()
        
        guard let amiiboTypes else {
            throw AmiiboServiceError.notFound
        }
        
        return amiiboTypes
    }
    
    /// Fetches a list of game characters, if any.
    /// - Returns: A list of game characters.
    /// - Throws: An ``AmiiboServiceError`` error in case an error has been provided.
    func fetchGameCharactersIfAny() throws -> [GameCharacter] {
        try throwErrorIfExists()
        
        guard let gameCharacters else {
            throw AmiiboServiceError.notFound
        }
        
        return gameCharacters
    }
    
    /// Fetches a list of game series, if any.
    /// - Returns: A list of game series, if any.
    /// - Throws: An ``AmiiboServiceError`` error in case an error has been provided.
    func fetchGameSeriesIfAny() throws -> [GameSeries] {
        try throwErrorIfExists()
        
        guard let gameSeries else {
            throw AmiiboServiceError.notFound
        }
        
        return gameSeries
    }
    
    /// Fetches a last updated date, if any.
    /// - Returns: A last updated date.
    /// - Throws: An ``AmiiboServiceError`` error in case an error has been provided.
    func fetchLastUpdatedIfAny() throws -> Date {
        try throwErrorIfExists()
        
        guard let lastUpdated else {
            throw AmiiboServiceError.notFound
        }
        
        return lastUpdated
    }
    
    /// Throws an error if it has been provided,
    /// - Throws: An ``AmiiboServiceError`` error in case an error has been provided.
    func throwErrorIfExists() throws(AmiiboServiceError) {
        if let error {
            throw error
        }
    }
    
}
