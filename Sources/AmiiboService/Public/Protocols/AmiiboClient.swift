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

/// A protocol that defines API clients containing all available endpoints to interact with.
///
/// Conforming types must be `Sendable`, as clients are expected to be used safely across concurrency domains.
public protocol AmiiboClient: Sendable {
    
    // MARK: Functions
    
    /// Gets a list of amiibo items based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered amiibo items.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    func getAmiibos(by filter: AmiiboFilter) async throws(AmiiboServiceError) -> [Amiibo]
    
    /// Gets a list of amiibo series based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered amiibo series.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    func getAmiiboSeries(by filter: AmiiboSeriesFilter) async throws(AmiiboServiceError) -> [AmiiboSeries]
    
    /// Gets a list of amiibo types based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered amiibo types.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    func getAmiiboTypes(by filter: AmiiboTypeFilter) async throws(AmiiboServiceError) -> [AmiiboType]
    
    /// Gets a list of game characters based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered game characters.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    func getGameCharacters(by filter: GameCharacterFilter) async throws(AmiiboServiceError) -> [GameCharacter]
    
    /// Gets a list of game series based on a given filter.
    /// - Parameter filter: A filter to remove unwanted items from the result.
    /// - Returns: A list of filtered game series.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    func getGameSeries(by filter: GameSeriesFilter) async throws(AmiiboServiceError) -> [GameSeries]
    
    /// Gets the date when the data was last updated.
    /// - Returns: A last updated date, decoded as UTC.
    /// - Throws: An ``AmiiboServiceError`` error in case some issue is encountered while generating the result.
    func getLastUpdated() async throws(AmiiboServiceError) -> Date

}
