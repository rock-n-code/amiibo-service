import Communications
import Foundation
import XCTest

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
        XCTAssertNil(result.first?.games3DS)
        XCTAssertNil(result.first?.gamesWiiU)
        XCTAssertNil(result.first?.gamesSwitch)
        XCTAssertNil(result.last?.games3DS)
        XCTAssertNil(result.last?.gamesWiiU)
        XCTAssertNil(result.last?.gamesSwitch)
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
        XCTAssertNotNil(result.first?.games3DS)
        XCTAssertEqual(result.first?.games3DS?.count, 21)
        XCTAssertNil(result.first?.games3DS?.first?.usage)
        XCTAssertNotNil(result.first?.gamesWiiU)
        XCTAssertEqual(result.first?.gamesWiiU?.count, 8)
        XCTAssertNil(result.first?.gamesWiiU?.first?.usage)
        XCTAssertNotNil(result.first?.gamesSwitch)
        XCTAssertEqual(result.first?.gamesSwitch?.count, 8)
        XCTAssertNil(result.first?.gamesSwitch?.first?.usage)
        XCTAssertNotNil(result.last?.games3DS)
        XCTAssertEqual(result.last?.games3DS?.count, 22)
        XCTAssertNil(result.last?.games3DS?.first?.usage)
        XCTAssertNotNil(result.last?.gamesWiiU)
        XCTAssertEqual(result.last?.gamesWiiU?.count, 8)
        XCTAssertNil(result.last?.gamesWiiU?.first?.usage)
        XCTAssertNotNil(result.last?.gamesSwitch)
        XCTAssertEqual(result.last?.gamesSwitch?.count, 9)
        XCTAssertNil(result.last?.gamesSwitch?.first?.usage)
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
        XCTAssertNotNil(result.first?.games3DS)
        XCTAssertEqual(result.first?.games3DS?.count, 21)
        XCTAssertNotNil(result.first?.games3DS?.first?.usage)
        XCTAssertEqual(result.first?.games3DS?.first?.usage?.count, 1)
        XCTAssertNotNil(result.first?.gamesWiiU)
        XCTAssertEqual(result.first?.gamesWiiU?.count, 8)
        XCTAssertNotNil(result.first?.gamesWiiU?.first?.usage)
        XCTAssertEqual(result.first?.gamesWiiU?.first?.usage?.count, 1)
        XCTAssertNotNil(result.first?.gamesSwitch)
        XCTAssertEqual(result.first?.gamesSwitch?.count, 8)
        XCTAssertNotNil(result.first?.gamesSwitch?.first?.usage)
        XCTAssertEqual(result.first?.gamesSwitch?.first?.usage?.count, 1)
        XCTAssertNotNil(result.last?.games3DS)
        XCTAssertEqual(result.last?.games3DS?.count, 22)
        XCTAssertNotNil(result.last?.games3DS?.first?.usage)
        XCTAssertEqual(result.last?.games3DS?.first?.usage?.count, 1)
        XCTAssertNotNil(result.last?.gamesWiiU)
        XCTAssertEqual(result.last?.gamesWiiU?.count, 8)
        XCTAssertNotNil(result.last?.gamesWiiU?.first?.usage)
        XCTAssertEqual(result.last?.gamesWiiU?.first?.usage?.count, 1)
        XCTAssertNotNil(result.last?.gamesSwitch)
        XCTAssertEqual(result.last?.gamesSwitch?.count, 9)
        XCTAssertNotNil(result.last?.gamesSwitch?.first?.usage)
        XCTAssertEqual(result.last?.gamesSwitch?.first?.usage?.count, 1)
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
