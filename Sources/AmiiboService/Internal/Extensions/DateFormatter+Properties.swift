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

extension DateFormatter {
    
    // MARK: Properties
    
    /// An ISO timestamp formatter.
    ///
    /// This formatter implements the `yyyy-MM-dd'T'HH:mm:ss.SSSSSS` custom date format.
    /// Within the context of this library, this formatter is solely used to decode a date formatted as a timestamp that is returned by the ``AmiiboService/getLastUpdated()`` function.
    static var isoTimestamp: DateFormatter {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        formatter.timeZone = .init(secondsFromGMT: 0)
        
        return formatter
    }
    
}
