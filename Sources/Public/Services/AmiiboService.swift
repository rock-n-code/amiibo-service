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

public struct AmiiboService {
    
    // MARK: Properties
    
    private let client: any APIClient
    
    // MARK: Initialisers

    public init(_ client: any APIClient) {
        self.client = client
    }

    // MARK: Functions
    
    public func getAmiibos(
        _ filter: AmiiboFilter = .init()
    ) async throws -> [Amiibo] {
        try await client.getAmiibos(by: filter)
    }
    
    public func getAmiiboSeries(
        _ filter: AmiiboSeriesFilter = .init()
    ) async throws -> [AmiiboSeries] {
        try await client.getAmiiboSeries(by: filter)
    }
    
    public func getAmiiboTypes(
        _ filter: AmiiboTypeFilter = .init()
    ) async throws -> [AmiiboType] {
        try await client.getAmiiboTypes(by: filter)
    }
    
    public func getGameCharacters(
        _ filter: GameCharacterFilter = .init()
    ) async throws -> [GameCharacter] {
        try await client.getGameCharacters(by: filter)
    }
    
    public func getGameSeries(
        _ filter: GameSeriesFilter = .init()
    ) async throws -> [GameSeries] {
        try await client.getGameSeries(by: filter)
    }
    
    public func getLastUpdated() async throws -> Date {
        try await client.getLastUpdated()
    }
    
}
