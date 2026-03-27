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

/// A type that allows the decoding and encoding of ISO dates, supporting both the `yyyy-MM-dd'T'HH:mm:ss.SSSSSS` timestamp format and the `yyyy-MM-dd` date-only format.
struct ISODateTimeTranscoder {
    
    // MARK: Properties
    
    /// A formatter to use to decode and encode ISO timestamp dates.
    private let timestampFormatter: DateFormatter = .isoTimestamp
    
    /// A formatter to use to decode and encode ISO date-only strings.
    private let dateFormatter: DateFormatter = .isoDate
    
}

// MARK: - DateTranscoder

extension ISODateTimeTranscoder: DateTranscoder {
    
    // MARK: Functions
    
    /// Encodes a date into an ISO timestamp string.
    /// - Parameter date: A date to encode.
    /// - Returns: A string representation of the date in `yyyy-MM-dd'T'HH:mm:ss.SSSSSS` format.
    func encode(_ date: Date) throws -> String {
        timestampFormatter.string(from: date)
    }
    
    /// Decodes an ISO date string into a date, trying the timestamp format first and falling back to the date-only format.
    /// - Parameter string: A string to decode.
    /// - Returns: A date parsed from the string.
    /// - Throws: A `DecodingError` if the string cannot be parsed into a valid date.
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
