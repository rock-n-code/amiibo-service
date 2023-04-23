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

extension String {
    enum Path {
        static let amiibo = "/api/amiibo/"
        static let type = "/api/type"
        static let gameSeries = "/api/gameseries"
        static let series = "/api/amiiboseries"
        static let character = "/api/character"
        static let lastUpdated = "/api/lastupdated"
    }
}
