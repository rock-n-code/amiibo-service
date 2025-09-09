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
