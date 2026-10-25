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

/// A filter for amiibo requests.
///
/// Values left as `nil` do not restrict the result.
public struct AmiiboFilter: Sendable, Hashable {

    // MARK: Properties

    /// A game character key or name to match, if any.
    public let gameCharacter: String?

    /// A game series key or name to match, if any.
    public let gameSeries: String?

    /// The first 8 hexadecimal characters of an identifier to match, if any. Shorter values match as a prefix.
    public let head: String?

    /// A full 16-character hexadecimal identifier to match, if any.
    public let identifier: String?

    /// An amiibo name, or part of one, to match, if any.
    public let name: String?

    /// An amiibo series key or name to match, if any.
    public let series: String?

    /// Whether to include related games in ``Amiibo/platform``. `nil` means `false`.
    public let showGames: Bool?

    /// Whether to include related games and their usages in ``Amiibo/platform``. `nil` means `false`.
    public let showUsage: Bool?

    /// The last 8 hexadecimal characters of an identifier to match, if any. Shorter values match as a prefix.
    public let tail: String?

    /// An amiibo type key or name to match, if any.
    public let type: String?

    // MARK: Initializers

    /// Initializes this filter.
    /// - Parameters:
    ///   - head: The first 8 hexadecimal characters of an identifier to match, if any. Shorter values match as a prefix.
    ///   - tail: The last 8 hexadecimal characters of an identifier to match, if any. Shorter values match as a prefix.
    ///   - identifier: A full 16-character hexadecimal identifier to match, if any.
    ///   - name: An amiibo name, or part of one, to match, if any.
    ///   - type: An amiibo type key or name to match, if any.
    ///   - series: An amiibo series key or name to match, if any.
    ///   - gameCharacter: A game character key or name to match, if any.
    ///   - gameSeries: A game series key or name to match, if any.
    ///   - showGames: Whether to include related games in ``Amiibo/platform``. `nil` means `false`.
    ///   - showUsage: Whether to include related games and their usages in ``Amiibo/platform``. `nil` means `false`.
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
