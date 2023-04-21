import Foundation

public struct AmiiboService {
    
    // MARK: Properties
    
    private let client: AmiiboClient
    
    // MARK: Initialisers
    
    init(configuration: URLSessionConfiguration) {
        self.client = .init(configuration: configuration)
    }
    
}

// MARK: - Service

extension AmiiboService: Service {
    
    // MARK: Functions
    
    public func amiibos(
        filter: AmiiboFilter = .init()
    ) async throws -> [Amiibo] {
        client.setDateDecodingStrategy(.formatted(.dateOnly))
        
        return try await client.request(
            endpoint: GetAmiiboEndpoint(parameters: filter.makeParameters()),
            as: Result<Amiibo>.self
        ).items
    }
    
    public func amiiboSeries(
        filter: AmiiboSeriesFilter = .init()
    ) async throws -> [AmiiboSeries] {
        client.setDateDecodingStrategy(.deferredToDate)
        
        return try await client.request(
            endpoint: GetSeriesEndpoint(parameters: filter.makeParameters()),
            as: Result<AmiiboSeries>.self
        ).items
    }
    
    public func amiiboTypes(
        filter: AmiiboTypeFilter = .init()
    ) async throws -> [AmiiboType] {
        client.setDateDecodingStrategy(.deferredToDate)
        
        return try await client.request(
            endpoint: GetTypeEndpoint(parameters: filter.makeParameters()),
            as: Result<AmiiboType>.self
        ).items
    }
    
    public func characters(
        filter: CharacterFilter = .init()
    ) async throws -> [Character] {
        client.setDateDecodingStrategy(.deferredToDate)
        
        return try await client.request(
            endpoint: GetCharacterEndpoint(parameters: filter.makeParameters()),
            as: Result<Character>.self
        ).items
    }
    
    public func gameSeries(
        filter: GameSeriesFilter = .init()
    ) async throws -> [GameSeries] {
        client.setDateDecodingStrategy(.deferredToDate)
        
        return try await client.request(
            endpoint: GetGameSeriesEndpoint(parameters: filter.makeParameters()),
            as: Result<GameSeries>.self
        ).items
    }

    public func lastUpdated() async throws -> Date {
        client.setDateDecodingStrategy(.formatted(.dateAndTime))
        
        return try await client.request(
            endpoint: GetLastUpdatedEndpoint(),
            as: LastUpdated.self
        ).timestamp
    }
    
}
