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
import HTTPTypes
import OpenAPIRuntime

/// A transport that answers every request with a canned response, for testing purposes.
struct StubTransport: ClientTransport {

    // MARK: Type aliases

    /// A closure that builds the response for a request.
    typealias Handler = @Sendable (HTTPRequest) throws -> (HTTPResponse, HTTPBody?)

    // MARK: Properties

    /// The handler that builds the response.
    private let handler: Handler

    // MARK: Initializers

    /// Initializes this transport with a response handler.
    init(handler: @escaping Handler) {
        self.handler = handler
    }

    /// Initializes this transport with a fixed response.
    init(status: HTTPResponse.Status, json: String? = nil) {
        self.init { _ in
            Self.response(status: status, json: json)
        }
    }

    // MARK: Functions

    func send(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String
    ) async throws -> (HTTPResponse, HTTPBody?) {
        try handler(request)
    }

    /// Builds a response with a status and an optional JSON body.
    static func response(
        status: HTTPResponse.Status,
        json: String? = nil
    ) -> (HTTPResponse, HTTPBody?) {
        guard let json else {
            return (.init(status: status), nil)
        }

        return (
            .init(status: status, headerFields: [.contentType: "application/json"]),
            .init(json)
        )
    }

}
