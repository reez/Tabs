//
//  RemoteNodeConnectionTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 5/16/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
@testable import LightningNode
import SnapshotTesting

class RemoteNodeConnectionTests: XCTestCase {

    func testPEM() {
        let pem = Pem(key: lndCertificate)
        assertSnapshot(matching: pem, as: .dump)
    }
    
    func testBase64String() {
        let str = "String"
        let base = str.base64UrlToBase64()
        
        XCTAssertEqual(base, "String==")
    }
    
    func testSeparateString() {
        let str = "String"
        let separate = str.separate(every: 3, with: "*")
        
        XCTAssertEqual(separate, "Str*ing")
    }
    
    func testQueryString() {
        let url = URL(string: "readableString")
        let query = url?.queryParameters
        
        XCTAssertEqual(query, nil)
    }
    
}
