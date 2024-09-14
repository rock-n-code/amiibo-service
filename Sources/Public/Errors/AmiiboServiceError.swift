//===----------------------------------------------------------------------===
//
// This source file is part of the AmiiboAPI open source project
//
// Copyright (c) 2024 Röck+Cöde VoF. and the AmiiboAPI project authors
// Licensed under the EUPL 1.2 or later.
//
// See LICENSE for license information
// See CONTRIBUTORS for the list of AmiiboAPI project authors
//
//===----------------------------------------------------------------------===

public enum AmiiboServiceError: Error {
    case badRequest
    case decoding
    case notAvailable
    case notFound
    case undocumented(_ statusCode: Int)
    case unknown
}

// MARK: - Equatable

extension AmiiboServiceError: Equatable {}
