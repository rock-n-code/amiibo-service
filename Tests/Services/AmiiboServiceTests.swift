//===----------------------------------------------------------------------===//
//
// This source file is part of the AmiiboService open source project
//
// Copyright (c) 2023 Röck+Cöde VoF. and the AmiiboService project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of AmiiboService project authors
//
//===----------------------------------------------------------------------===//

import Communications
import Foundation
import XCTest

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@testable import AmiiboService

final class AmiiboServiceTests: XCTestCase {
    
    // MARK: Properties
    
    private let makeURLRequest = MakeURLRequestUseCase()
    private let configuration = {
        let configuration = URLSessionConfiguration.default
        
        configuration.protocolClasses = [MockURLProtocol.self]
        
        return configuration
    }()

    private var service: AmiiboService!
    
    // MARK: Setup
    
    override func setUp() async throws {
        service = .init(configuration: configuration)
    }
    
    override func tearDown() async throws {
        service = nil
    }
    
    // MARK: Amiibos tests
    
    func test_amiibos() async throws {
        // GIVEN
        let endpoint = GetAmiiboEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Service.amiibos
        )
        
        // WHEN
        let result = try await service.amiibos()
        
        // THEN
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 2)
        XCTAssertNil(result.first?.games)
        XCTAssertNil(result.last?.games)
    }
    
    func test_amiibos_withGameData() async throws {
        // GIVEN
        let endpoint = GetAmiiboEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Service.amiibosWithGames
        )
        
        // WHEN
        let result = try await service.amiibos()
        
        // THEN
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 2)
        XCTAssertNotNil(result.first?.games)
        XCTAssertEqual(result.first?.games?.n3ds.count, 21)
        XCTAssertNil(result.first?.games?.n3ds.first?.usage)
        XCTAssertNotNil(result.first?.games?.wiiu)
        XCTAssertEqual(result.first?.games?.wiiu.count, 8)
        XCTAssertNil(result.first?.games?.wiiu.first?.usage)
        XCTAssertNotNil(result.first?.games?.switch)
        XCTAssertEqual(result.first?.games?.switch.count, 8)
        XCTAssertNil(result.first?.games?.switch.first?.usage)
        XCTAssertNotNil(result.last?.games?.n3ds)
        XCTAssertEqual(result.last?.games?.n3ds.count, 22)
        XCTAssertNil(result.last?.games?.n3ds.first?.usage)
        XCTAssertNotNil(result.last?.games?.wiiu)
        XCTAssertEqual(result.last?.games?.wiiu.count, 8)
        XCTAssertNil(result.last?.games?.wiiu.first?.usage)
        XCTAssertNotNil(result.last?.games?.switch)
        XCTAssertEqual(result.last?.games?.switch.count, 9)
        XCTAssertNil(result.last?.games?.switch.first?.usage)
    }
    
    func test_amiibos_withUsageData() async throws {
        // GIVEN
        let endpoint = GetAmiiboEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Service.amiibosWithUsage
        )
        
        // WHEN
        let result = try await service.amiibos()
        
        // THEN
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 2)
        XCTAssertNotNil(result.first?.games?.n3ds)
        XCTAssertEqual(result.first?.games?.n3ds.count, 21)
        XCTAssertNotNil(result.first?.games?.n3ds.first?.usage)
        XCTAssertEqual(result.first?.games?.n3ds.first?.usage?.count, 1)
        XCTAssertNotNil(result.first?.games?.wiiu)
        XCTAssertEqual(result.first?.games?.wiiu.count, 8)
        XCTAssertNotNil(result.first?.games?.wiiu.first?.usage)
        XCTAssertEqual(result.first?.games?.wiiu.first?.usage?.count, 1)
        XCTAssertNotNil(result.first?.games?.switch)
        XCTAssertEqual(result.first?.games?.switch.count, 8)
        XCTAssertNotNil(result.first?.games?.switch.first?.usage)
        XCTAssertEqual(result.first?.games?.switch.first?.usage?.count, 1)
        XCTAssertNotNil(result.last?.games?.n3ds)
        XCTAssertEqual(result.last?.games?.n3ds.count, 22)
        XCTAssertNotNil(result.last?.games?.n3ds.first?.usage)
        XCTAssertEqual(result.last?.games?.n3ds.first?.usage?.count, 1)
        XCTAssertNotNil(result.last?.games?.wiiu)
        XCTAssertEqual(result.last?.games?.wiiu.count, 8)
        XCTAssertNotNil(result.last?.games?.wiiu.first?.usage)
        XCTAssertEqual(result.last?.games?.wiiu.first?.usage?.count, 1)
        XCTAssertNotNil(result.last?.games?.switch)
        XCTAssertEqual(result.last?.games?.switch.count, 9)
        XCTAssertNotNil(result.last?.games?.switch.first?.usage)
        XCTAssertEqual(result.last?.games?.switch.first?.usage?.count, 1)
    }
    
    func test_amiibos_whenDateDecodingStrategyMismatch() async throws {
        // GIVEN
        let endpoint = GetAmiiboEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Service.amiiboWithBadFormattedDates
        )
        
        // WHEN & THEN
        do {
            let _ = try await service.amiibos()
        } catch is DecodingError {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func test_amiibos_whenDataMismatch() async throws {
        // GIVEN
        let endpoint = GetAmiiboEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Service.amiiboWithMissingFields
        )
        
        // WHEN & THEN
        do {
            let _ = try await service.amiibos()
        } catch is DecodingError {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func test_amiibos_whenResponseNotOk() async throws {
        // GIVEN
        let endpoint = GetAmiiboEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .notFound,
            data: .Service.amiibos
        )
        
        // WHEN & THEN
        do {
            let _ = try await service.amiibos()
        } catch is AmiiboClientError {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    // MARK: Amiibo series tests
    
    func test_amiiboSeries() async throws {
        // GIVEN
        let endpoint = GetSeriesEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Service.amiiboSeries
        )
        
        // WHEN
        let result = try await service.amiiboSeries()
        
        // THEN
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 25)
    }
    
    func test_amiiboSeries_whenDataMismatch() async throws {
        // GIVEN
        let endpoint = GetSeriesEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Service.amiiboSeriesWithMissingFields
        )
        
        // WHEN & THEN
        do {
            let _ = try await service.amiiboSeries()
        } catch is DecodingError {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func test_amiiboSeries_whenResponseNotOk() async throws {
        // GIVEN
        let endpoint = GetSeriesEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .internalServerError,
            data: .Service.amiiboSeries
        )
        
        // WHEN & THEN
        do {
            let _ = try await service.amiiboSeries()
        } catch is AmiiboClientError {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    // MARK: Amiibo types tests
    
    func test_amiiboTypes() async throws {
        // GIVEN
        let endpoint = GetTypeEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Service.amiiboTypes
        )
        
        // WHEN
        let result = try await service.amiiboTypes()
        
        // THEN
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 4)
    }
    
    func test_amiiboTypes_whenDataMismatch() async throws {
        // GIVEN
        let endpoint = GetTypeEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Service.amiiboTypesWithMissingFields
        )
        
        // WHEN & THEN
        do {
            let _ = try await service.amiiboTypes()
        } catch is DecodingError {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func test_amiiboTypes_whenResponseNotOk() async throws {
        // GIVEN
        let endpoint = GetTypeEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .forbidden,
            data: .Service.amiiboTypes
        )
        
        // WHEN & THEN
        do {
            let _ = try await service.amiiboTypes()
        } catch is AmiiboClientError {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    // MARK: Character tests
    
    func test_character() async throws {
        // GIVEN
        let endpoint = GetCharacterEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Service.characters
        )
        
        // WHEN
        let result = try await service.characters()
        
        // THEN
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 636)
    }
    
    func test_character_whenDataMismatch() async throws {
        // GIVEN
        let endpoint = GetCharacterEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Service.charactersWithMissingFields
        )
        
        // WHEN & THEN
        do {
            let _ = try await service.characters()
        } catch is DecodingError {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func test_character_whenResponseNotOk() async throws {
        // GIVEN
        let endpoint = GetCharacterEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .badGateway,
            data: .Service.characters
        )
        
        // WHEN & THEN
        do {
            let _ = try await service.characters()
        } catch is AmiiboClientError {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    // MARK: Game series tests
    
    func test_gameSeries() async throws {
        // GIVEN
        let endpoint = GetGameSeriesEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Service.gameSeries
        )
        
        // WHEN
        let result = try await service.gameSeries()
        
        // THEN
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, 115)
    }
    
    func test_gameSeries_whenDataMismatch() async throws {
        // GIVEN
        let endpoint = GetGameSeriesEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Service.gameSeriesWithMissingFields
        )
        
        // WHEN & THEN
        do {
            let _ = try await service.gameSeries()
        } catch is DecodingError {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func test_gameSeries_whenResponseNotOk() async throws {
        // GIVEN
        let endpoint = GetGameSeriesEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .badRequest,
            data: .Service.gameSeries
        )
        
        // WHEN & THEN
        do {
            let _ = try await service.gameSeries()
        } catch is AmiiboClientError {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    // MARK: Last updated tests
    
    func test_lastUpdated() async throws {
        // GIVEN
        let endpoint = GetLastUpdatedEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Service.lastUpdated
        )
        
        // WHEN
        let result = try await service.lastUpdated()
        
        // THEN
        XCTAssertNotNil(result)
    }
    
   func test_lastUpdated_whenDateDecodingStrategyMismatch() async throws {
       // GIVEN
       let endpoint = GetLastUpdatedEndpoint()
       let url: URL! = try makeURLRequest(endpoint: endpoint).url
       
       MockURLProtocol.mockData[.init(url: url)] = .init(
           status: .ok,
           data: .Service.lastUpdatedWithBadFormattedDate
       )
       
       // WHEN & THEN
       do {
           let _ = try await service.lastUpdated()
       } catch is DecodingError {
           XCTAssertTrue(true)
       } catch {
           XCTAssertTrue(false)
       }
    }
    
    func test_lastUpdated_whenDataMismatch() async throws {
        // GIVEN
        let endpoint = GetLastUpdatedEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Service.lastUpdatedWithBadInfo
        )
        
        // WHEN & THEN
        do {
            let _ = try await service.lastUpdated()
        } catch is DecodingError {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func test_lastUpdated_whenResponseNotOk() async throws {
        // GIVEN
        let endpoint = GetLastUpdatedEndpoint()
        let url: URL! = try makeURLRequest(endpoint: endpoint).url
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .unauthorized,
            data: .Service.lastUpdated
        )
        
        // WHEN & THEN
        do {
            let _ = try await service.lastUpdated()
        } catch is AmiiboClientError {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
}
