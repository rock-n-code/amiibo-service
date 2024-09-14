//===----------------------------------------------------------------------===
//
// This source file is part of the AmiiboAPI open source project
//
// Copyright (c) 2024 Röck+Cöde VoF. and the AmiiboAPI project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE for license information
// See CONTRIBUTORS for the list of AmiiboAPI project authors
//
//===----------------------------------------------------------------------===

import AmiiboAPI
import Foundation
import Testing

struct AmiiboServiceLiveTests {
    
    // MARK: Properties
    
    private let service: AmiiboService
    
    // MARK: Initialisers
    
    init() throws {
        let client = try AmiiboLiveClient()
        
        self.service = .init(client)
    }
    
    // MARK: Functions tests
    
    @Test("Get Amiibo items")
    func getAmiibos() async throws {
        // GIVEN
        // WHEN
        let amiibos = try await service.getAmiibos()
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 853)
        #expect(amiibos.first?.identifier == "0000000000000002")
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.identifier == "3f000000042e0002")
        #expect(amiibos.last?.platform == nil)
    }
    
    @Test("Get Amiibo items by an existing identifier")
    func getAmiibos_byExistingIdentifier() async throws {
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
    
    @Test("Get Amiibo items by a non-existing identifier")
    func getAmiibos_byNonExistingIdentifier() async throws {
        // GIVEN
        let identifier = "0000000000000000"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.decoding) {
            try await service.getAmiibos(.init(identifier: identifier))
        }
    }
    
    @Test("Get Amiibo items by an incomplete identifier")
    func getAmiibos_byIncompleteIdentifier() async throws {
        // GIVEN
        let identifier = "0000000"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.decoding) {
            try await service.getAmiibos(.init(identifier: identifier))
        }
    }
    
    @Test("Get Amiibo items by an empty identifier")
    func getAmiibos_byEmptyIdentifier() async throws {
        // GIVEN
        let identifier = ""
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiibos(.init(identifier: identifier))
        }
    }
    
    @Test("Get Amiibo items by an existing name")
    func getAmiibos_byExistingName() async throws {
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
    
    @Test("Get Amiibo items by a non-existing name")
    func getAmiibos_byNonExistingName() async throws {
        // GIVEN
        let name = "Something"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(name: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test("Get Amiibo items by an incomplete name")
    func getAmiibos_byIncompleteName() async throws {
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
    
    @Test("Get Amiibo items by an empty name")
    func getAmiibos_byEmptyName() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(name: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 853)
    }
    
    @Test("Get Amiibo items by an existing type key")
    func getAmiibos_byExistingTypeKey() async throws {
        // GIVEN
        let key = "0x00"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(type: key))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 227)
        #expect(amiibos.first?.type == "Figure")
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.type == "Figure")
        #expect(amiibos.last?.platform == nil)
    }
    
    @Test("Get Amiibo items by an existing type name")
    func getAmiibos_byExistingTypeName() async throws {
        // GIVEN
        let name = "figure"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(type: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 227)
        #expect(amiibos.first?.type == "Figure")
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.type == "Figure")
        #expect(amiibos.last?.platform == nil)
    }
    
    @Test("Get Amiibo items by a non-existing type key")
    func getAmiibos_byNonExistingTypeKey() async throws {
        // GIVEN
        let key = "0x0f"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(type: key))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test("Get Amiibo items by a non-existing type name")
    func getAmiibos_byNonExistingTypeName() async throws {
        // GIVEN
        let name = "something"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(type: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test("Get Amiibo items by an incomplete type key")
    func getAmiibos_byIncompleteTypeKey() async throws {
        // GIVEN
        let key = "0x"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiibos(.init(type: key))
        }
    }
    
    @Test("Get Amiibo items by an incomplete type name")
    func getAmiibos_byIncompleteTypeName() async throws {
        // GIVEN
        let name = "fig"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(type: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test("Get Amiibo items by an empty type key")
    func getAmiibos_byEmptyTypeKey() async throws {
        // GIVEN
        let key = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(type: key))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test("Get Amiibo items by an empty type name")
    func getAmiibos_byEmptyTypeName() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(type: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test("Get Amiibo items by an existing series key")
    func getAmiibos_byExistingSeriesKey() async throws {
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
    
    @Test("Get Amiibo items by an existing series name")
    func getAmiibos_byExistingSeriesName() async throws {
        // GIVEN
        let name = "Legend Of Zelda"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(series: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 22)
        #expect(amiibos.first?.series == name)
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.series == name)
        #expect(amiibos.last?.platform == nil)
    }
    
    @Test("Get Amiibo items by a non-existing series key")
    func getAmiibos_byNonExistingSeriesKey() async throws {
        // GIVEN
        let key = "0xf9"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(series: key))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test("Get Amiibo items by a non-existing series name")
    func getAmiibos_byNonExistingSeriesName() async throws {
        // GIVEN
        let name = "something"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(series: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test("Get Amiibo items by an incomplete series key")
    func getAmiibos_byIncompleteSeriesKey() async throws {
        // GIVEN
        let key = "0x"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiibos(.init(series: key))
        }
    }
    
    @Test("Get Amiibo items by an incomplete series name")
    func getAmiibos_byIncompleteSeriesName() async throws {
        // GIVEN
        let name = "fig"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(series: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test("Get Amiibo items by an empty series key")
    func getAmiibos_byEmptySeriesKey() async throws {
        // GIVEN
        let key = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(series: key))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 853)
    }
    
    @Test("Get Amiibo items by an empty series name")
    func getAmiibos_byEmptySeriesName() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(series: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 853)
    }
    
    @Test("Get Amiibo items by an existing game character key")
    func getAmiibos_byExistingGameCharacterKey() async throws {
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
    
    @Test("Get Amiibo items by an existing game character name")
    func getAmiibos_byExistingGameCharacterName() async throws {
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
    
    @Test("Get Amiibo items by a non-existing game character key")
    func getAmiibos_byNonExistingGameCharacterKey() async throws {
        // GIVEN
        let key = "0xf9"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameCharacter: key))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test("Get Amiibo items by a non-existing game character name")
    func getAmiibos_byNonExistingGameCharacterName() async throws {
        // GIVEN
        let name = "something"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameCharacter: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test("Get Amiibo items by an incomplete game character key")
    func getAmiibos_byIncompleteGameCharacterKey() async throws {
        // GIVEN
        let key = "0x"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiibos(.init(gameCharacter: key))
        }
    }
    
    @Test("Get Amiibo items by an incomplete game character name")
    func getAmiibos_byIncompleteGameCharacterName() async throws {
        // GIVEN
        let name = "fig"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameCharacter: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test("Get Amiibo items by an empty game character key")
    func getAmiibos_byEmptyGameCharacterKey() async throws {
        // GIVEN
        let key = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameCharacter: key))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 853)
    }
    
    @Test("Get Amiibo items by an empty game character name")
    func getAmiibos_byEmptyGameCharacterName() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameCharacter: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 853)
    }
    
    @Test("Get Amiibo items by an existing game series key")
    func getAmiibos_byExistingGameSeriesKey() async throws {
        // GIVEN
        let key = "0x00"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameSeries: key))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 42)
        #expect(amiibos.first?.gameSeries == "Super Mario")
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.gameSeries == "Super Mario")
        #expect(amiibos.last?.platform == nil)
    }
    
    @Test("Get Amiibo items by an existing game series name")
    func getAmiibos_byExistingGameSeriesName() async throws {
        // GIVEN
        let name = "The Legend of Zelda"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameSeries: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 28)
        #expect(amiibos.first?.gameSeries == name)
        #expect(amiibos.first?.platform == nil)
        #expect(amiibos.last?.gameSeries == name)
        #expect(amiibos.last?.platform == nil)
    }
    
    @Test("Get Amiibo items by a non-existing game series key")
    func getAmiibos_byNonExistingGameSeriesKey() async throws {
        // GIVEN
        let key = "0xf9"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameSeries: key))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test("Get Amiibo items by a non-existing game series name")
    func getAmiibos_byNonExistingGameSeriesName() async throws {
        // GIVEN
        let name = "something"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameSeries: name))
        
        // THEN
        #expect(amiibos.isEmpty)
    }
    
    @Test("Get Amiibo items by an incomplete game series key")
    func getAmiibos_byIncompleteGameSeriesKey() async throws {
        // GIVEN
        let key = "0x"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiibos(.init(gameSeries: key))
        }
    }
    
    @Test("Get Amiibo items by an incomplete game series name")
    func getAmiibos_byIncompleteGameSeriesName() async throws {
        // GIVEN
        let name = "Super"
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameSeries: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 140)
    }
    
    @Test("Get Amiibo items by an empty game series key")
    func getAmiibos_byEmptyGameSeriesKey() async throws {
        // GIVEN
        let key = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameSeries: key))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 853)
    }
    
    @Test("Get Amiibo items by an empty game series name")
    func getAmiibos_byEmptyGameSeriesName() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let amiibos = try await service.getAmiibos(.init(gameSeries: name))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 853)
    }
    
    @Test("Get Amiibo items with games data")
    func getAmiibos_withGamesData() async throws {
        // GIVEN
        // WHEN
        let amiibos = try await service.getAmiibos(.init(showGames: true))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 853)
        #expect(amiibos.first?.platform != nil)
        #expect(amiibos.first?.platform?.switch.isEmpty == false)
        #expect(amiibos.first?.platform?.switch.first?.usages == nil)
        #expect(amiibos.first?.platform?.threeDS.isEmpty == false)
        #expect(amiibos.first?.platform?.threeDS.first?.usages == nil)
        #expect(amiibos.first?.platform?.wiiU.isEmpty == false)
        #expect(amiibos.first?.platform?.wiiU.first?.usages == nil)
        #expect(amiibos.last?.platform != nil)
    }
    
    @Test("Get Amiibo items with games and usages data")
    func getAmiibos_withGamesAndUsagesData() async throws {
        // GIVEN
        // WHEN
        let amiibos = try await service.getAmiibos(.init(showUsage: true))
        
        // THEN
        #expect(!amiibos.isEmpty)
        #expect(amiibos.count == 853)
        #expect(amiibos.first?.platform != nil)
        #expect(amiibos.first?.platform?.switch.isEmpty == false)
        #expect(amiibos.first?.platform?.switch.first?.usages?.isEmpty == false)
        #expect(amiibos.first?.platform?.threeDS.isEmpty == false)
        #expect(amiibos.first?.platform?.threeDS.first?.usages?.isEmpty == false)
        #expect(amiibos.first?.platform?.wiiU.isEmpty == false)
        #expect(amiibos.first?.platform?.wiiU.first?.usages?.isEmpty == false)
        #expect(amiibos.last?.platform != nil)
    }
    
    @Test("Get Amiibo series")
    func getAmiiboSeries() async throws {
        // GIVEN
        // WHEN
        let amiiboSeries = try await service.getAmiiboSeries()
        
        // THEN
        #expect(!amiiboSeries.isEmpty)
        #expect(amiiboSeries.count == 26)
        #expect(amiiboSeries.first?.key == "0x00")
        #expect(amiiboSeries.last?.key == "0xff")
    }
    
    @Test("Get Amiibo series by an existing key")
    func getAmiiboSeries_byExistingKey() async throws {
        // GIVEN
        let key = "0x01"
        
        // WHEN
        let amiiboSeries = try await service.getAmiiboSeries(.init(key: key))
        
        // THEN
        #expect(!amiiboSeries.isEmpty)
        #expect(amiiboSeries.count == 1)
        #expect(amiiboSeries.first?.key == key)
    }
    
    @Test("Get Amiibo series by a non-existing key")
    func getAmiiboSeries_byNonExistingKey() async throws {
        // GIVEN
        let key = "0xf9"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getAmiiboSeries(.init(key: key))
        }
    }
    
    @Test("Get Amiibo series by an incomplete key")
    func getAmiiboSeries_byIncompleteKey() async throws {
        // GIVEN
        let key = "0x"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiiboSeries(.init(key: key))
        }
    }
    
    @Test("Get Amiibo series by an empty key")
    func getAmiiboSeries_byEmptyKey() async throws {
        // GIVEN
        let key = ""
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiiboSeries(.init(key: key))
        }
    }
    
    @Test("Get Amiibo series by an existing name")
    func getAmiiboSeries_byExistingName() async throws {
        // GIVEN
        let name = "Legend Of Zelda"
        
        // WHEN
        let amiiboSeries = try await service.getAmiiboSeries(.init(name: name))
        
        // THEN
        #expect(!amiiboSeries.isEmpty)
        #expect(amiiboSeries.count == 1)
        #expect(amiiboSeries.first?.name == name)
    }
    
    @Test("Get Amiibo series by a non-existing name")
    func getAmiiboSeries_byNonExistingName() async throws {
        // GIVEN
        let name = "Something"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getAmiiboSeries(.init(name: name))
        }
    }
    
    @Test("Get Amiibo series by an incomplete name")
    func getAmiiboSeries_byIncompleteName() async throws {
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
    
    @Test("Get Amiibo series by an empty name")
    func getAmiiboSeries_byEmptyName() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let amiiboSeries = try await service.getAmiiboSeries(.init(name: name))
        
        // THEN
        #expect(!amiiboSeries.isEmpty)
        #expect(amiiboSeries.count == 26)
        #expect(amiiboSeries.first?.key == "0x00")
        #expect(amiiboSeries.last?.key == "0xff")
    }
    
    @Test("Get Amiibo types")
    func getAmiiboTypes() async throws {
        // GIVEN
        // WHEN
        let amiiboTypes = try await service.getAmiiboTypes()
        
        // THEN
        #expect(!amiiboTypes.isEmpty)
        #expect(amiiboTypes.count == 4)
        #expect(amiiboTypes.first?.key == "0x00")
        #expect(amiiboTypes.last?.key == "0x03")
    }
    
    @Test("Get Amiibo types by an existing key")
    func getAmiiboTypes_byExistingKey() async throws {
        // GIVEN
        let key = "0x01"
        
        // WHEN
        let amiiboTypes = try await service.getAmiiboTypes(.init(key: key))
        
        // THEN
        #expect(!amiiboTypes.isEmpty)
        #expect(amiiboTypes.count == 1)
        #expect(amiiboTypes.first?.key == key)
    }
    
    @Test("Get Amiibo types by a non-existing key")
    func getAmiiboTypes_byNonExistingKey() async throws {
        // GIVEN
        let key = "0x09"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getAmiiboTypes(.init(key: key))
        }
    }
    
    @Test("Get Amiibo types by an incomplete key")
    func getAmiiboTypes_byIncompleteKey() async throws {
        // GIVEN
        let key = "0x"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiiboTypes(.init(key: key))
        }
    }
    
    @Test("Get Amiibo types by an empty key")
    func getAmiiboTypes_byEmptyKey() async throws {
        // GIVEN
        let key = ""
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getAmiiboTypes(.init(key: key))
        }
    }
    
    @Test("Get Amiibo types by an existing name")
    func getAmiiboTypes_byExistingName() async throws {
        // GIVEN
        let name = "Card"
        
        // WHEN
        let amiiboTypes = try await service.getAmiiboTypes(.init(name: name))
        
        // THEN
        #expect(!amiiboTypes.isEmpty)
        #expect(amiiboTypes.count == 1)
        #expect(amiiboTypes.first?.name == name)
    }
    
    @Test("Get Amiibo types by a non-existing name")
    func getAmiiboTypes_byNonExistingName() async throws {
        // GIVEN
        let name = "Something"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getAmiiboTypes(.init(name: name))
        }
    }
    
    @Test("Get Amiibo types by an incomplete name")
    func getAmiiboTypes_byIncompleteName() async throws {
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
    
    @Test("Get Amiibo types by an empty name")
    func getAmiiboTypes_byEmptyName() async throws {
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
    
    @Test("Get game characters")
    func getGameCharacters() async throws {
        // GIVEN
        // WHEN
        let gameCharacters = try await service.getGameCharacters()
        
        // THEN
        #expect(!gameCharacters.isEmpty)
        #expect(gameCharacters.count == 644)
        #expect(gameCharacters.first?.key == "0x0000")
        #expect(gameCharacters.last?.key == "0x3f00")
    }
    
    @Test("Get game characters by an existing key")
    func getGameCharacters_byExistingKey() async throws {
        // GIVEN
        let key = "0x0001"
        
        // WHEN
        let gameCharacters = try await service.getGameCharacters(.init(key: key))
        
        // THEN
        #expect(!gameCharacters.isEmpty)
        #expect(gameCharacters.count == 1)
        #expect(gameCharacters.first?.key == key)
    }
    
    @Test("Get game characters by a non-existing key")
    func getGameCharacters_byNonExistingKey() async throws {
        // GIVEN
        let key = "0xffff"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getGameCharacters(.init(key: key))
        }
    }
    
    @Test("Get game characters by an incomplete key")
    func getGameCharacters_byIncompleteKey() async throws {
        // GIVEN
        let key = "0x"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getGameCharacters(.init(key: key))
        }
    }
    
    @Test("Get game characters by an empty key")
    func getGameCharacters_byEmptyKey() async throws {
        // GIVEN
        let key = ""
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getGameCharacters(.init(key: key))
        }
    }
    
    @Test("Get game characters by an existing name")
    func getGameCharacters_byExistingName() async throws {
        // GIVEN
        let name = "Zelda"
        
        // WHEN
        let gameCharacters = try await service.getGameCharacters(.init(name: name))
        
        // THEN
        #expect(!gameCharacters.isEmpty)
        #expect(gameCharacters.count == 1)
        #expect(gameCharacters.first?.name == name)
    }
    
    @Test("Get game characters by a non-existing name")
    func getGameCharacters_byNonExistingName() async throws {
        // GIVEN
        let name = "Something"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getGameCharacters(.init(name: name))
        }
    }
    
    @Test("Get game characters by an incomplete name")
    func getGameCharacters_byIncompleteName() async throws {
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
    
    @Test("Get game characters by an empty name")
    func getGameCharacters_byEmptyName() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let gameCharacters = try await service.getGameCharacters(.init(name: name))
        
        // THEN
        #expect(!gameCharacters.isEmpty)
        #expect(gameCharacters.count == 644)
        #expect(gameCharacters.first?.key == "0x0000")
        #expect(gameCharacters.last?.key == "0x3f00")
    }
    
    @Test("Get game series")
    func getGameSeries() async throws {
        // GIVEN
        // WHEN
        let gameSeries = try await service.getGameSeries()
        
        // THEN
        #expect(!gameSeries.isEmpty)
        #expect(gameSeries.count == 116)
        #expect(gameSeries.first?.key == "0x000")
        #expect(gameSeries.last?.key == "0x3f0")
    }
    
    @Test("Get game series by an existing key")
    func getGameSeries_byExistingKey() async throws {
        // GIVEN
        let key = "0x001"
        
        // WHEN
        let gameSeries = try await service.getGameSeries(.init(key: key))
        
        // THEN
        #expect(!gameSeries.isEmpty)
        #expect(gameSeries.count == 1)
        #expect(gameSeries.first?.key == key)
    }
    
    @Test("Get game series by a non-existing key")
    func getGameSeries_byNonExistingKey() async throws {
        // GIVEN
        let key = "0xffff"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getGameSeries(.init(key: key))
        }
    }
    
    @Test("Get game series by an incomplete key")
    func getGameSeries_byIncompleteKey() async throws {
        // GIVEN
        let key = "0x"
        
        // WHEN & THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getGameSeries(.init(key: key))
        }
    }
    
    @Test("Get game series by an empty key")
    func getGameSeries_byEmptyKey() async throws {
        // GIVEN
        let key = ""
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.badRequest) {
            try await service.getGameSeries(.init(key: key))
        }
    }
    
    @Test("Get game series by an existing name")
    func getGameSeries_byExistingName() async throws {
        // GIVEN
        let name = "Pikmin"
        
        // WHEN
        let gameSeries = try await service.getGameSeries(.init(name: name))
        
        // THEN
        #expect(!gameSeries.isEmpty)
        #expect(gameSeries.count == 1)
        #expect(gameSeries.first?.name == name)
    }
    
    @Test("Get game series by a non-existing name")
    func getGameSeries_byNonExistingName() async throws {
        // GIVEN
        let name = "Something"
        
        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await service.getGameSeries(.init(name: name))
        }
    }
    
    @Test("Get game series by an incomplete name")
    func getGameSeries_byIncompleteName() async throws {
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
    
    @Test("Get game series by an empty name")
    func getGameSeries_byEmptyName() async throws {
        // GIVEN
        let name = ""
        
        // WHEN
        let gameSeries = try await service.getGameSeries(.init(name: name))
        
        // THEN
        #expect(!gameSeries.isEmpty)
        #expect(gameSeries.count == 116)
        #expect(gameSeries.first?.key == "0x000")
        #expect(gameSeries.last?.key == "0x3f0")
    }
    
    @Test("Get the last updated timestamp")
    func getLastUpdated() async throws {
        // GIVEN
        // WHEN
        let dateLastUpdated = try await service.getLastUpdated()
        
        // THEN
        let dateComponents = Calendar.current.dateComponents(
            [.year, .month, .day],
            from: dateLastUpdated
        )
        
        #expect(dateComponents.year == 2024)
        #expect(dateComponents.month == 9)
        #expect(dateComponents.day == 6)
    }
    
}
