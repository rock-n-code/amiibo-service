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

import Foundation
import OpenAPIRuntime

struct ISODateTranscoder: DateTranscoder {

    // MARK: Properties
    private let dateFormatter: DateFormatter = .isoDateTime
    
    // MARK: Functions
    
    func encode(_ date: Date) throws -> String {
        dateFormatter.string(from: date)
    }
    
    func decode(_ string: String) throws -> Date {
        dateFormatter.date(from: string) ?? .init()
    }
    
}
