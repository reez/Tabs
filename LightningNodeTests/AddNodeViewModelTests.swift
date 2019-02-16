//
//  AddNodeViewModelTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 2/15/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
@testable import LightningNode

class AddNodeViewModelTests: XCTestCase {
    
    func testAddNodeViewModelInvalidMacaroon() {
        
        let input = AddNodeViewModelInputs(certificateTextFieldInput: lndCertificate, macaroonTextFieldInput: "badMacaroonFormat", uriTextFieldInput: lndURI)
        
        addNodeViewModel(input: input) { (outputs) in
            XCTAssertEqual(outputs.alertNeeded, true)
            XCTAssertEqual(outputs.alertErrorMessage, "Could not use format of Macaroon")
        }
        
    }
    
    func testAddNodeViewModelValidMacaroon() {
        
        let input = AddNodeViewModelInputs(certificateTextFieldInput: lndCertificate, macaroonTextFieldInput: lndMacaroon, uriTextFieldInput: lndURI)
        
        addNodeViewModel(input: input) { (outputs) in
            XCTAssertEqual(outputs.alertNeeded, false)
            XCTAssertEqual(outputs.alertErrorMessage, "Unexpected Error")
        }
        
    }
    
    func testAddNodeViewModelValidRemoteNodeConnection() {
        
        Current = .mock

        let input = AddNodeViewModelInputs(certificateTextFieldInput: lndCertificate, macaroonTextFieldInput: lndMacaroon, uriTextFieldInput: lndURI)
        
        addNodeViewModel(input: input) { (outputs) in
            XCTAssertEqual(outputs.alertNeeded, false)
            XCTAssertEqual(outputs.alertErrorMessage, "Unexpected Error")
        }
        
    }
    
    func testAddNodeViewModelValidRemoteNodeConnectionTest() {
        
        Current = .test
        
        let input = AddNodeViewModelInputs(certificateTextFieldInput: lndCertificate, macaroonTextFieldInput: lndMacaroon, uriTextFieldInput: lndURI)
        
        addNodeViewModel(input: input) { (outputs) in
            XCTAssertEqual(outputs.alertNeeded, true)
            XCTAssertEqual(outputs.alertErrorMessage, "Encoding Failure")
        }
        
    }
    
}
