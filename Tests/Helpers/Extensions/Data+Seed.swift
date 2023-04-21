import Foundation

extension Data {
    enum Client {
        enum Seed {
            static let dataUnrelated = "{\"something\":\"Something goes in here...\"}".data(using: .utf8)
            static let dataWithoutTimestamp = "{\"timestamp\":null}".data(using: .utf8)
            static let dataWithDateOnly = "{\"timestamp\":\"2023-03-23\"}".data(using: .utf8)
            static let dataWithDateAndTime = "{\"timestamp\":\"2023-03-23T13:11:20.382254\"}".data(using: .utf8)
        }
    }
    
    enum Service {
        static let amiibos = String.Amiibo.withoutGameOrUsage.data(using: .utf8)
        static let amiibosWithGames = String.Amiibo.withGames.data(using: .utf8)
        static let amiibosWithUsage = String.Amiibo.withUsage.data(using: .utf8)
        static let amiiboWithBadFormattedDates = String.Amiibo.withBadFormattedReleaseDates.data(using: .utf8)
        static let amiiboWithMissingFields = String.Amiibo.withMissingFields.data(using: .utf8)
        static let amiiboSeries = String.AmiiboSeries.all.data(using: .utf8)
        static let amiiboSeriesWithMissingFields = String.AmiiboSeries.withMissingFields.data(using: .utf8)
        static let amiiboTypes = String.AmiiboType.all.data(using: .utf8)
        static let amiiboTypesWithMissingFields = String.AmiiboType.withMissingFields.data(using: .utf8)
        static let characters = String.Character.all.data(using: .utf8)
        static let charactersWithMissingFields = String.Character.withMissingFields.data(using: .utf8)
        static let gameSeries = String.GameSeries.all.data(using: .utf8)
        static let gameSeriesWithMissingFields = String.GameSeries.withMissingFields.data(using: .utf8)
        static let lastUpdated = String.LastUpdated.all.data(using: .utf8)
        static let lastUpdatedWithBadFormattedDate = String.LastUpdated.withBadFormattedDate.data(using: .utf8)
        static let lastUpdatedWithBadInfo = String.LastUpdated.withBadInfo.data(using: .utf8)
    }
}
