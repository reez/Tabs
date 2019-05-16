//
//  AddNodeViewModelTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 2/15/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import LightningNode

class AddNodeViewModelTests: XCTestCase {
    
    func testInvalidMacaroon() {
        
        Current = .mock

        let input = AddNodeViewModelInputs(certificateTextFieldInput: lndCertificate, macaroonTextFieldInput: "badMacaroonFormat", uriTextFieldInput: lndURI)
        
        addNodeViewModel(input: input) { (outputs) in
            XCTAssertEqual(outputs.alertNeeded, true)
            XCTAssertEqual(outputs.alertErrorMessage, "Could not use format of Macaroon")
            assertSnapshot(matching: outputs.alertNeeded, as: .dump)
            assertSnapshot(matching: outputs.alertErrorMessage, as: .dump)
        }
        
    }
    
    func testValidMacaroon() {
        
        Current = .mock
        
        let input = AddNodeViewModelInputs(certificateTextFieldInput: lndCertificate, macaroonTextFieldInput: lndMacaroon, uriTextFieldInput: lndURI)
        
        addNodeViewModel(input: input) { (outputs) in
            XCTAssertEqual(outputs.alertNeeded, false)
            XCTAssertEqual(outputs.alertErrorMessage, "Unexpected Error")
            assertSnapshot(matching: outputs.alertNeeded, as: .dump)
            assertSnapshot(matching: outputs.alertErrorMessage, as: .dump)
        }
        
    }
    
    func testResultSavedSuccess() {
        
        Current = .mock
        
        let input = AddNodeViewModelInputs(certificateTextFieldInput: lndCertificate, macaroonTextFieldInput: lndMacaroon, uriTextFieldInput: lndURI)
        
        addNodeViewModel(input: input) { (outputs) in
            XCTAssertEqual(outputs.alertNeeded, false)
            XCTAssertEqual(outputs.alertErrorMessage, "Unexpected Error")
            assertSnapshot(matching: outputs.alertNeeded, as: .dump)
            assertSnapshot(matching: outputs.alertErrorMessage, as: .dump)
        }
        
    }

    
    func testResultSavedFailure() {
        
        Current = .test
        
        let input = AddNodeViewModelInputs(certificateTextFieldInput: lndCertificate, macaroonTextFieldInput: lndMacaroon, uriTextFieldInput: lndURI)
        
        addNodeViewModel(input: input) { (outputs) in
            XCTAssertEqual(outputs.alertNeeded, true)
            XCTAssertEqual(outputs.alertErrorMessage, "Encoding Failure")
            assertSnapshot(matching: outputs.alertNeeded, as: .dump)
            assertSnapshot(matching: outputs.alertErrorMessage, as: .dump)
        }

    }
    
}
