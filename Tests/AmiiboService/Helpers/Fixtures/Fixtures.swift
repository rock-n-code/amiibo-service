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

import AmiiboService
import Foundation

/// Ready-made models for testing purposes.
enum Fixtures {
    /// Amiibo items; the first one has release dates and related games with usages.
    static let amiibos: [Amiibo] = [
        .init(
            head: "01000000",
            tail: "00040002",
            name: "Zelda",
            type: "Figure",
            series: "Super Smash Bros.",
            gameCharacter: "Zelda",
            gameSeries: "The Legend of Zelda",
            image: "https://raw.githubusercontent.com/N3evin/AmiiboAPI/master/images/icon_01000000-00040002.png",
            release: .init(
                america: Date(timeIntervalSince1970: 1_416_441_600),
                australia: Date(timeIntervalSince1970: 1_417_564_800),
                europe: Date(timeIntervalSince1970: 1_417_132_800),
                japan: Date(timeIntervalSince1970: 1_417_564_800)
            ),
            platform: .init(
                switch: [
                    .init(
                        identifiers: ["01007EF00011E000"],
                        name: "The Legend of Zelda: Breath of the Wild",
                        usages: [.init(explanation: "Spawns a random selection of items.", isWriteable: false)]
                    )
                ],
                wiiU: [
                    .init(
                        identifiers: ["0005000010145000"],
                        name: "Super Smash Bros. for Wii U",
                        usages: [.init(explanation: "Unlocks a figure player.", isWriteable: true)]
                    )
                ]
            )
        ),
        .init(
            head: "00000000",
            tail: "00000002",
            name: "Mario",
            type: "Figure",
            series: "Super Smash Bros.",
            gameCharacter: "Mario",
            gameSeries: "Super Mario",
            image: "https://raw.githubusercontent.com/N3evin/AmiiboAPI/master/images/icon_00000000-00000002.png"
        )
    ]
    /// Amiibo series.
    static let amiiboSeries: [AmiiboSeries] = [
        .init(key: "0x00", name: "Super Smash Bros."),
        .init(key: "0x01", name: "Super Mario")
    ]
    /// Amiibo types.
    static let amiiboTypes: [AmiiboType] = [
        .init(key: "0x00", name: "Figure"),
        .init(key: "0x01", name: "Card")
    ]
    /// Game characters.
    static let gameCharacters: [GameCharacter] = [
        .init(key: "0x0000", name: "Mario"),
        .init(key: "0x0100", name: "Zelda")
    ]
    /// Game series.
    static let gameSeries: [GameSeries] = [
        .init(key: "0x000", name: "Super Mario"),
        .init(key: "0x010", name: "The Legend of Zelda")
    ]
}
