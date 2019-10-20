//
//  AddNodeViewControllerTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 10/20/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import LightningNode

class AddNodeViewControllerTests: XCTestCase {
    
    func testAddNodeViewController() {
        let vc = AddNodeViewController()
        vc.viewDidLoad()
        vc.viewDidAppear(true)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr(.portrait)))
    }
    
}
