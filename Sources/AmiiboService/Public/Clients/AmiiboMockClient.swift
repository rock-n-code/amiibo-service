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

/// A type that implements a mock client, for testing purposes.
public struct AmiiboMockClient {
    
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
// TODO: Remove the documentation from the functions inside the following extension as the `--enable-inherited-docs` flag when generating DocC documentation is not working as intended (?).

extension AmiiboMockClient: APIClient {
    
    // MARK: Functions

#if swift(>=6.0)
    /// Gets a list of amiibo items based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered amiibo items.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getAmiibos(by filter: AmiiboFilter) async throws(AmiiboServiceError) -> [Amiibo] {
        try throwErrorIfExists()

        guard let amiibos else {
            throw AmiiboServiceError.notFound
        }
        
        return amiibos
    }

    /// Gets a list of amiibo series based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered amiibo series.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getAmiiboSeries(by filter: AmiiboSeriesFilter) async throws(AmiiboServiceError) -> [AmiiboSeries] {
        try throwErrorIfExists()

        guard let amiiboSeries else {
            throw AmiiboServiceError.notFound
        }
        
        return amiiboSeries
    }

    /// Gets a list of amiibo types based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered amiibo types.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getAmiiboTypes(by filter: AmiiboTypeFilter) async throws(AmiiboServiceError) -> [AmiiboType] {
        try throwErrorIfExists()

        guard let amiiboTypes else {
            throw AmiiboServiceError.notFound
        }
        
        return amiiboTypes
    }

    /// Gets a list of game characters based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered game characters.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getGameCharacters(by filter: GameCharacterFilter) async throws(AmiiboServiceError) -> [GameCharacter] {
        try throwErrorIfExists()

        guard let gameCharacters else {
            throw AmiiboServiceError.notFound
        }
        
        return gameCharacters
    }

    /// Gets a list of game series based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered game series.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getGameSeries(by filter: GameSeriesFilter) async throws(AmiiboServiceError) -> [GameSeries] {
        try throwErrorIfExists()

        guard let gameSeries else {
            throw AmiiboServiceError.notFound
        }
        
        return gameSeries
    }

    /// Gets the date when the data was last updated.
    /// - Returns: A last updated date.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getLastUpdated() async throws(AmiiboServiceError) -> Date {
        try throwErrorIfExists()

        guard let lastUpdated else {
            throw AmiiboServiceError.notFound
        }
        
        return lastUpdated
    }
#else
    /// Gets a list of amiibo items based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered amiibo items.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getAmiibos(by filter: AmiiboFilter) async throws -> [Amiibo] {
        try throwErrorIfExists()
        
        guard let amiibos else {
            throw AmiiboServiceError.notFound
        }
        
        return amiibos
    }
    
    /// Gets a list of amiibo series based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered amiibo series.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getAmiiboSeries(by filter: AmiiboSeriesFilter) async throws -> [AmiiboSeries] {
        try throwErrorIfExists()
        
        guard let amiiboSeries else {
            throw AmiiboServiceError.notFound
        }
        
        return amiiboSeries
    }
    
    /// Gets a list of amiibo types based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered amiibo types.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getAmiiboTypes(by filter: AmiiboTypeFilter) async throws -> [AmiiboType] {
        try throwErrorIfExists()
        
        guard let amiiboTypes else {
            throw AmiiboServiceError.notFound
        }
        
        return amiiboTypes
    }
    
    /// Gets a list of game characters based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered game characters.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getGameCharacters(by filter: GameCharacterFilter) async throws -> [GameCharacter] {
        try throwErrorIfExists()
        
        guard let gameCharacters else {
            throw AmiiboServiceError.notFound
        }
        
        return gameCharacters
    }
    
    /// Gets a list of game series based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered game series.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getGameSeries(by filter: GameSeriesFilter) async throws -> [GameSeries] {
        try throwErrorIfExists()
        
        guard let gameSeries else {
            throw AmiiboServiceError.notFound
        }
        
        return gameSeries
    }
    
    /// Gets the date when the data was last updated.
    /// - Returns: A last updated date.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getLastUpdated() async throws -> Date {
        try throwErrorIfExists()
        
        guard let lastUpdated else {
            throw AmiiboServiceError.notFound
        }
        
        return lastUpdated
    }
#endif
    
}

// MARK: - Helpers

private extension AmiiboMockClient {
    
    // MARK: Functions
    
    /// Throws an error if it has been provided,
    /// - Throws: An ``AmiiboServiceError`` error in case an error has been provided.
    func throwErrorIfExists() throws(AmiiboServiceError) {
        if let error {
            throw error
        }
    }
    
}
