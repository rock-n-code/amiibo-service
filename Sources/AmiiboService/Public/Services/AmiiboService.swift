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

/// A type that implements the service that uses a client to make calls.
public struct AmiiboService {
    
    // MARK: Properties
    
    /// A client to interact with the endpoints.
    private let client: any APIClient
    
    // MARK: Initializers
    
    /// Initializes this service with a specific client type.
    /// - Parameter client: A representation of a client to use to interact with the endpoints.
    public init(_ client: AmiiboClient) {
        self.client = switch client {
        case let .mock(mockClient): mockClient
        case let .live(liveClient): liveClient
        }
    }

    // MARK: Functions

    /// Gets a list of amiibo items based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered amiibo items.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getAmiibos(
        _ filter: AmiiboFilter = .init()
    ) async throws(AmiiboServiceError) -> [Amiibo] {
        try await client.getAmiibos(by: filter)
    }

    /// Gets a list of amiibo series based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered amiibo series.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getAmiiboSeries(
        _ filter: AmiiboSeriesFilter = .init()
    ) async throws(AmiiboServiceError) -> [AmiiboSeries] {
        try await client.getAmiiboSeries(by: filter)
    }

    /// Gets a list of amiibo types based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered amiibo types.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getAmiiboTypes(
        _ filter: AmiiboTypeFilter = .init()
    ) async throws(AmiiboServiceError) -> [AmiiboType] {
        try await client.getAmiiboTypes(by: filter)
    }

    /// Gets a list of game characters based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered game characters.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getGameCharacters(
        _ filter: GameCharacterFilter = .init()
    ) async throws(AmiiboServiceError) -> [GameCharacter] {
        try await client.getGameCharacters(by: filter)
    }

    /// Gets a list of game series based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered game series.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getGameSeries(
        _ filter: GameSeriesFilter = .init()
    ) async throws(AmiiboServiceError) -> [GameSeries] {
        try await client.getGameSeries(by: filter)
    }

    /// Gets the date when the data was last updated.
    /// - Returns: A last updated date.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getLastUpdated() async throws(AmiiboServiceError) -> Date {
        try await client.getLastUpdated()
    }
    
}
