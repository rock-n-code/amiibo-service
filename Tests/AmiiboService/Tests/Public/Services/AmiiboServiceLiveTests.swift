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

import AmiiboService
import Foundation
import Testing

@Suite("Live service")
struct AmiiboServiceLiveTests {
    
    // MARK: Properties
    
    private let service: AmiiboService
    
    // MARK: Initializers
    
    init() {
        self.service = .init(.live())
    }
    
    // MARK: Functions tests
    
    @Test
    func `get Amiibo items`() async throws {
        // GIVEN
        // WHEN
        let amiibos = try await service.getAmiibos()
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 885)
        #expect(amiibos.first?.identifier == "0000000000000002")
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.identifier == "3f000000042e0002")
        #expect(amiibos.last?.platform == nil)
    }
    
    @Test
    func `get Amiibo items by an existing identifier`() async throws {
        // GIVEN
        let identifier = "0000000000000002"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(identifier: identifier))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 1)
        #expect(amiibos.first?.identifier == identifier)
        #expect(amiibos.first?.platform == nil)
    }
    
    @Test
    func `get Amiibo items by a non-existing identifier`() async throws {
        // GIVEN
        let identifier = "0000000000000000"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.decoding) {
            try await service.getAmiibos(.init(identifier: identifier))
        }
    }
    
    @Test
    func `get Amiibo items by an incomplete identifier`() async throws {
        // GIVEN
        let identifier = "0000000"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.decoding) {
            try await service.getAmiibos(.init(identifier: identifier))
        }
    }
    
    @Test
    func `get Amiibo items by an empty identifier`() async throws {
        // GIVEN
        let identifier = ""
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiibos(.init(identifier: identifier))
        }
    }
    
    @Test
    func `get Amiibo items by an existing name`() async throws {
        // GIVEN
        let name = "zelda"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(name: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 5)
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.platform == nil)
        
        let nameFirst = try #require(amiibos.first?.name.lowercased())
        let nameLast = try #require(amiibos.last?.name.lowercased())
        
        #expect(nameFirst.contains(name))
        #expect(nameLast.contains(name))
    }
    
    @Test
    func `get Amiibo items by a non-existing name`() async throws {
        // GIVEN
        let name = "Something"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(name: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test
    func `get Amiibo items by an incomplete name`() async throws {
        // GIVEN
        let name = "zel"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(name: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 7)
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.platform == nil)
        
        let nameFirst = try #require(amiibos.first?.name.lowercased())
        let nameLast = try #require(amiibos.last?.name.lowercased())
        
        #expect(nameFirst.contains(name))
        #expect(nameLast.contains(name))
    }
    
    @Test
    func `get Amiibo items by an empty name`() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(name: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 885)
    }
    
    @Test
    func `get Amiibo items by an existing type key`() async throws {
        // GIVEN
        let key = "0x00"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(type: key))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 235)
        #expect(amiibos.first?.type == "Figure")
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.type == "Figure")
        #expect(amiibos.last?.platform == nil)
    }
    
    @Test
    func `get Amiibo items by an existing type name`() async throws {
        // GIVEN
        let name = "figure"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(type: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 235)
        #expect(amiibos.first?.type == "Figure")
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.type == "Figure")
        #expect(amiibos.last?.platform == nil)
    }
    
    @Test
    func `get Amiibo items by a non-existing type key`() async throws {
        // GIVEN
        let key = "0x0f"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(type: key))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test
    func `get Amiibo items by a non-existing type name`() async throws {
        // GIVEN
        let name = "something"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(type: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test
    func `get Amiibo items by an incomplete type key`() async throws {
        // GIVEN
        let key = "0x"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiibos(.init(type: key))
        }
    }
    
    @Test
    func `get Amiibo items by an incomplete type name`() async throws {
        // GIVEN
        let name = "fig"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(type: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test
    func `get Amiibo items by an empty type key`() async throws {
        // GIVEN
        let key = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(type: key))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test
    func `get Amiibo items by an empty type name`() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(type: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test
    func `get Amiibo items by an existing series key`() async throws {
        // GIVEN
        let key = "0x00"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(series: key))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 96)
        #expect(amiibos.first?.series == "Super Smash Bros.")
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.series == "Super Smash Bros.")
        #expect(amiibos.last?.platform == nil)
    }
    
    @Test
    func `get Amiibo items by an existing series name`() async throws {
        // GIVEN
        let name = "Legend Of Zelda"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(series: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 26)
        #expect(amiibos.first?.series == name)
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.series == name)
        #expect(amiibos.last?.platform == nil)
    }
    
    @Test
    func `get Amiibo items by a non-existing series key`() async throws {
        // GIVEN
        let key = "0xf9"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(series: key))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test
    func `get Amiibo items by a non-existing series name`() async throws {
        // GIVEN
        let name = "something"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(series: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test
    func `get Amiibo items by an incomplete series key`() async throws {
        // GIVEN
        let key = "0x"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiibos(.init(series: key))
        }
    }
    
    @Test
    func `get Amiibo items by an incomplete series name`() async throws {
        // GIVEN
        let name = "fig"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(series: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 25)
    }
    
    @Test
    func `get Amiibo items by an empty series key`() async throws {
        // GIVEN
        let key = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(series: key))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 885)
    }
    
    @Test
    func `get Amiibo items by an empty series name`() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(series: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 885)
    }
    
    @Test
    func `get Amiibo items by an existing game character key`() async throws {
        // GIVEN
        let key = "0x00"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameCharacter: key))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 11)
        #expect(amiibos.first?.gameCharacter == "Mario")
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.gameCharacter == "Mario")
        #expect(amiibos.last?.platform == nil)
    }
    
    @Test
    func `get Amiibo items by an existing game character name`() async throws {
        // GIVEN
        let name = "Zelda"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameCharacter: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 6)
        #expect(amiibos.first?.gameCharacter == name)
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.gameCharacter == name)
        #expect(amiibos.last?.platform == nil)
    }
    
    @Test
    func `get Amiibo items by a non-existing game character key`() async throws {
        // GIVEN
        let key = "0xf9"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameCharacter: key))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test
    func `get Amiibo items by a non-existing game character name`() async throws {
        // GIVEN
        let name = "something"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameCharacter: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test
    func `get Amiibo items by an incomplete game character key`() async throws {
        // GIVEN
        let key = "0x"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiibos(.init(gameCharacter: key))
        }
    }
    
    @Test
    func `get Amiibo items by an incomplete game character name`() async throws {
        // GIVEN
        let name = "fig"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameCharacter: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test
    func `get Amiibo items by an empty game character key`() async throws {
        // GIVEN
        let key = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameCharacter: key))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 885)
    }
    
    @Test
    func `get Amiibo items by an empty game character name`() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameCharacter: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 885)
    }
    
    @Test
    func `get Amiibo items by an existing game series key`() async throws {
        // GIVEN
        let key = "0x00"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameSeries: key))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 45)
        #expect(amiibos.first?.gameSeries == "Super Mario")
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.gameSeries == "Super Mario")
        #expect(amiibos.last?.platform == nil)
    }
    
    @Test
    func `get Amiibo items by an existing game series name`() async throws {
        // GIVEN
        let name = "The Legend of Zelda"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameSeries: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 32)
        #expect(amiibos.first?.gameSeries == name)
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.gameSeries == name)
        #expect(amiibos.last?.platform == nil)
    }
    
    @Test
    func `get Amiibo items by a non-existing game series key`() async throws {
        // GIVEN
        let key = "0xf9"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameSeries: key))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test
    func `get Amiibo items by a non-existing game series name`() async throws {
        // GIVEN
        let name = "something"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameSeries: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test
    func `get Amiibo items by an incomplete game series key`() async throws {
        // GIVEN
        let key = "0x"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiibos(.init(gameSeries: key))
        }
    }
    
    @Test
    func `get Amiibo items by an incomplete game series name`() async throws {
        // GIVEN
        let name = "Super"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameSeries: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 143)
    }
    
    @Test
    func `get Amiibo items by an empty game series key`() async throws {
        // GIVEN
        let key = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameSeries: key))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 885)
    }
    
    @Test
    func `get Amiibo items by an empty game series name`() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameSeries: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 885)
    }
    
    @Test
    func `get Amiibo items with games data`() async throws {
        // GIVEN
        // WHEN
        let amiibos = try await service.getAmiibos(.init(showGames: true))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 885)
        #expect(amiibos.first?.platform != nil)
        #expect(amiibos.first?.platform?.switch.isEmpty == false)
        #expect(amiibos.first?.platform?.switch.first?.usages == nil)
        #expect(amiibos.first?.platform?.threeDS.isEmpty == false)
        #expect(amiibos.first?.platform?.threeDS.first?.usages == nil)
        #expect(amiibos.first?.platform?.wiiU.isEmpty == false)
        #expect(amiibos.first?.platform?.wiiU.first?.usages == nil)
        #expect(amiibos.last?.platform != nil)
    }
    
    @Test
    func `get Amiibo items with games and usages data`() async throws {
        // GIVEN
        // WHEN
        let amiibos = try await service.getAmiibos(.init(showUsage: true))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 885)
        #expect(amiibos.first?.platform != nil)
        #expect(amiibos.first?.platform?.switch.isEmpty == false)
        #expect(amiibos.first?.platform?.switch.first?.usages?.isEmpty == false)
        #expect(amiibos.first?.platform?.threeDS.isEmpty == false)
        #expect(amiibos.first?.platform?.threeDS.first?.usages?.isEmpty == false)
        #expect(amiibos.first?.platform?.wiiU.isEmpty == false)
        #expect(amiibos.first?.platform?.wiiU.first?.usages?.isEmpty == false)
        #expect(amiibos.last?.platform != nil)
    }
    
    @Test
    func `get Amiibo series`() async throws {
        // GIVEN
        // WHEN
        let amiiboSeries = try await service.getAmiiboSeries()
        
        // THEN
        #expect(!amiiboSeries.isEmpty)
        #expect(amiiboSeries.count == 28)
        #expect(amiiboSeries.first?.key == "0x00")
        #expect(amiiboSeries.last?.key == "0xff")
    }
    
    @Test
    func `get Amiibo series by an existing key`() async throws {
        // GIVEN
        let key = "0x01"
        
        // WHEN
        let amiiboSeries = try await service.getAmiiboSeries(.init(key: key))
        
        // THEN
        #expect(!amiiboSeries.isEmpty)
        #expect(amiiboSeries.count == 1)
        #expect(amiiboSeries.first?.key == key)
    }
    
    @Test
    func `get Amiibo series by a non-existing key`() async throws {
        // GIVEN
        let key = "0xf9"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getAmiiboSeries(.init(key: key))
        }
    }
    
    @Test
    func `get Amiibo series by an incomplete key`() async throws {
        // GIVEN
        let key = "0x"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiiboSeries(.init(key: key))
        }
    }
    
    @Test
    func `get Amiibo series by an empty key`() async throws {
        // GIVEN
        let key = ""
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiiboSeries(.init(key: key))
        }
    }
    
    @Test
    func `get Amiibo series by an existing name`() async throws {
        // GIVEN
        let name = "Legend Of Zelda"
        
        // WHEN
        let amiiboSeries = try await service.getAmiiboSeries(.init(name: name))
        
        // THEN
        #expect(!amiiboSeries.isEmpty)
        #expect(amiiboSeries.count == 1)
        #expect(amiiboSeries.first?.name == name)
    }
    
    @Test
    func `get Amiibo series by a non-existing name`() async throws {
        // GIVEN
        let name = "Something"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getAmiiboSeries(.init(name: name))
        }
    }
    
    @Test
    func `get Amiibo series by an incomplete name`() async throws {
        // GIVEN
        let name = "Zelda"
        
        // WHEN
        let amiiboSeries = try await service.getAmiiboSeries(.init(name: name))
        
        // THEN
        #expect(!amiiboSeries.isEmpty)
        #expect(amiiboSeries.count == 1)
        
        let amiiboSeriesName = try #require(amiiboSeries.first)
        
        #expect(amiiboSeriesName.name.contains(name))
    }
    
    @Test
    func `get Amiibo series by an empty name`() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let amiiboSeries = try await service.getAmiiboSeries(.init(name: name))
        
        // THEN
        #expect(!amiiboSeries.isEmpty)
        #expect(amiiboSeries.count == 28)
        #expect(amiiboSeries.first?.key == "0x00")
        #expect(amiiboSeries.last?.key == "0xff")
    }
    
    @Test
    func `get Amiibo types`() async throws {
        // GIVEN
        // WHEN
        let amiiboTypes = try await service.getAmiiboTypes()
        
        // THEN
        #expect(!amiiboTypes.isEmpty)
        #expect(amiiboTypes.count == 4)
        #expect(amiiboTypes.first?.key == "0x00")
        #expect(amiiboTypes.last?.key == "0x03")
    }
    
    @Test
    func `get Amiibo types by an existing key`() async throws {
        // GIVEN
        let key = "0x01"
        
        // WHEN
        let amiiboTypes = try await service.getAmiiboTypes(.init(key: key))
        
        // THEN
        #expect(!amiiboTypes.isEmpty)
        #expect(amiiboTypes.count == 1)
        #expect(amiiboTypes.first?.key == key)
    }
    
    @Test
    func `get Amiibo types by a non-existing key`() async throws {
        // GIVEN
        let key = "0x09"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getAmiiboTypes(.init(key: key))
        }
    }
    
    @Test
    func `get Amiibo types by an incomplete key`() async throws {
        // GIVEN
        let key = "0x"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiiboTypes(.init(key: key))
        }
    }
    
    @Test
    func `get Amiibo types by an empty key`() async throws {
        // GIVEN
        let key = ""
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiiboTypes(.init(key: key))
        }
    }
    
    @Test
    func `get Amiibo types by an existing name`() async throws {
        // GIVEN
        let name = "Card"
        
        // WHEN
        let amiiboTypes = try await service.getAmiiboTypes(.init(name: name))
        
        // THEN
        #expect(!amiiboTypes.isEmpty)
        #expect(amiiboTypes.count == 1)
        #expect(amiiboTypes.first?.name == name)
    }
    
    @Test
    func `get Amiibo types by a non-existing name`() async throws {
        // GIVEN
        let name = "Something"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getAmiiboTypes(.init(name: name))
        }
    }
    
    @Test
    func `get Amiibo types by an incomplete name`() async throws {
        // GIVEN
        let name = "Ca"
        
        // WHEN
        let amiiboTypes = try await service.getAmiiboTypes(.init(name: name))
        
        // THEN
        #expect(!amiiboTypes.isEmpty)
        #expect(amiiboTypes.count == 1)
        
        let amiiboTypeName = try #require(amiiboTypes.first)
        
        #expect(amiiboTypeName.name.contains(name))
    }
    
    @Test
    func `get Amiibo types by an empty name`() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let amiiboTypes = try await service.getAmiiboTypes(.init(name: name))
        
        // THEN
        #expect(!amiiboTypes.isEmpty)
        #expect(amiiboTypes.count == 4)
        #expect(amiiboTypes.first?.key == "0x00")
        #expect(amiiboTypes.last?.key == "0x03")
    }
    
    @Test
    func `get Game characters`() async throws {
        // GIVEN
        // WHEN
        let gameCharacters = try await service.getGameCharacters()
        
        // THEN
        #expect(!gameCharacters.isEmpty)
        #expect(gameCharacters.count == 668)
        #expect(gameCharacters.first?.key == "0x0000")
        #expect(gameCharacters.last?.key == "0x3f00")
    }
    
    @Test
    func `get Game characters by an existing key`() async throws {
        // GIVEN
        let key = "0x0001"
        
        // WHEN
        let gameCharacters = try await service.getGameCharacters(.init(key: key))
        
        // THEN
        #expect(!gameCharacters.isEmpty)
        #expect(gameCharacters.count == 1)
        #expect(gameCharacters.first?.key == key)
    }
    
    @Test
    func `get Game characters by a non-existing key`() async throws {
        // GIVEN
        let key = "0xffff"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getGameCharacters(.init(key: key))
        }
    }
    
    @Test
    func `get Game characters by an incomplete key`() async throws {
        // GIVEN
        let key = "0x"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getGameCharacters(.init(key: key))
        }
    }
    
    @Test
    func `get Game characters by an empty key`() async throws {
        // GIVEN
        let key = ""
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getGameCharacters(.init(key: key))
        }
    }
    
    @Test
    func `get Game characters by an existing name`() async throws {
        // GIVEN
        let name = "Zelda"
        
        // WHEN
        let gameCharacters = try await service.getGameCharacters(.init(name: name))
        
        // THEN
        #expect(!gameCharacters.isEmpty)
        #expect(gameCharacters.count == 1)
        #expect(gameCharacters.first?.name == name)
    }
    
    @Test
    func `get Game characters by a non-existing name`() async throws {
        // GIVEN
        let name = "Something"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getGameCharacters(.init(name: name))
        }
    }
    
    @Test
    func `get Game characters by an incomplete name`() async throws {
        // GIVEN
        let name = "Zeld"
        
        // WHEN
        let gameCharacters = try await service.getGameCharacters(.init(name: name))
        
        // THEN
        #expect(!gameCharacters.isEmpty)
        #expect(gameCharacters.count == 1)
        
        let gameCharactersName = try #require(gameCharacters.first)
        
        #expect(gameCharactersName.name.contains(name))
    }
    
    @Test
    func `get Game characters by an empty name`() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let gameCharacters = try await service.getGameCharacters(.init(name: name))
        
        // THEN
        #expect(!gameCharacters.isEmpty)
        #expect(gameCharacters.count == 668)
        #expect(gameCharacters.first?.key == "0x0000")
        #expect(gameCharacters.last?.key == "0x3f00")
    }
    
    @Test
    func `get Game series`() async throws {
        // GIVEN
        // WHEN
        let gameSeries = try await service.getGameSeries()
        
        // THEN
        #expect(!gameSeries.isEmpty)
        #expect(gameSeries.count == 117)
        #expect(gameSeries.first?.key == "0x000")
        #expect(gameSeries.last?.key == "0x3f0")
    }
    
    @Test
    func `get Game series by an existing key`() async throws {
        // GIVEN
        let key = "0x001"
        
        // WHEN
        let gameSeries = try await service.getGameSeries(.init(key: key))
        
        // THEN
        #expect(!gameSeries.isEmpty)
        #expect(gameSeries.count == 1)
        #expect(gameSeries.first?.key == key)
    }
    
    @Test
    func `get Game Series by a non-existing key`() async throws {
        // GIVEN
        let key = "0xffff"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getGameSeries(.init(key: key))
        }
    }
    
    @Test
    func `get Game series by an incomplete key`() async throws {
        // GIVEN
        let key = "0x"
        
        // WHEN & THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getGameSeries(.init(key: key))
        }
    }
    
    @Test
    func `get Game series by an empty key`() async throws {
        // GIVEN
        let key = ""
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getGameSeries(.init(key: key))
        }
    }
    
    @Test
    func `get Game series by an existing name`() async throws {
        // GIVEN
        let name = "Pikmin"
        
        // WHEN
        let gameSeries = try await service.getGameSeries(.init(name: name))
        
        // THEN
        #expect(!gameSeries.isEmpty)
        #expect(gameSeries.count == 1)
        #expect(gameSeries.first?.name == name)
    }
    
    @Test
    func `get Game series by a non-existing name`() async throws {
        // GIVEN
        let name = "Something"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getGameSeries(.init(name: name))
        }
    }
    
    @Test
    func `get Game series by an incomplete name`() async throws {
        // GIVEN
        let name = "Pik"
        
        // WHEN
        let gameSeries = try await service.getGameSeries(.init(name: name))
        
        // THEN
        #expect(!gameSeries.isEmpty)
        #expect(gameSeries.count == 1)
        
        let gameSeriesName = try #require(gameSeries.first)
        
        #expect(gameSeriesName.name.contains(name))
    }
    
    @Test
    func `get Game series by an empty name`() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let gameSeries = try await service.getGameSeries(.init(name: name))
        
        // THEN
        #expect(!gameSeries.isEmpty)
        #expect(gameSeries.count == 117)
        #expect(gameSeries.first?.key == "0x000")
        #expect(gameSeries.last?.key == "0x3f0")
    }
    
    @Test
    func `get the Last Updated timestamp`() async throws {
        // GIVEN
        // WHEN
        let dateLastUpdated = try await service.getLastUpdated()
        
        // THEN
        let dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: dateLastUpdated
        )
        
        #expect(dateComponents.year == 2025)
        #expect(dateComponents.month == 7)
        #expect(dateComponents.day == 18)
    }
    
}
