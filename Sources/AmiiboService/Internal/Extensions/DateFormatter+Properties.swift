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

extension DateFormatter {
    
    // MARK: Properties
    
    /// An ISO date formatter for the `yyyy-MM-dd` format.
    static let isoDate: DateFormatter = {
        let formatter = DateFormatter()
        
        // The POSIX locale keeps the user's locale and 12/24-hour setting from altering fixed-format parsing.
        formatter.locale = .init(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = .init(secondsFromGMT: 0)
        
        return formatter
    }()
    
    /// An ISO timestamp formatter for the `yyyy-MM-dd'T'HH:mm:ss.SSSSSS` format.
    ///
    /// Used only to decode the timestamp returned by ``AmiiboService/getLastUpdated()``.
    static let isoTimestamp: DateFormatter = {
        let formatter = DateFormatter()
        
        // The POSIX locale keeps the user's locale and 12/24-hour setting from altering fixed-format parsing.
        formatter.locale = .init(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        formatter.timeZone = .init(secondsFromGMT: 0)
        
        return formatter
    }()
    
}
