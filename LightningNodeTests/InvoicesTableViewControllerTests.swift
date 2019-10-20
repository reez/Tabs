//
//  InvoicesTableViewControllerTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 10/20/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import LightningNode

class InvoicesTableViewControllerTests: XCTestCase {

    func testInvoicesTableViewController() {
        let vc = InvoicesTableViewController()
        vc.viewDidLoad()
        vc.viewDidAppear(true)
        
        assertSnapshot(matching: vc, as: .image(on: .iPhoneXr(.portrait)))
    }

}
