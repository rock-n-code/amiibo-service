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

@testable import AmiiboService
import Foundation
import HTTPTypes
import Testing

@Suite("Amiibo Live Client")
struct AmiiboLiveClientTests {
    
    // MARK: Server URL tests
    
    @Test
    func `resolves the server URL defined in the OpenAPI specification`() throws {
        // GIVEN
        // WHEN
        let url = try Servers.Server1.url()
        
        // THEN
        #expect(url.absoluteString == "https://www.amiiboapi.org/api")
    }
    
    @Test
    func `uses the server URL from the OpenAPI specification`() throws {
        // GIVEN
        let expected = try Servers.Server1.url()
        
        // WHEN
        let url = AmiiboLiveClient.serverURL
        
        // THEN
        #expect(url == expected)
    }

    // MARK: Error mapping tests

    @Test(arguments: zip(
        TransportErrors.thrown,
        TransportErrors.expected
    ))
    func `maps an error thrown by the transport to the matching service error`(
        thrown: any Error,
        expected: AmiiboServiceError
    ) async {
        // GIVEN
        let client = AmiiboLiveClient(transport: ThrowingTransport(error: thrown))

        // WHEN
        // THEN
        await #expect(throws: expected) {
            try await client.getAmiibos(by: .init())
        }
    }

    @Test(arguments: zip(
        Responses.failing,
        Responses.expected
    ))
    func `maps a response status to the matching service error`(
        response: (status: Int, json: String?),
        expected: AmiiboServiceError
    ) async {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport(
            status: .init(code: response.status),
            json: response.json
        ))

        // WHEN
        // THEN
        await #expect(throws: expected) {
            try await client.getAmiibos(by: .init())
        }
    }

    // MARK: Get Amiibos tests

    @Test
    func `returns amiibos sorted by identifier`() async throws {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport(status: .ok, json: JSON.amiibos))

        // WHEN
        let amiibos = try await client.getAmiibos(by: .init())

        // THEN
        #expect(amiibos.map(\.identifier) == ["0000000000000002", "0100000000040002"])
        #expect(amiibos.map(\.name) == ["Mario", "Zelda"])
    }

    @Test
    func `returns a single amiibo when the response holds an object`() async throws {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport(status: .ok, json: JSON.amiibo))

        // WHEN
        let amiibos = try await client.getAmiibos(by: .init(identifier: "0100000000040002"))
        let amiibo = try #require(amiibos.first)

        // THEN
        #expect(amiibos.count == 1)
        #expect(amiibo.head == "01000000")
        #expect(amiibo.tail == "00040002")
        #expect(amiibo.name == "Zelda")
        #expect(amiibo.type == "Figure")
        #expect(amiibo.series == "Super Smash Bros.")
        #expect(amiibo.gameCharacter == "Zelda")
        #expect(amiibo.gameSeries == "The Legend of Zelda")
        #expect(amiibo.imageURL?.host() == "example.com")
        #expect(amiibo.platform == nil)
    }

    @Test
    func `returns no amiibos when the response holds null`() async throws {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport(status: .ok, json: JSON.amiibosNull))

        // WHEN
        let amiibos = try await client.getAmiibos(by: .init(identifier: "0000000000000000"))

        // THEN
        #expect(amiibos.isEmpty)
    }

    @Test
    func `returns no amiibos when the response holds an empty list`() async throws {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport(status: .ok, json: JSON.amiibosEmpty))

        // WHEN
        let amiibos = try await client.getAmiibos(by: .init(name: "Something"))

        // THEN
        #expect(amiibos.isEmpty)
    }

    @Test
    func `decodes release dates as midnight UTC, and missing or null ones as nil`() async throws {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport(status: .ok, json: JSON.amiibos))

        // WHEN
        let amiibos = try await client.getAmiibos(by: .init())
        let mario = try #require(amiibos.first)
        let zelda = try #require(amiibos.last)

        // THEN
        #expect(mario.release.america == .utc(2014, 11, 21))
        #expect(mario.release.australia == .utc(2014, 11, 29))
        #expect(mario.release.europe == .utc(2014, 11, 28))
        #expect(mario.release.japan == .utc(2014, 12, 6))
        #expect(zelda.release.australia == nil)
        #expect(zelda.release.japan == nil)
    }

    @Test
    func `maps related games and usages into the platform`() async throws {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport(status: .ok, json: JSON.amiiboWithGames))

        // WHEN
        let amiibos = try await client.getAmiibos(by: .init(showUsage: true))
        let platform = try #require(amiibos.first?.platform)
        let game = try #require(platform.switch.first)

        // THEN
        #expect(platform.switch.count == 1)
        #expect(platform.switch2.isEmpty)
        #expect(platform.threeDS.isEmpty)
        #expect(platform.wiiU.count == 1)
        #expect(game.identifiers == ["01007EF00011E000"])
        #expect(game.name == "The Legend of Zelda: Breath of the Wild")
        #expect(game.usages == [.init(explanation: "Spawns a random selection of items.", isWriteable: false)])
        #expect(platform.wiiU.first?.usages == nil)
    }

    @Test
    func `encodes the amiibo filter as query parameters`() async throws {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport { request in
            let path = request.path ?? ""

            #expect(path.hasPrefix("/amiibo?"))
            #expect(path.contains("id=0100000000040002"))
            #expect(path.contains("head=01000000"))
            #expect(path.contains("tail=00040002"))
            #expect(path.contains("name=zelda"))
            #expect(path.contains("type=0x00"))
            #expect(path.contains("amiiboSeries=0x00"))
            #expect(path.contains("character=0x0100"))
            #expect(path.contains("gameseries=0x010"))
            #expect(path.contains("showgames=true"))
            #expect(path.contains("showusage=false"))

            return StubTransport.response(status: .ok, json: JSON.amiibosEmpty)
        })

        // WHEN
        // THEN
        _ = try await client.getAmiibos(by: .init(
            head: "01000000",
            tail: "00040002",
            identifier: "0100000000040002",
            name: "zelda",
            type: "0x00",
            series: "0x00",
            gameCharacter: "0x0100",
            gameSeries: "0x010",
            showGames: true,
            showUsage: false
        ))
    }

    @Test
    func `omits nil filter values from the query`() async throws {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport { request in
            #expect(request.path == "/amiibo")

            return StubTransport.response(status: .ok, json: JSON.amiibosEmpty)
        })

        // WHEN
        // THEN
        _ = try await client.getAmiibos(by: .init())
    }

    // MARK: Key-name endpoints tests

    @Test
    func `returns amiibo series sorted by key`() async throws {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport(status: .ok, json: JSON.keyNameList))

        // WHEN
        let series = try await client.getAmiiboSeries(by: .init())

        // THEN
        #expect(series == [.init(key: "0x00", name: "Second"), .init(key: "0x01", name: "First")])
    }

    @Test
    func `returns a single amiibo series when the response holds an object`() async throws {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport { request in
            #expect(request.path == "/amiiboseries?key=0x01")

            return StubTransport.response(status: .ok, json: JSON.keyName)
        })

        // WHEN
        let series = try await client.getAmiiboSeries(by: .init(key: "0x01"))

        // THEN
        #expect(series == [.init(key: "0x01", name: "First")])
    }

    @Test
    func `returns amiibo types sorted by key`() async throws {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport { request in
            #expect(request.path == "/type")

            return StubTransport.response(status: .ok, json: JSON.keyNameList)
        })

        // WHEN
        let types = try await client.getAmiiboTypes(by: .init())

        // THEN
        #expect(types == [.init(key: "0x00", name: "Second"), .init(key: "0x01", name: "First")])
    }

    @Test
    func `returns game characters sorted by key`() async throws {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport { request in
            #expect(request.path == "/character?name=First")

            return StubTransport.response(status: .ok, json: JSON.keyNameList)
        })

        // WHEN
        let characters = try await client.getGameCharacters(by: .init(name: "First"))

        // THEN
        #expect(characters == [.init(key: "0x00", name: "Second"), .init(key: "0x01", name: "First")])
    }

    @Test
    func `returns game series sorted by key`() async throws {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport { request in
            #expect(request.path == "/gameseries")

            return StubTransport.response(status: .ok, json: JSON.keyNameList)
        })

        // WHEN
        let series = try await client.getGameSeries(by: .init())

        // THEN
        #expect(series == [.init(key: "0x00", name: "Second"), .init(key: "0x01", name: "First")])
    }

    @Test
    func `throws notFound when a key-name endpoint matches nothing`() async {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport(status: .notFound, json: JSON.notFound))

        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notFound) {
            try await client.getGameSeries(by: .init(key: "0xffff"))
        }
    }

    // MARK: Get Last Updated tests

    @Test
    func `returns the last updated timestamp as UTC`() async throws {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport { request in
            #expect(request.path == "/lastupdated")

            return StubTransport.response(status: .ok, json: JSON.lastUpdated)
        })

        // WHEN
        let lastUpdated = try await client.getLastUpdated()

        // THEN
        #expect(lastUpdated == .utc(2026, 7, 24, 12, 34, 56))
    }

    @Test
    func `throws notAvailable when the last updated endpoint fails`() async {
        // GIVEN
        let client = AmiiboLiveClient(transport: StubTransport(status: .internalServerError))

        // WHEN
        // THEN
        await #expect(throws: AmiiboServiceError.notAvailable) {
            try await client.getLastUpdated()
        }
    }

}

// MARK: - Arguments

private enum TransportErrors {
    /// Errors thrown by the transport.
    static let thrown: [any Error] = [
        CancellationError(),
        URLError(.cancelled),
        URLError(.cannotParseResponse),
        URLError(.notConnectedToInternet),
        URLError(.timedOut),
        URLError(.badURL)
    ]
    /// The service error expected for each thrown error.
    static let expected: [AmiiboServiceError] = [
        .cancelled,
        .cancelled,
        .decoding,
        .notAvailable,
        .notAvailable,
        .unknown(String(describing: URLError(.badURL)))
    ]
}

private enum Responses {
    /// Failing responses, with a body where the specification documents one.
    static let failing: [(status: Int, json: String?)] = [
        (400, JSON.badRequest),
        (404, JSON.notFound),
        (500, nil),
        (418, nil),
        (200, "not json")
    ]
    /// The service error expected for each failing response.
    static let expected: [AmiiboServiceError] = [
        .badRequest,
        .notFound,
        .notAvailable,
        .undocumented(418),
        .decoding
    ]
}

// MARK: - Payloads

private enum JSON {
    /// Two amiibos in reverse identifier order; the first lacks `au` and has a null `jp`.
    static let amiibos = """
    {"amiibo": [
        {
            "amiiboSeries": "Super Smash Bros.", "character": "Zelda", "gameSeries": "The Legend of Zelda",
            "head": "01000000", "tail": "00040002", "name": "Zelda", "type": "Figure",
            "image": "https://example.com/zelda.png",
            "release": {"eu": "2014-11-28", "jp": null, "na": "2014-11-21"}
        },
        {
            "amiiboSeries": "Super Smash Bros.", "character": "Mario", "gameSeries": "Super Mario",
            "head": "00000000", "tail": "00000002", "name": "Mario", "type": "Figure",
            "image": "https://example.com/mario.png",
            "release": {"au": "2014-11-29", "eu": "2014-11-28", "jp": "2014-12-06", "na": "2014-11-21"}
        }
    ]}
    """
    /// A single amiibo, as returned for an `id` filter.
    static let amiibo = """
    {"amiibo": {
        "amiiboSeries": "Super Smash Bros.", "character": "Zelda", "gameSeries": "The Legend of Zelda",
        "head": "01000000", "tail": "00040002", "name": "Zelda", "type": "Figure",
        "image": "https://example.com/zelda.png",
        "release": {"au": "2014-12-04", "eu": "2014-11-28", "jp": "2014-12-06", "na": "2014-11-21"}
    }}
    """
    /// An amiibo with Switch and Wii U games, an empty 3DS list, and no Switch 2 key.
    static let amiiboWithGames = """
    {"amiibo": [{
        "amiiboSeries": "Super Smash Bros.", "character": "Zelda", "gameSeries": "The Legend of Zelda",
        "head": "01000000", "tail": "00040002", "name": "Zelda", "type": "Figure",
        "image": "https://example.com/zelda.png",
        "release": {"na": "2014-11-21"},
        "games3DS": [],
        "gamesSwitch": [{
            "gameID": ["01007EF00011E000"],
            "gameName": "The Legend of Zelda: Breath of the Wild",
            "amiiboUsage": [{"Usage": "Spawns a random selection of items.", "write": false}]
        }],
        "gamesWiiU": [{
            "gameID": ["0005000010145000"],
            "gameName": "Super Smash Bros. for Wii U"
        }]
    }]}
    """
    /// The response for an `id` filter that matches nothing.
    static let amiibosNull = """
    {"amiibo": null}
    """
    /// The response for any other filter that matches nothing.
    static let amiibosEmpty = """
    {"amiibo": []}
    """
    /// Two key-name items in reverse key order.
    static let keyNameList = """
    {"amiibo": [{"key": "0x01", "name": "First"}, {"key": "0x00", "name": "Second"}]}
    """
    /// A single key-name item, as returned for a `key` filter.
    static let keyName = """
    {"amiibo": {"key": "0x01", "name": "First"}}
    """
    /// The last updated timestamp.
    static let lastUpdated = """
    {"lastUpdated": "2026-07-24T12:34:56.000000"}
    """
    /// The body of a 400 response.
    static let badRequest = """
    {"code": 400, "error": "Bad request."}
    """
    /// The body of a 404 response.
    static let notFound = """
    {"code": 404, "error": "Not found."}
    """
}
