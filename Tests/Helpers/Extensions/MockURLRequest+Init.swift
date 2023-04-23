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

import Communications
import Foundation

extension MockURLRequest {
    
    // MARK: Initialisers
    
    init(url: URL) {
        self.init(method: .get, url: url)
    }

}
