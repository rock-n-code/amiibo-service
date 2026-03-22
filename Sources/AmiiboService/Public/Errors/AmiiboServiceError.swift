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

/// A representation of all the possible errors that the ``AmiiboService`` service could throw.
public enum AmiiboServiceError: Error {
    /// The request was malformed or contained invalid filter parameters.
    case badRequest
    /// The request was cancelled before a response was received.
    case cancelled
    /// The response body could not be decoded into the expected model.
    case decoding
    /// The backend service is currently unreachable due to a network or server issue.
    case notAvailable
    /// No results were found matching the given filter criteria.
    case notFound
    /// The server returned an undocumented HTTP status code.
    case undocumented(_ statusCode: Int)
    /// An unexpected error that does not fall into any other category.
    case unknown
}

// MARK: - Equatable

extension AmiiboServiceError: Equatable {}
