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

import Foundation

/// The entry point for fetching data from the Amiibo API.
///
/// This service forwards every call to the ``AmiiboClient`` passed at initialization, which defaults to ``AmiiboLiveClient``. It is `Sendable`, so you can share an instance across concurrency domains.
public struct AmiiboService: Sendable {

    // MARK: Properties

    /// A client to interact with the endpoints.
    private let client: any AmiiboClient

    // MARK: Initializers

    /// Initializes this service with a client.
    /// - Parameter client: The client that performs the calls. Defaults to ``AmiiboLiveClient``.
    public init(client: some AmiiboClient = AmiiboLiveClient()) {
        self.client = client
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
    /// - Returns: A last updated date, decoded as UTC.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    public func getLastUpdated() async throws(AmiiboServiceError) -> Date {
        try await client.getLastUpdated()
    }
    
}
