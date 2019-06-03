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
    
    func testLoadSuccess() {
        Current = .mock
        
        let rnc = RemoteNodeConnection.init(
            uri: lndURI,
            certificate: lndCertificate,
            macaroon: lndMacaroon
        )
        
        let mockRNC = Current.keychain.load()
        let mockCertificate = try? mockRNC.get().certificate
        let mockMacaroon = try? mockRNC.get().macaroon
        let mockURI = try? mockRNC.get().uri

        XCTAssertEqual(mockCertificate!, rnc.certificate)
        XCTAssertEqual(mockMacaroon!, rnc.macaroon)
        XCTAssertEqual(mockURI!, rnc.uri)

        assertSnapshot(matching: mockCertificate!, as: .dump)
        assertSnapshot(matching: rnc.certificate, as: .dump)
        assertSnapshot(matching: mockMacaroon!, as: .dump)
        assertSnapshot(matching: rnc.macaroon, as: .dump)
        assertSnapshot(matching: mockURI!, as: .dump)
        assertSnapshot(matching: rnc.uri, as: .dump)
    }
    
    func testLoadFailure() {
        Current = .test
        
        let mockRNC = Current.keychain.load()
        
        XCTAssertEqual(mockRNC.error?.localizedDescription, DataError.noSavedData.localizedDescription)
        assertSnapshot(matching: mockRNC, as: .dump)
        assertSnapshot(matching: mockRNC.error?.localizedDescription, as: .dump)
    }
    
    func testLoadFromKeychain() {
        
        let mockRNC = loadFromKeychain()
        
        assertSnapshot(matching: mockRNC, as: .dump)
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
        
        XCTAssertEqual(mockSave!, "Success")
        assertSnapshot(matching: mockSave!, as: .dump)
        assertSnapshot(matching: mockRNC, as: .dump)
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
        assertSnapshot(matching: mockRNC, as: .dump)
        assertSnapshot(matching: mockRNC.error?.localizedDescription, as: .dump)
    }
    
    func testSaveToKeychain() {
        
        let rnc = RemoteNodeConnection.init(
            uri: lndURI,
            certificate: lndCertificate,
            macaroon: lndMacaroon
        )
        
        let mockRNC = saveToKeychain(remoteNodeConnection: rnc)
        let mockSave = try? mockRNC.get()
        
        XCTAssertEqual(mockSave!, "Saved Value to Defaults")
        assertSnapshot(matching: mockSave!, as: .dump)
        assertSnapshot(matching: mockRNC, as: .dump)
    }
    
    func testDeleteSuccess() {
        Current = .mock
        
        let mockRNC = Current.keychain.delete
        assertSnapshot(matching: mockRNC, as: .dump)
    }
    
    func testDeleteFailure() {
        Current = .test
        
        let mockRNC = Current.keychain.delete
        assertSnapshot(matching: mockRNC, as: .dump)
    }
    
    func testDeleteFromKeychain() {
        
        let mockRNC = deleteFromKeychain()
        
        assertSnapshot(matching: mockRNC, as: .dump)
    }
    
}
