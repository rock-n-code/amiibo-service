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

public struct GameCharacterFilter: KeyNameFilter {
    
    // MARK: Properties
    
    public let key: String?
    public let name: String?
    
    // MARK: Initialisers
    
    public init() {
        self.key = nil
        self.name = nil
    }
    
    public init(key: String) {
        self.key = key
        self.name = nil
    }
    
    public init(name: String) {
        self.key = nil
        self.name = name
    }
    
}
