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

@testable import AmiiboService
import Foundation
import Testing

@Suite("Amiibo Live Client")
struct AmiiboLiveClientTests {
    
    // MARK: Server URL tests
    
    @Test("resolves the server URL defined in the OpenAPI specification")
    func serverURLResolves() throws {
        // GIVEN
        // WHEN
        let url = try Servers.Server1.url()
        
        // THEN
        #expect(url.absoluteString == "https://www.amiiboapi.org/api")
    }
    
    @Test("uses the server URL from the OpenAPI specification")
    func serverURLMatchesSpecification() throws {
        // GIVEN
        let expected = try Servers.Server1.url()
        
        // WHEN
        let url = AmiiboLiveClient.serverURL
        
        // THEN
        #expect(url == expected)
    }
    
}
