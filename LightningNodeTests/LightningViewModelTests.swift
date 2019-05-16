//
//  LightningViewModelTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 2/16/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import LightningNode

class LightningViewModelTests: XCTestCase {

    func testLightningViewModel() {
        Current = .mock
        
        var viewModel: LightningViewModel!
        let testExpectation = expectation(description: "/getinfo")
        
        viewModel = LightningViewModel { _ in }
        testExpectation.fulfill()
        waitForExpectations(timeout: 10, handler: .none)
        
        XCTAssertEqual(viewModel.lightningNodeInfo, Info.mock)
        assertSnapshot(matching: viewModel.lightningNodeInfo, as: .dump)
        assertSnapshot(matching: Info.mock, as: .dump)
    }
    
    func testLightningViewModelTest() {
        Current = .test
        
        var viewModel: LightningViewModel!
        let testExpectation = expectation(description: "/getinfo")
        
        viewModel = LightningViewModel { _ in }
        testExpectation.fulfill()
        waitForExpectations(timeout: 10, handler: .none)
        
        XCTAssertEqual(viewModel.lightningNodeInfo, Info.mock)
        assertSnapshot(matching: viewModel.lightningNodeInfo, as: .dump)
        assertSnapshot(matching: Info.mock, as: .dump)
    }
    
    func testInfoInitMock() {
        Current = .mock
        
        let vm = LightningViewModel { info in
            XCTAssertEqual(info, Info.mock)
        }

        assertSnapshot(matching: vm, as: .dump)
    }
    
    func testInfoInitTest() {
        Current = .test
        
        let vm = LightningViewModel { (info) in
            XCTAssertEqual(info, Info.mock)
        }
        
        assertSnapshot(matching: vm, as: .dump)
    }
    
    func testLightningAPIRPCAddInvoiceSuccess() {
        Current = .mock
        
        Current.lightningAPIRPC.addInvoice(2, "memo") { result in
            switch result {
            case let .success(value):
                XCTAssertEqual(value, "mockInvoice")
                assertSnapshot(matching: value, as: .dump)
            case let .failure(error):
                XCTAssertEqual(error, DataError.invoiceFailure)
                assertSnapshot(matching: error, as: .dump)
            }
        }
        
    }
    
    func testLightningAPIRPCAddInvoiceFailure() {
        Current = .test
        
        Current.lightningAPIRPC.addInvoice(2, "memo") { result in
            switch result {
            case let .success(value):
                XCTAssertEqual(value, "mockInvoice")
                assertSnapshot(matching: value, as: .dump)
            case let .failure(error):
                XCTAssertEqual(error, DataError.invoiceFailure)
                assertSnapshot(matching: error, as: .dump)
            }
        }
        
    }
    
    func testLightningAPIRPCCanConnectSuccess() {
        Current = .mock
        
        Current.lightningAPIRPC.canConnect { bool in
            XCTAssertTrue(bool, "True")
        }
        
    }
    
    func testLightningAPIRPCCanConnectFailure() {
        Current = .test
        
        Current.lightningAPIRPC.canConnect { bool in
            XCTAssertFalse(bool, "False")
        }
        
    }
    
    func testLightningAPIRPCInfoSuccess() {
        Current = .mock
        
        Current.lightningAPIRPC.info { result in
            switch result {
            case let .success(value):
                XCTAssertEqual(value.blockHeight, 0)
            case let .failure(error):
                XCTAssertEqual(error, DataError.fetchInfoFailure)
            }
        }
        
    }
    
    func testLightningAPIRPCInfoFailure() {
        Current = .test
        
        Current.lightningAPIRPC.info { result in
            switch result {
            case let .success(value):
                XCTAssertEqual(value.blockHeight, 1)
            case let .failure(error):
                XCTAssertEqual(error, DataError.noSavedData)
            }
        }
        
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
