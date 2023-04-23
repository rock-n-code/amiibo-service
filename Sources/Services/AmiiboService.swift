//===----------------------------------------------------------------------===//
//
// This source file is part of the AmiiboService open source project
//
// Copyright (c) 2023 Röck+Cöde VoF. and the AmiiboService project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of AmiiboService project authors
//
//===----------------------------------------------------------------------===//

import Foundation

/// This service provides the interface to make remote API calls to the [Amiibo API](https://www.amiiboapi.com) and, subsequently, handle its responses.
///
/// Given that this remote service is a read-only API, this service will exclusively return decoded models or entities in cases the requests are successful, or it will throw errors otherwise.
public actor AmiiboService {
    
    // MARK: Properties
    
    private let client: AmiiboClient
    
    // MARK: Initialisers
    
    /// Initialises this service.
    /// - Parameter configuration: The `URLSessionConfiguration` configuration to use to set this service.
    public init(configuration: URLSessionConfiguration) {
        self.client = .init(configuration: configuration)
    }
    
}

// MARK: - Service

extension AmiiboService: Service {
    
    // MARK: Functions
    
    /// Retrieves a list of amiibos from a remote location that matches a given filter criteria.
    /// - Parameter filter: A ``AmiiboFilter`` instance that contains the filtering criteria.
    /// - Returns: A list of decoded ``Amiibo`` instances that matches the given filter criteria.
    /// - Throws: A ``AmiiboClientError`` is thrown in case a request failed, or a `DecodingError` is thrown in case the decoding of some object failed.
    public func amiibos(
        filter: AmiiboFilter = .init()
    ) async throws -> [Amiibo] {
        client.setDateDecodingStrategy(.formatted(.dateOnly))
        
        return try await client.request(
            endpoint: GetAmiiboEndpoint(parameters: filter.makeParameters()),
            as: Result<Amiibo>.self
        ).items
    }
    
    /// Retrieves a list of amiibo series from a remote location that matches a given filter criteria.
    /// - Parameter filter: A ``AmiiboSeriesFilter`` instance that contains the filtering criteria.
    /// - Returns: A list of decoded ``AmiiboSeries`` instances that matches the given filter criteria.
    /// - Throws: A ``AmiiboClientError`` is thrown in case a request failed, or a `DecodingError` is thrown in case the decoding of some object failed.
    public func amiiboSeries(
        filter: AmiiboSeriesFilter = .init()
    ) async throws -> [AmiiboSeries] {
        client.setDateDecodingStrategy(.deferredToDate)
        
        return try await client.request(
            endpoint: GetSeriesEndpoint(parameters: filter.makeParameters()),
            as: Result<AmiiboSeries>.self
        ).items
    }
    
    /// Retrieves a list of amiibo types from a remote location that matches a given filter criteria.
    /// - Parameter filter: A ``AmiiboTypeFilter`` instance that contains the filtering criteria.
    /// - Returns: A list of decoded ``AmiiboType`` instances that matches the given filter criteria.
    /// - Throws: A ``AmiiboClientError`` is thrown in case a request failed, or a `DecodingError` is thrown in case the decoding of some object failed.
    public func amiiboTypes(
        filter: AmiiboTypeFilter = .init()
    ) async throws -> [AmiiboType] {
        client.setDateDecodingStrategy(.deferredToDate)
        
        return try await client.request(
            endpoint: GetTypeEndpoint(parameters: filter.makeParameters()),
            as: Result<AmiiboType>.self
        ).items
    }
    
    /// Retrieves a list of characters from a remote location that matches a given filter criteria.
    /// - Parameter filter: A ``CharacterFilter`` instance that contains the filtering criteria.
    /// - Returns: A list of decoded ``Character`` instances that matches the given filter criteria.
    /// - Throws: A ``AmiiboClientError`` is thrown in case a request failed, or a `DecodingError` is thrown in case the decoding of some object failed.
    public func characters(
        filter: CharacterFilter = .init()
    ) async throws -> [Character] {
        client.setDateDecodingStrategy(.deferredToDate)
        
        return try await client.request(
            endpoint: GetCharacterEndpoint(parameters: filter.makeParameters()),
            as: Result<Character>.self
        ).items
    }
    
    /// Retrieves a list of game series from a remote location that matches a given filter criteria.
    /// - Parameter filter: A ``GameSeriesFilter`` instance that contains the filtering criteria.
    /// - Returns: A list of decoded ``GameSeries`` instances that matches the given filter criteria.
    /// - Throws: A ``AmiiboClientError`` is thrown in case a request failed, or a `DecodingError` is thrown in case the decoding of some object failed.
    public func gameSeries(
        filter: GameSeriesFilter = .init()
    ) async throws -> [GameSeries] {
        client.setDateDecodingStrategy(.deferredToDate)
        
        return try await client.request(
            endpoint: GetGameSeriesEndpoint(parameters: filter.makeParameters()),
            as: Result<GameSeries>.self
        ).items
    }

    /// Retrieves the date in which the remote API was last updated.
    /// - Returns: A `Date` instance that represents the date in which the remote API was last updated.
    /// - Throws: A ``AmiiboClientError`` is thrown in case a request failed, or a `DecodingError` is thrown in case the decoding of some object failed.
    public func lastUpdated() async throws -> Date {
        client.setDateDecodingStrategy(.formatted(.dateAndTime))
        
        return try await client.request(
            endpoint: GetLastUpdatedEndpoint(),
            as: LastUpdated.self
        ).timestamp
    }
    
}
