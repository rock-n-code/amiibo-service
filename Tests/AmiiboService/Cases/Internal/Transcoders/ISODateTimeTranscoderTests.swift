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

@Suite("ISO Date Time Transcoder")
struct ISODateTimeTranscoderTests {

    // MARK: Properties

    private let transcoder = ISODateTimeTranscoder()

    // MARK: Decode tests

    @Test
    func `decodes a timestamp as UTC`() throws {
        // GIVEN
        let string = "2026-07-24T12:34:56.123000"

        // WHEN
        let date = try transcoder.decode(string)

        // THEN
        #expect(abs(date.timeIntervalSince(.utc(2026, 7, 24, 12, 34, 56)) - 0.123) < 0.001)
    }

    @Test
    func `decodes a date-only string as midnight UTC`() throws {
        // GIVEN
        let string = "2014-11-21"

        // WHEN
        let date = try transcoder.decode(string)

        // THEN
        #expect(date == .utc(2014, 11, 21))
    }

    @Test(arguments: [
        "", "2014-11", "2014-11-21T12:34:56", "2014-11-21T12:34:56Z", "21/11/2014", "yesterday"
    ])
    func `throws a decoding error for an unsupported string`(string: String) {
        // GIVEN
        // WHEN
        // THEN
        #expect(throws: DecodingError.self) {
            try transcoder.decode(string)
        }
    }

    // MARK: Encode tests

    @Test
    func `encodes a date as a timestamp`() throws {
        // GIVEN
        let date: Date = .utc(2026, 7, 24, 12, 34, 56)

        // WHEN
        let string = try transcoder.encode(date)

        // THEN
        #expect(string == "2026-07-24T12:34:56.000000")
    }

}
