//
//  BlockstreamAPITests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 2/16/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import LightningNode

class BlockstreamAPITests: XCTestCase {
    
    func testBlockstreamAPITestnet() {
        
        let testExpectation = expectation(description: "https://blockstream.info/testnet/api/blocks/tip/height")

        blockstreamAPIRequest(testnet: true) { (result) in
            switch result {
            case let .success(height):
                XCTAssertGreaterThan(height, "0")
            case let .failure(error):
                XCTAssertThrowsError(error)
            }
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: .none)
        
    }
    
    func testBlockstreamAPITestnetSnapshot() {
        
        let testExpectation = expectation(description: "https://blockstream.info/testnet/api/blocks/tip/height")
        
        blockstreamAPIRequest(testnet: true) { (result) in
            switch result {
            case let .success(height):
                assertSnapshot(matching: height, as: .dump)
            case let .failure(error):
                XCTAssertThrowsError(error)
            }
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: .none)
        
    }
    
    func testBlockstreamAPIMainnet() {
        
        let testExpectation = expectation(description: "https://blockstream.info/api/blocks/tip/height")
        
        blockstreamAPIRequest(testnet: false) { (result) in
            switch result {
            case let .success(height):
                XCTAssertGreaterThan(height, "0")
            case let .failure(error):
                XCTAssertThrowsError(error)
            }
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: .none)
        
    }
    
    func testBlockstreamAPIMainnetSnapshot() {
        
        let testExpectation = expectation(description: "https://blockstream.info/api/blocks/tip/height")
        
        blockstreamAPIRequest(testnet: false) { (result) in
            switch result {
            case let .success(height):
                assertSnapshot(matching: height, as: .dump)
            case let .failure(error):
                XCTAssertThrowsError(error)
            }
            testExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: .none)
        
    }

}
