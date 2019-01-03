//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation
import KeychainAccess

struct KeychainDataStore {
    var load = loadFromKeychain
    var save = saveToKeychain(remoteNodeConnection:)
    var delete = deleteFromKeychain
}

func loadFromKeychain() -> Result<RemoteNodeConnection> {
    let keychain = Keychain(service: "com.matthewramsden.Test1")
    guard let data = keychain[data: "remoteNodeConfiguration"] else { return Result.failure(DataError.noRemoteData) }
    guard let remoteNodeConnection = try? JSONDecoder().decode(RemoteNodeConnection.self, from: data) else {return Result.failure(DataError.encodingFailure)}
    return Result.success(remoteNodeConnection)
}

func saveToKeychain(remoteNodeConnection: RemoteNodeConnection) -> Result<String> {
    guard let data = try? JSONEncoder().encode(remoteNodeConnection) else { return Result.failure(DataError.encodingFailure)  }
    let keychain = Keychain(service: "com.matthewramsden.Test1")
    keychain[data: "remoteNodeConfiguration"] = data
    return Result.success("Saved Value to Defaults!")
}

func deleteFromKeychain() {
    let keychain = Keychain(service: "com.matthewramsden.Test1")
    try? keychain.remove("remoteNodeConfiguration")
}
