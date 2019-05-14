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
    
    func testAddNodeViewModelInvalidMacaroon() {
        
        let input = AddNodeViewModelInputs(certificateTextFieldInput: lndCertificate, macaroonTextFieldInput: "badMacaroonFormat", uriTextFieldInput: lndURI)
        
        addNodeViewModel(input: input) { (outputs) in
            XCTAssertEqual(outputs.alertNeeded, true)
            XCTAssertEqual(outputs.alertErrorMessage, "Could not use format of Macaroon")
        }
        
    }
    
    func testAddNodeViewModelInvalidMacaroonSnapshot() {
        
        let input = AddNodeViewModelInputs(certificateTextFieldInput: lndCertificate, macaroonTextFieldInput: "badMacaroonFormat", uriTextFieldInput: lndURI)
        
        addNodeViewModel(input: input) { (outputs) in
            assertSnapshot(matching: outputs.alertNeeded, as: .dump)
            assertSnapshot(matching: outputs.alertErrorMessage, as: .dump)
        }
        
    }
    
    func testAddNodeViewModelValidMacaroon() {
        Current = .mock

        let input = AddNodeViewModelInputs(certificateTextFieldInput: lndCertificate, macaroonTextFieldInput: lndMacaroon, uriTextFieldInput: lndURI)
        
        addNodeViewModel(input: input) { (outputs) in
            XCTAssertEqual(outputs.alertNeeded, false)
            XCTAssertEqual(outputs.alertErrorMessage, "Unexpected Error")
        }
        
    }
    
    func testAddNodeViewModelValidMacaroonSnapshot() {
        
        let input = AddNodeViewModelInputs(certificateTextFieldInput: lndCertificate, macaroonTextFieldInput: lndMacaroon, uriTextFieldInput: lndURI)
        
        addNodeViewModel(input: input) { (outputs) in
            assertSnapshot(matching: outputs.alertNeeded, as: .dump)
            assertSnapshot(matching: outputs.alertErrorMessage, as: .dump)
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
    
    func testAddNodeViewModelValidRemoteNodeConnectionSnapshot() {
        
        Current = .mock
        
        let input = AddNodeViewModelInputs(certificateTextFieldInput: lndCertificate, macaroonTextFieldInput: lndMacaroon, uriTextFieldInput: lndURI)
        
        addNodeViewModel(input: input) { (outputs) in
            assertSnapshot(matching: outputs.alertNeeded, as: .dump)
            assertSnapshot(matching: outputs.alertErrorMessage, as: .dump)
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
    
    func testAddNodeViewModelValidRemoteNodeConnectionTestSnapshot() {
        
        Current = .test
        
        let input = AddNodeViewModelInputs(certificateTextFieldInput: lndCertificate, macaroonTextFieldInput: lndMacaroon, uriTextFieldInput: lndURI)
        
        addNodeViewModel(input: input) { (outputs) in
            assertSnapshot(matching: outputs.alertNeeded, as: .dump)
            assertSnapshot(matching: outputs.alertErrorMessage, as: .dump)
        }
        
    }
    
    func testAddNodeViewModelFailureRemoteNodeInfoMissingTestSnapshot() {
        
        Current = .test
        
        let input = AddInvoiceViewModelInput(amountTextFieldInput: "", memoTextFieldInput: "", submitButtonPressed: ())
        
        let output = AddInvoiceViewModelOutput(alertErrorMessage: "Remote Node Info Missing", alertNeeded: true, amountTextFieldOutput: "", copyButtonHidden: false, invoiceLabel: "", invoiceLabelHidden: false, memoTextFieldOutput: "")
        
        if input.memoTextFieldInput.isEmpty {
            XCTAssertEqual(output.alertErrorMessage, DataError.remoteNodeInfoMissing.localizedDescription)
        }
        
        
        
    }
    
}
