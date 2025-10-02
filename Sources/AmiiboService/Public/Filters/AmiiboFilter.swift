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

/// A type that contains values to fine-tune a response when requesting amiibo items.
public struct AmiiboFilter: Sendable {
    
    // MARK: Properties
    
    /// A game character to return, if any.
    public let gameCharacter: String?

    /// A game series to return, if any.
    public let gameSeries: String?

    /// An amiibo identifier to return, if any.
    public let identifier: String?

    /// An amiibo name to return, if any.
    public let name: String?

    /// An amiibo series to return, if any.
    public let series: String?

    /// A flag indicating whether to include games in the response, if any.
    public let showGames: Bool?

    /// A flag indicating whether to include amiibo usages in games in the response, if any.
    public let showUsage: Bool?

    /// An amiibo type to return, if any.
    public let type: String?
    
    // MARK: Initializers
    
    /// Initializes this filter.
    /// - Parameters:
    ///   - identifier: An amiibo identifier to return, if any.
    ///   - name: An amiibo name to return, if any.
    ///   - type: An amiibo type to return, if any.
    ///   - series: An amiibo series to return, if any.
    ///   - gameCharacter: A game character to return, if any.
    ///   - gameSeries: A game series to return, if any.
    ///   - showGames: A flag indicating whether to include games in the response, if any.
    ///   - showUsage: A flag indicating whether to include amiibo usages in games in the response, if any.
    public init(
        identifier: String? = nil,
        name: String? = nil,
        type: String? = nil,
        series: String? = nil,
        gameCharacter: String? = nil,
        gameSeries: String? = nil,
        showGames: Bool? = nil,
        showUsage: Bool? = nil
    ) {
        self.gameCharacter = gameCharacter
        self.gameSeries = gameSeries
        self.identifier = identifier
        self.name = name
        self.series = series
        self.showGames = showGames
        self.showUsage = showUsage
        self.type = type
    }

}
