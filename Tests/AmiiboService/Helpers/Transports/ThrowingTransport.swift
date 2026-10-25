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

/// A transport that throws a given error instead of sending the request, for testing purposes.
///
/// The error reaches the live client wrapped in a `ClientError`, as it would from a real transport.
struct ThrowingTransport: ClientTransport {

    // MARK: Properties

    /// The error to throw.
    private let error: any Error

    // MARK: Initializers

    /// Initializes this transport.
    /// - Parameter error: An error to throw.
    init(error: any Error) {
        self.error = error
    }

    // MARK: Functions

    func send(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String
    ) async throws -> (HTTPResponse, HTTPBody?) {
        throw error
    }

}
