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

/// A concrete representation of the types of client that a ``AmiiboService`` service can utilize.
/// 
/// > important: This enumeration has been defined as a way to avoid exposing the `APIClient` protocol outside the boundaries of this library.
public enum AmiiboClient {
    /// A live Amiibo client to interact with the online service.
    case live(AmiiboLiveClient = .init())
    ///A mock Amiibo client, for testing purposes.
    case mock(AmiiboMockClient)
}
