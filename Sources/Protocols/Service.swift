import Foundation

protocol Service {
    
    // MARK:  Functions
    
    func amiibos(filter: AmiiboFilter) async throws -> [Amiibo]
    func amiiboSeries(filter: AmiiboSeriesFilter) async throws -> [AmiiboSeries]
    func amiiboTypes(filter: AmiiboTypeFilter) async throws -> [AmiiboType]
    func gameSeries(filter: GameSeriesFilter) async throws -> [GameSeries]
    func characters(filter: CharacterFilter) async throws -> [Character]
    func lastUpdated() async throws -> Date

}
