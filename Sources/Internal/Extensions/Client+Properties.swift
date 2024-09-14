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

import OpenAPIURLSession

extension Client {
    
    // MARK: Constants
    
    static var live: Client {
        get throws {
            .init(
                serverURL: try Servers.server1(),
                configuration: .init(dateTranscoder: ISODateTranscoder()),
                transport: URLSessionTransport()
            )
        }
    }
    
}
