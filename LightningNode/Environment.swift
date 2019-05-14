//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation

struct Environment {
    var date: () -> Date = Date.init
    var lightningAPIRPC = LightningApiRPC()
    var keychain = KeychainDataStore()
    var remoteNodeConnection: RemoteNodeConnection?
    var remoteNodeConnectionFormatted: RemoteNodeConnection?
}

var Current = Environment()

extension Environment {
    static let mock = Environment(
        date: { .mock },
        lightningAPIRPC: .mock,
        keychain: .mock,
        remoteNodeConnection: .mock,
        remoteNodeConnectionFormatted: .mockFormatted
    )
}

extension Environment {
    static let test = Environment(
        date: { .test },
        lightningAPIRPC: .test,
        keychain: .test,
        remoteNodeConnection: .mock,
        remoteNodeConnectionFormatted: .mockFormatted
    )
}

extension Date {
    static let mock = Date(timeIntervalSinceReferenceDate: 547152021)
}

extension Date {
    static let test = Date(timeIntervalSinceReferenceDate: 547152021)
}

extension LightningApiRPC {
    static let mock = LightningApiRPC.init(addInvoice: { (value, memo, callback) in
        let call = callback
        call(Result.success("mockInvoice"))
    }, canConnect: { (callback) in
        callback(true)
    }) { (callback) in
        callback(Result.success(Info.mock))
    }
}

extension LightningApiRPC {
    static let test = LightningApiRPC.init(addInvoice: { (_, _, callback) in
        callback(Result.failure(DataError.invoiceFailure))
    }, canConnect: { (callback) in
        callback(false)
    }) { (callback) in
        callback(Result.failure(DataError.noSavedData))
    }
}

extension KeychainDataStore {
    static let mock = KeychainDataStore(load: {
        let rnc = RemoteNodeConnection.mock
        return Result.success(rnc)
    }, save: { _ in
        return Result.success("Success!")
    }, delete: { }
    )
}

extension KeychainDataStore {
    static let test = KeychainDataStore(load: {
        return Result.failure(DataError.noSavedData)
    }, save: { _ in
        return Result.failure(DataError.encodingFailure)
    }, delete: { }
    )
}

extension Info {
    static let mock = Info.init(
        alias: "No alias",
        bestHeaderTimestamp: Current.date(),
        blockHash: "No blockHash",
        blockHeight: 0,
        chainsArray: [],
        identityPubkey: "No identityPubkey",
        numActiveChannels: 0,
        numPeers: 0,
        numPendingChannels: 0,
        syncedToChain: false,
        testnet: true,
        urisArray: [],
        version: "No version")
}

extension RemoteNodeConnection {
    static let mock = RemoteNodeConnection.init(uri: lndURI, certificate: lndCertificate, macaroon: lndMacaroon)
    static let mockFormatted = RemoteNodeConnection.init(uri: lndURI, certificate: lndCertificate, macaroon: lndMacaroon)
}

