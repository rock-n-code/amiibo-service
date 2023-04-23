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

import Communications
import Foundation

struct GetLastUpdatedEndpoint: Endpoint {
    
    // MARK: Properties
    
    let scheme: String = .Scheme.https
    let host: String = .Host.amiiboApi
    let port: Int? = nil
    let path: String = .Path.lastUpdated
    let parameters: Parameters = [:]
    let method: HTTPRequestMethod = .get
    let headers: [String : String] = [:]
    let body: Data? = nil
    
}
