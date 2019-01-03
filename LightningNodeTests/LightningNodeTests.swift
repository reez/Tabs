//
//  LightningNodeTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
@testable import LightningNode

class LightningNodeTests: XCTestCase {
    
    // Keychain
    
    func testLoadCertificateSuccess() {
        Current = .mock
        
        let rnc = RemoteNodeConnection.init(
            uri: "0.0.0.0:10009",
            certificate: "BEGINCERT-ENDCERT",
            macaroon: "002")
        
        let mockRNC = Current.keychain.load()
        
        XCTAssertEqual(mockRNC.value?.certificate, rnc.certificate)
    }
    
    func testLoadMacaroonSuccess() {
        Current = .mock
        
        let rnc = RemoteNodeConnection.init(
            uri: "0.0.0.0:10009",
            certificate: "BEGINCERT-ENDCERT",
            macaroon: "002")
        
        let mockRNC = Current.keychain.load()
        
        XCTAssertEqual(mockRNC.value?.macaroon, rnc.macaroon)
    }
    
    func testLoadURISuccess() {
        Current = .mock
        
        let rnc = RemoteNodeConnection.init(
            uri: "0.0.0.0:10009",
            certificate: "BEGINCERT-ENDCERT",
            macaroon: "002")
        
        let mockRNC = Current.keychain.load()
        
        XCTAssertEqual(mockRNC.value?.uri, rnc.uri)
    }
    
    
    func testSaveSuccess() {
        Current = .mock
        
        let rnc = RemoteNodeConnection.init(
            uri: "0.0.0.0:10009",
            certificate: "BEGINCERT-ENDCERT",
            macaroon: "002")
        
        let mockRNC = Current.keychain.save(rnc)

        XCTAssertEqual(mockRNC.value, "Success!")
    }
    
    func testSaveFailure() {
        Current = .test
        
        let rnc = RemoteNodeConnection.init(
            uri: "0.0.0.0:10009",
            certificate: "BEGINCERT-ENDCERT",
            macaroon: "002")
        
        let mockRNC = Current.keychain.save(rnc)
        
        XCTAssertEqual(mockRNC.value, "Failure!")
    }
    
}
