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

import Foundation
import SwiftLibsCommunication
import XCTest

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

@testable import AmiiboService

final class AmiiboClientTests: XCTestCase {

    // MARK: Properties
    
    private let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.ephemeral
        
        configuration.protocolClasses = [MockURLProtocol.self]
        
        return configuration
    }()
    private let makeURLRequest = MakeURLRequestUseCase()
    private let endpoint = TestEndpoint()
    
    private var client: AmiiboClient!
    
    // MARK: Setup
    
    override func setUp() async throws {
        client = .init(configuration: configuration)
    }
    
    override func tearDown() async throws {
        client = nil
    }
    
    // MARK: Tests
    
    func test_request_withEndpointAndModel_whenDataDoesMatchModel() async throws {
        // GIVEN
        let url = try XCTUnwrap(try makeURLRequest(endpoint: endpoint).url)
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Client.Seed.dataWithoutTimestamp
        )

        // WHEN
        let model = try await client.request(
            endpoint: endpoint,
            as: TestModel.self
        )
        
        // THEN
        XCTAssertNotNil(model)
        XCTAssertNil(model.timestamp)
    }
    
    func test_request_withEndpointAndModel_whenDataDoesMatchModel_andDateDecodingStrategy() async throws {
        // GIVEN
        let url = try XCTUnwrap(try makeURLRequest(endpoint: endpoint).url)
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Client.Seed.dataWithDateAndTime
        )
        
        client.setDateDecodingStrategy(.formatted(.dateAndTime))

        // WHEN
        let model = try await client.request(
            endpoint: endpoint,
            as: TestModel.self
        )
        
        // THEN
        XCTAssertNotNil(model)
        XCTAssertNotNil(model.timestamp)
    }
    
    func test_request_withEndpointAndModel_whenDataDoesNotMatchModel() async throws {
        // GIVEN
        let url = try XCTUnwrap(try makeURLRequest(endpoint: endpoint).url)
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Client.Seed.dataUnrelated
        )

        // WHEN & THEN
        do {
            let _ = try await client.request(
                endpoint: endpoint,
                as: TestModel.self
            )
        } catch is DecodingError {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func test_request_withEndpointAndModel_whenDateDecodingStrategyNotCorrectlySet() async throws {
        // GIVEN
        let url = try XCTUnwrap(try makeURLRequest(endpoint: endpoint).url)
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .ok,
            data: .Client.Seed.dataWithDateAndTime
        )
        
        client.setDateDecodingStrategy(.formatted(.dateOnly))

        // WHEN & THEN
        do {
            let _ = try await client.request(
                endpoint: endpoint,
                as: TestModel.self
            )
        } catch is DecodingError {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }
    
    func test_request_withEndpointAndModel_whenResponseCodeIsNotOK() async throws {
        // GIVEN
        let url = try XCTUnwrap(try makeURLRequest(endpoint: endpoint).url)
        
        MockURLProtocol.mockData[.init(url: url)] = .init(
            status: .notFound,
            data: .Client.Seed.dataWithoutTimestamp
        )

        // WHEN & THEN
        do {
            let _ = try await client.request(
                endpoint: endpoint,
                as: TestModel.self
            )
        } catch is AmiiboClientError {
            XCTAssertTrue(true)
        } catch {
            XCTAssertTrue(false)
        }
    }

}
