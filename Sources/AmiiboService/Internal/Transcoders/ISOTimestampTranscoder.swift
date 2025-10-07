// ===----------------------------------------------------------------------===
// 
// This source file is part of the Amiibo Service open source project
// 
// Copyright (c) 2025 Röck+Cöde VoF. and the Amiibo Service project authors
// Licensed under Apache license v2.0
// 
// See LICENSE for license information
// See CONTRIBUTORS for the list of Amiibo Service project authors
//
// SPDX-License-Identifier: Apache-2.0
// 
// ===----------------------------------------------------------------------===

import Foundation
import OpenAPIRuntime

/// A type that allows the decoding and encoding of ISO timestamp dates, defined by the `yyyy-MM-dd'T'HH:mm:ss.SSSSSS` custom date format.
struct ISOTimestampTranscoder {
    
    // MARK: Properties
    
    /// A formatter to use to decode and encode ISO timestamps dates.
    private let dateFormatter: DateFormatter = .isoTimestamp
    
}

 // MARK: - DateTranscoder

extension ISOTimestampTranscoder: DateTranscoder {
    
    // MARK: Functions
    
    func encode(_ date: Date) throws -> String {
        dateFormatter.string(from: date)
    }
    
    func decode(_ string: String) throws -> Date {
        dateFormatter.date(from: string) ?? .init()
    }
    
}
