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

/// An error thrown by ``AmiiboService`` and ``AmiiboClient`` methods.
public enum AmiiboServiceError: Error {
    /// The request was malformed or contained invalid filter parameters.
    case badRequest
    /// The request was cancelled before a response was received.
    case cancelled
    /// The response body could not be decoded into the expected model.
    case decoding
    /// The service is unreachable due to a network or server issue.
    case notAvailable
    /// No results were found matching the given filter criteria.
    ///
    /// When no amiibos match, ``AmiiboService/getAmiibos(_:)`` returns an empty array instead of throwing this error.
    case notFound
    /// The server returned an undocumented HTTP status code.
    case undocumented(_ statusCode: Int)
    /// Any other error, with a description of the underlying one.
    case unknown(_ description: String)
}

// MARK: - Equatable

extension AmiiboServiceError: Equatable {}

// MARK: - LocalizedError

extension AmiiboServiceError: LocalizedError {

    // MARK: Properties

    public var errorDescription: String? {
        switch self {
        case .badRequest: "The request was malformed or contained invalid filter parameters."
        case .cancelled: "The request was cancelled before a response was received."
        case .decoding: "The response body could not be decoded into the expected model."
        case .notAvailable: "The backend service is currently unreachable due to a network or server issue."
        case .notFound: "No results were found matching the given filter criteria."
        case .undocumented(let statusCode): "The server returned an undocumented HTTP status code: \(statusCode)."
        case .unknown(let description): "An unexpected error occurred: \(description)"
        }
    }

}
