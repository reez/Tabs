//
//  KeychainDataStoreTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 2/16/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
@testable import LightningNode

class KeychainDataStoreTests: XCTestCase {

    func testLoadCertificateSuccess() {
        Current = .mock
        
        let rnc = RemoteNodeConnection.init(
            uri: lndURI,
            certificate: lndCertificate,
            macaroon: lndMacaroon
        )
        
        let mockRNC = Current.keychain.load()
        
        XCTAssertEqual(mockRNC.value?.certificate, rnc.certificate)
    }
    
    func testLoadMacaroonSuccess() {
        Current = .mock
        
        let rnc = RemoteNodeConnection.init(
            uri: lndURI,
            certificate: lndCertificate,
            macaroon: lndMacaroon
        )
        
        let mockRNC = Current.keychain.load()
        
        XCTAssertEqual(mockRNC.value?.macaroon, rnc.macaroon)
    }
    
    func testLoadURISuccess() {
        Current = .mock
        
        let rnc = RemoteNodeConnection.init(
            uri: lndURI,
            certificate: lndCertificate,
            macaroon: lndMacaroon
        )
        
        let mockRNC = Current.keychain.load()
        
        XCTAssertEqual(mockRNC.value?.uri, rnc.uri)
    }
    
    
    func testSaveSuccess() {
        Current = .mock
        
        let rnc = RemoteNodeConnection.init(
            uri: lndURI,
            certificate: lndCertificate,
            macaroon: lndMacaroon
        )
        
        let mockRNC = Current.keychain.save(rnc)
        
        XCTAssertEqual(mockRNC.value, "Success!")
    }
    
    func testSaveFailure() {
        Current = .test
        
        let rnc = RemoteNodeConnection.init(
            uri: lndURI,
            certificate: lndCertificate,
            macaroon: lndMacaroon
        )
        
        let mockRNC = Current.keychain.save(rnc)
        
        XCTAssertEqual(mockRNC.error?.localizedDescription, "\(DataError.encodingFailure.localizedDescription)")
    }
    

}
