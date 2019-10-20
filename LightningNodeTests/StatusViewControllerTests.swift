//
//  StatusViewControllerTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 10/20/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import LightningNode

class StatusViewControllerTests: XCTestCase {

    func testStatusViewController() {
        let vc = StatusViewController()
        vc.viewDidLoad()
        vc.viewDidAppear(true)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr(.portrait)))
    }

}
