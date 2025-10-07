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
    
    /// A game character to filter the result, if any.
    public let gameCharacter: String?

    /// A game series to filter the result, if any.
    public let gameSeries: String?
    
    /// A first part of an identifier to filter the result, if any.
    public let head: String?

    /// An amiibo identifier to filter the result, if any.
    public let identifier: String?

    /// An amiibo name to filter the result, if any.
    public let name: String?

    /// An amiibo series to filter the result, if any.
    public let series: String?

    /// A flag indicating whether to include games in the response, if any.
    public let showGames: Bool?

    /// A flag indicating whether to include amiibo usages in games in the response, if any.
    public let showUsage: Bool?
    
    /// A last part of an identifier to filter the result, if any.
    public let tail: String?

    /// An amiibo type to filter the result, if any.
    public let type: String?
    
    // MARK: Initializers
    
    /// Initializes this filter.
    /// - Parameters:
    ///   - head: A first part of an identifier to filter the result, if any.
    ///   - tail: A last part of an identifier to filter the result, if any.
    ///   - identifier: An amiibo identifier to filter the result, if any.
    ///   - name: An amiibo name to filter the result, if any.
    ///   - type: An amiibo type to filter the result, if any.
    ///   - series: An amiibo series to filter the result, if any.
    ///   - gameCharacter: A game character to filter the result, if any.
    ///   - gameSeries: A game series to filter the result, if any.
    ///   - showGames: A flag indicating whether to include games in the response, if any.
    ///   - showUsage: A flag indicating whether to include amiibo usages in games in the response, if any.
    public init(
        head: String? = nil,
        tail: String? = nil,
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
        self.head = head
        self.identifier = identifier
        self.name = name
        self.series = series
        self.showGames = showGames
        self.showUsage = showUsage
        self.tail = tail
        self.type = type
    }

}
