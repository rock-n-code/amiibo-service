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

import Foundation
import OpenAPIRuntime

/// A transcoder for ISO dates in the `yyyy-MM-dd'T'HH:mm:ss.SSSSSS` timestamp and `yyyy-MM-dd` date-only formats.
struct ISODateTimeTranscoder {
    
    // MARK: Properties
    
    /// The ISO timestamp formatter.
    private let timestampFormatter: DateFormatter = .isoTimestamp

    /// The ISO date-only formatter.
    private let dateFormatter: DateFormatter = .isoDate
    
}

// MARK: - DateTranscoder

extension ISODateTimeTranscoder: DateTranscoder {
    
    // MARK: Functions
    
    /// Encodes a date as an ISO timestamp string.
    func encode(_ date: Date) throws -> String {
        timestampFormatter.string(from: date)
    }
    
    /// Decodes an ISO date string, trying the timestamp format before the date-only one.
    /// - Throws: A `DecodingError` if the string matches neither format.
    func decode(_ string: String) throws -> Date {
        if let date = timestampFormatter.date(from: string) {
            return date
        }
        
        if let date = dateFormatter.date(from: string) {
            return date
        }
        
        throw DecodingError.dataCorrupted(.init(
            codingPath: [],
            debugDescription: "Expected an ISO date with format 'yyyy-MM-dd'T'HH:mm:ss.SSSSSS' or 'yyyy-MM-dd', but found '\(string)' instead."
        ))
    }
    
}
