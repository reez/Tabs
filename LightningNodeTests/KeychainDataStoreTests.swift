//
//  KeychainDataStoreTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 2/16/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
import SnapshotTesting
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
        let mockCertificate = try? mockRNC.get().certificate

        XCTAssertEqual(mockCertificate!, rnc.certificate)

    }
    
    func testLoadCertificateSuccessSnapshot() {
        Current = .mock
        
        let rnc = RemoteNodeConnection.init(
            uri: lndURI,
            certificate: lndCertificate,
            macaroon: lndMacaroon
        )
        
        let mockRNC = Current.keychain.load()
        let mockCertificate = try? mockRNC.get().certificate
        
        assertSnapshot(matching: mockCertificate!, as: .dump)
        assertSnapshot(matching: rnc.certificate, as: .dump)

    }
    
    func testLoadMacaroonSuccess() {
        Current = .mock
        
        let rnc = RemoteNodeConnection.init(
            uri: lndURI,
            certificate: lndCertificate,
            macaroon: lndMacaroon
        )
        
        let mockRNC = Current.keychain.load()
        let mockMacaroon = try? mockRNC.get().macaroon

        XCTAssertEqual(mockMacaroon!, rnc.macaroon)
    }
    
    func testLoadMacaroonSuccessSnapshot() {
        Current = .mock
        
        let rnc = RemoteNodeConnection.init(
            uri: lndURI,
            certificate: lndCertificate,
            macaroon: lndMacaroon
        )
        
        let mockRNC = Current.keychain.load()
        let mockMacaroon = try? mockRNC.get().macaroon
        
        assertSnapshot(matching: mockMacaroon!, as: .dump)
        assertSnapshot(matching: rnc.macaroon, as: .dump)
    }
    
    func testLoadURISuccess() {
        Current = .mock
        
        let rnc = RemoteNodeConnection.init(
            uri: lndURI,
            certificate: lndCertificate,
            macaroon: lndMacaroon
        )
        
        let mockRNC = Current.keychain.load()
        let mockURI = try? mockRNC.get().uri

        XCTAssertEqual(mockURI!, rnc.uri)
    }
    
    func testLoadURISuccessSnapshot() {
        Current = .mock
        
        let rnc = RemoteNodeConnection.init(
            uri: lndURI,
            certificate: lndCertificate,
            macaroon: lndMacaroon
        )
        
        let mockRNC = Current.keychain.load()
        let mockURI = try? mockRNC.get().uri
        
        assertSnapshot(matching: mockURI!, as: .dump)
        assertSnapshot(matching: rnc.uri, as: .dump)
    }
    
    func testSaveSuccess() {
        Current = .mock
        
        let rnc = RemoteNodeConnection.init(
            uri: lndURI,
            certificate: lndCertificate,
            macaroon: lndMacaroon
        )
        
        let mockRNC = Current.keychain.save(rnc)
        let mockSave = try? mockRNC.get()
        
        XCTAssertEqual(mockSave!, "Success!")
    }
    
    func testSaveSuccessSnapshot() {
        Current = .mock
        
        let rnc = RemoteNodeConnection.init(
            uri: lndURI,
            certificate: lndCertificate,
            macaroon: lndMacaroon
        )
        
        let mockRNC = Current.keychain.save(rnc)
        let mockSave = try? mockRNC.get()
        
        assertSnapshot(matching: mockSave!, as: .dump)
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
    
    func testSaveFailureSnapshot() {
        Current = .test
        
        let rnc = RemoteNodeConnection.init(
            uri: lndURI,
            certificate: lndCertificate,
            macaroon: lndMacaroon
        )
        
        let mockRNC = Current.keychain.save(rnc)
        
        assertSnapshot(matching: mockRNC.error?.localizedDescription, as: .dump)
    }
    
    func testLoadFailure() {
        Current = .test
        
        let mockRNC = Current.keychain.load()
        
        XCTAssertEqual(mockRNC.error?.localizedDescription, DataError.noSavedData.localizedDescription)
    }
    
}
