//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation

struct Environment {
    var date: () -> Date = Date.init
    var lightningAPIRPC: LightningApiRPC?
    var keychain = KeychainDataStore()
}

var Current = Environment()

extension RemoteNodeConnection {
    static let mock = RemoteNodeConnection.init(uri: "0.0.0.0:10009", certificate: "BEGINCERT-ENDCERT", macaroon: "002")
}

extension Environment {
    static let mock = Environment(
        date: { .mock },
        lightningAPIRPC: .mock,
        keychain: .mock
    )
}

extension Date {
    static let mock = Date()
}

extension LightningApiRPC {
    static let mock = LightningApiRPC.init(configuration: .mock)
}

extension KeychainDataStore {
    static let mock = KeychainDataStore(load: {
        let rnc = RemoteNodeConnection.mock
        return Result.success(rnc)
    }, save: { _ in //(rnc) -> Result<String> in
        return Result.success("Success!")
    }, delete: { }
    )
}


// For Unit Tests
extension KeychainDataStore {
    static let test = KeychainDataStore(load: {
        let rnc = RemoteNodeConnection.mock
        return Result.failure(DataError.fetchInfoFailure)// Result.success(rnc)
    }, save: { _ in //(rnc) -> Result<String> in
        return Result.success("Failure!")
    }, delete: { }
    )
}

extension Environment {
    static let test = Environment(
        date: { .mock },
        lightningAPIRPC: .mock,
        keychain: .test
    )
}
