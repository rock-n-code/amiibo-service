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

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

public struct AmiiboLiveClient {
    
    // MARK: Properties
    
    private let client: Client
    
    // MARK: Initialisers
    
    public init() throws {
        self.client = .init(
            serverURL: try Servers.Server1.url(),
            configuration: .init(dateTranscoder: ISODateTranscoder()),
            transport: URLSessionTransport()
        )
    }
    
}

// MARK: - APIProtocol

extension AmiiboLiveClient: APIClient {

    // MARK: Functions
    
    public func getAmiibos(by filter: AmiiboFilter) async throws -> [Amiibo] {
        let response = try await {
            do {
                return try await client.getAmiibos(
                    .init(query: .init(
                        amiiboSeries: filter.series,
                        character: filter.gameCharacter,
                        gameseries: filter.gameSeries,
                        id: filter.identifier,
                        name: filter.name,
                        showgames: filter.showGames,
                        showusage: filter.showUsage,
                        _type: filter.type
                    ))
                )
            } catch let error as ClientError {
                guard let _ = error.underlyingError as? DecodingError else {
                    throw AmiiboServiceError.unknown
                }

                throw AmiiboServiceError.decoding
            } catch {
                throw AmiiboServiceError.unknown
            }
        }()

        switch response {
        case let .ok(ok):
            switch ok.body {
            case let .json(output):
                return map(output)
            }
            
        case .badRequest:
            throw AmiiboServiceError.badRequest
            
        case let .undocumented(statusCode, _):
            throw AmiiboServiceError.undocumented(statusCode)
        }
    }
    
    public func getAmiiboSeries(by filter: AmiiboSeriesFilter) async throws -> [AmiiboSeries] {
        let response = try await client.getAmiiboSeries(
            .init(query: .init(
                key: filter.key,
                name: filter.name
            ))
        )
        
        switch response {
        case let .ok(ok):
            switch ok.body {
            case let .json(output):
                return map(output, as: AmiiboSeries.self)
            }
            
        case .badRequest:
            throw AmiiboServiceError.badRequest
            
        case .internalServerError:
            throw AmiiboServiceError.notAvailable
            
        case .notFound:
            throw AmiiboServiceError.notFound
            
        case let .undocumented(statusCode, _):
            throw AmiiboServiceError.undocumented(statusCode)
        }
    }
    
    public func getAmiiboTypes(by filter: AmiiboTypeFilter) async throws -> [AmiiboType] {
        let response = try await client.getAmiiboTypes(
            .init(query: .init(
                key: filter.key,
                name: filter.name
            ))
        )
        
        switch response {
        case let .ok(ok):
            switch ok.body {
            case let .json(output):
                return map(output, as: AmiiboType.self)
            }
            
        case .badRequest:
            throw AmiiboServiceError.badRequest
            
        case .internalServerError:
            throw AmiiboServiceError.notAvailable
            
        case .notFound:
            throw AmiiboServiceError.notFound
            
        case let .undocumented(statusCode, _):
            throw AmiiboServiceError.undocumented(statusCode)
        }
    }
    
    public func getGameCharacters(by filter: GameCharacterFilter) async throws -> [GameCharacter] {
        let response = try await client.getGameCharacters(
            .init(query: .init(
                key: filter.key,
                name: filter.name
            ))
        )
        
        switch response {
        case let .ok(ok):
            switch ok.body {
            case let .json(output):
                return map(output, as: GameCharacter.self)
            }
            
        case .badRequest:
            throw AmiiboServiceError.badRequest
            
        case .internalServerError:
            throw AmiiboServiceError.notAvailable
            
        case .notFound:
            throw AmiiboServiceError.notFound
            
        case let .undocumented(statusCode, _):
            throw AmiiboServiceError.undocumented(statusCode)
        }
    }
    
    public func getGameSeries(by filter: GameSeriesFilter) async throws -> [GameSeries] {
        let response = try await client.getGameSeries(
            .init(query: .init(
                key: filter.key,
                name: filter.name
            ))
        )
        
        switch response {
        case let .ok(ok):
            switch ok.body {
            case let .json(output):
                return map(output, as: GameSeries.self)
            }
            
        case .badRequest:
            throw AmiiboServiceError.badRequest
            
        case .internalServerError:
            throw AmiiboServiceError.notAvailable
            
        case .notFound:
            throw AmiiboServiceError.notFound
            
        case let .undocumented(statusCode, _):
            throw AmiiboServiceError.undocumented(statusCode)
        }
    }
    
    public func getLastUpdated() async throws -> Date {
        let response = try await client.getLastUpdated()
        
        switch response {
        case let .ok(ok):
            switch ok.body {
            case let .json(output):
                return output.lastUpdated
            }
            
        case let .undocumented(statusCode, _):
            throw AmiiboServiceError.undocumented(statusCode)
        }
    }
    
}

// MARK: - Helpers

private extension AmiiboLiveClient {
    
    // MARK: Functions
    
    func map(_ wrapper: Components.Schemas.AmiiboWrapper) -> [Amiibo] {
        switch wrapper.amiibo {
        case let .Amiibo(object):
            return [.init(object)]
            
        case let .AmiiboList(list):
            return list
                .map { .init($0) }
                .sorted { $0.identifier < $1.identifier }
        }
    }
    
    func map<Model: KeyNameModel>(
        _ wrapper: Components.Schemas.TupleWrapper,
        as: Model.Type
    ) -> [Model] {
        switch wrapper.amiibo {
        case let .Tuple(payload):
            return [.init(payload)]
            
        case let .TupleList(list):
            return list
                .map { .init($0) }
                .sorted { $0.key < $1.key }
        }
    }
    
}
