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

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct AmiiboClient {
    
    // MARK: Properties
    
    private let session: URLSession
    private let decoder = JSONDecoder()
    private let makeURLRequest = MakeURLRequestUseCase()
    
    // MARK: Initialisers
    
    init(configuration: URLSessionConfiguration) {
        session = .init(configuration: configuration)
    }
    
    // MARK: Functions
    
    func setDateDecodingStrategy(_ dateDecodingStrategy: JSONDecoder.DateDecodingStrategy) {
        decoder.dateDecodingStrategy = dateDecodingStrategy
    }
    
}

// MARK: - Client

extension AmiiboClient: Client {

    // MARK: Functions
    
    func request<Model>(
        endpoint: some Endpoint,
        as model: Model.Type
    ) async throws -> Model where Model : Decodable {
        let urlRequest = try makeURLRequest(endpoint: endpoint)
        let (data, response) = try await data(from: session, for: urlRequest)

        try check(response)

        return try decoder.decode(model, from: data)
    }
    
}

// MARK: - Helpers

private extension AmiiboClient {
    
    // MARK: Functions

    func data(
        from session: URLSession,
        for urlRequest: URLRequest
    ) async throws -> (Data, URLResponse) {
        #if canImport(FoundationNetworking)
            try await withCheckedThrowingContinuation { continuation in
                session.dataTask(with: urlRequest) { data, response, error in
                    if let error {
                        continuation.resume(with: .failure(error))
                    } else if let data, let response {
                        continuation.resume(with: .success((data, response)))
                    } else {
                        continuation.resume(with: .failure(AmiiboClientError.dataOrResponseNotFound))
                    }
                }
            }
        #else
            try await session.data(for: urlRequest)
        #endif
    }
    
    func check(_ response: URLResponse) throws {
        guard
            let urlResponse = response as? HTTPURLResponse,
            let responseCode = HTTPResponseCode(rawValue: urlResponse.statusCode)
        else {
            throw AmiiboClientError.responseCodeNotFound
        }
        
        guard responseCode == .ok else {
            throw AmiiboClientError.responseCode(responseCode.rawValue)
        }
    }
    
}
