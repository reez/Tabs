//
//  LightningAPITests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 5/16/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import LightningNode

class LightningAPITests: XCTestCase {

    func testAddInvoiceSuccess() {
        Current = .mock
        
        Current.lightningAPIRPC.addInvoice(2, "memo") { result in
            switch result {
            case let .success(value):
                XCTAssertEqual(value, "mockInvoice")
                assertSnapshot(matching: value, as: .dump)
            case .failure(_):
                XCTFail("Success != Failure")
            }
        }
        
    }
    
    func testAddInvoiceFailure() {
        Current = .test
        
        Current.lightningAPIRPC.addInvoice(2, "memo") { result in
            switch result {
            case .success(_):
                XCTFail("Failure != Success")
            case let .failure(error):
                XCTAssertEqual(error, DataError.invoiceFailure)
                assertSnapshot(matching: error, as: .dump)
            }
        }
        
    }
    
    func testCanConnectSuccess() {
        Current = .mock
        
        Current.lightningAPIRPC.canConnect { bool in
            XCTAssertTrue(bool, "True")
        }
        
    }
    
    func testCanConnectFailure() {
        Current = .test
        
        Current.lightningAPIRPC.canConnect { bool in
            XCTAssertFalse(bool, "False")
        }
        
    }
    
    func testInfoSuccess() {
        Current = .mock
        
        Current.lightningAPIRPC.info { result in
            switch result {
            case let .success(value):
                XCTAssertEqual(value.blockHeight, 0)
            case .failure(_):
                XCTFail("Success != Failure")
            }
        }
        
    }
    
    func testInfoFailure() {
        Current = .test
        
        Current.lightningAPIRPC.info { result in
            switch result {
            case .success(_):
                XCTFail("Failure != Success")
            case let .failure(error):
                XCTAssertEqual(error, DataError.noSavedData)
            }
        }
        
    }

}
