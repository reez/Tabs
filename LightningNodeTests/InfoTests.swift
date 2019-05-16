//
//  InfoTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 5/16/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import LightningNode

class InfoTests: XCTestCase {

    func testInfoInit() {
        Current = .mock
        
        let vm = LightningViewModel { info in
            XCTAssertEqual(info, Info.mock)
        }
        
        assertSnapshot(matching: vm, as: .dump)
    }

}
