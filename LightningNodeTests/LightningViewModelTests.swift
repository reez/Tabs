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
      
}
