//
//  BlockstreamAPITests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 2/16/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
@testable import LightningNode

class BlockstreamAPITests: XCTestCase {
    
    func testBlockstreamAPIRequestTestnet() {
        
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
    
    func testBlockstreamAPIRequestTestnetMainnet() {
        
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
    
    func testBlockstreamAPIRequestTestnetFailure() {
        
        let testExpectation = expectation(description: "")

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
    
    func testBlockstreamAPIRequestTestnetMainnetFailure() {
        
        let testExpectation = expectation(description: "")
        
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

}
