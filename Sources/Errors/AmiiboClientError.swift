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

/// This error definitions represents any error happening while the client makes a request to the remote API and handles the respective response, excluding the decoding of the retrieved data into a particular model.
public enum AmiiboClientError: Error {
    /// The data and/or response expected from an API call are not found.
    case dataOrResponseNotFound
    /// The status code of the response is not the expected one, which is `.ok` (`200`).
    case responseCode(Int)
    /// The status code of the response was not received at all.
    case responseCodeNotFound
}
