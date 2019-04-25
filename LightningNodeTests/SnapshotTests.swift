
//
//  SnapshotTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 4/24/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import LightningNode

class SnapshotTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMyViewController() {
        let navigationIdentifier = Reusing<NodeCollectionViewController>().identifier()
        let storyboard = UIStoryboard(name: navigationIdentifier, bundle: Bundle(for: NodeCollectionViewController.self))
        let vc = storyboard.instantiateViewController(withIdentifier: navigationIdentifier)
        
        assertSnapshot(matching: vc, as: .image)
    }
    
    func testAddNodeViewModelInvalidMacaroon() {
        
        let input = AddNodeViewModelInputs(certificateTextFieldInput: lndCertificate, macaroonTextFieldInput: "badMacaroonFormat", uriTextFieldInput: lndURI)
        
        addNodeViewModel(input: input) { (outputs) in
            //XCTAssertEqual(outputs.alertNeeded, true)
            assertSnapshot(matching: outputs.alertNeeded, as: .dump)
            //XCTAssertEqual(outputs.alertErrorMessage, "Could not use format of Macaroon")
            assertSnapshot(matching: outputs.alertErrorMessage, as: .dump)
        }
        
    }

}
