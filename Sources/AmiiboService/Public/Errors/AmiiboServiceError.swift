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

/// A representation of all the possible errors that the ``AmiiboService`` service could throw.
public enum AmiiboServiceError: Error {
    /// A bad request has been given to the client.
    case badRequest
    /// A call to an endpoint has been cancelled by the user.
    case cancelled
    /// A response cannot be decoded.
    case decoding
    /// An online service is not currently available.
    case notAvailable
    /// A response cannot be found.
    case notFound
    /// An undocumented/unsupported status code error.
    case undocumented(_ statusCode: Int)
    /// An unknown error.
    case unknown
}

// MARK: - Equatable

extension AmiiboServiceError: Equatable {}
