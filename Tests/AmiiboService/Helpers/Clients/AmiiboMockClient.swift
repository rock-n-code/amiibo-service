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

/// A mock implementation of ``AmiiboClient`` that returns pre-configured data or throws pre-configured errors, for testing purposes.
struct AmiiboMockClient {
    
    // MARK: Properties
    
    /// The list of amiibo items to return when ``getAmiibos(by:)`` is called, or `nil` to trigger a ``AmiiboServiceError/notFound`` error.
    private let amiibos: [Amiibo]?
    
    /// The list of amiibo series to return when ``getAmiiboSeries(by:)`` is called, or `nil` to trigger a ``AmiiboServiceError/notFound`` error.
    private let amiiboSeries: [AmiiboSeries]?
    
    /// The list of amiibo types to return when ``getAmiiboTypes(by:)`` is called, or `nil` to trigger a ``AmiiboServiceError/notFound`` error.
    private let amiiboTypes: [AmiiboType]?
    
    /// An error to throw before returning any data. Takes precedence over stored data when set.
    private let error: AmiiboServiceError?
    
    /// The list of game characters to return when ``getGameCharacters(by:)`` is called, or `nil` to trigger a ``AmiiboServiceError/notFound`` error.
    private let gameCharacters: [GameCharacter]?
    
    /// The list of game series to return when ``getGameSeries(by:)`` is called, or `nil` to trigger a ``AmiiboServiceError/notFound`` error.
    private let gameSeries: [GameSeries]?
    
    /// The last updated date to return when ``getLastUpdated()`` is called, or `nil` to trigger a ``AmiiboServiceError/notFound`` error.
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
    
    /// Throws the configured error if one has been provided.
    /// - Throws: An ``AmiiboServiceError`` error if one was configured during initialization.
    func throwErrorIfExists() throws(AmiiboServiceError) {
        if let error {
            throw error
        }
    }
    
}
