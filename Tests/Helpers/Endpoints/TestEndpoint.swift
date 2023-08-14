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

struct TestEndpoint: Endpoint {
    
    // MARK: Properties
    
    let scheme: String = "http"
    let host: String = "www.something.com"
    let port: Int? = nil
    let path: String = "/path/to/endpoint"
    let parameters: Parameters = [:]
    let method: HTTPRequestMethod = .get
    let headers: [String : String] = [:]
    let body: Data? = nil

}
