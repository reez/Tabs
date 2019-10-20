//
//  TabBarViewControllerTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 10/20/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import LightningNode

class TabBarViewControllerTests: XCTestCase {

    func testTabBarViewController() {
        let vc = TabBarViewController()
        vc.viewDidLoad()
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr(.portrait)))
    }

}
