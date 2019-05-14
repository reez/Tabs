//
//  AddInvoiceViewModelTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 2/15/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
import SnapshotTesting
@testable import LightningNode

class AddInvoiceViewModelTests: XCTestCase {
    
    func testAddInvoiceViewModelIntegerSuccess() {
        let input = AddInvoiceViewModelInput(amountTextFieldInput: "+", memoTextFieldInput: "memo", submitButtonPressed: ())
        
        addInvoiceViewModel(input: input) { (output) in
            XCTAssertEqual(output.alertErrorMessage, "Value for Invoice must be a number")
            XCTAssertEqual(output.alertNeeded, true)
            XCTAssertEqual(output.amountTextFieldOutput, "")
            XCTAssertEqual(output.copyButtonHidden, true)
            XCTAssertEqual(output.invoiceLabel, "")
            XCTAssertEqual(output.invoiceLabelHidden, true)
            XCTAssertEqual(output.memoTextFieldOutput, "")
        }
        
    }
    
    func testAddInvoiceViewModelIntegerSuccessSnapshot() {
        let input = AddInvoiceViewModelInput(amountTextFieldInput: "+", memoTextFieldInput: "memo", submitButtonPressed: ())
        
        addInvoiceViewModel(input: input) { (output) in
            assertSnapshot(matching: output.alertErrorMessage, as: .dump)
            assertSnapshot(matching: output.alertNeeded, as: .dump)
            assertSnapshot(matching: output.amountTextFieldOutput, as: .dump)
            assertSnapshot(matching: output.copyButtonHidden, as: .dump)
            assertSnapshot(matching: output.invoiceLabel, as: .dump)
            assertSnapshot(matching: output.invoiceLabelHidden, as: .dump)
            assertSnapshot(matching: output.memoTextFieldOutput, as: .dump)
        }
        
    }
    
    func testAddInvoiceViewModelRemoteNodeConnectionSuccess() {
        
        Current = .mock

        let input = AddInvoiceViewModelInput(amountTextFieldInput: "1", memoTextFieldInput: "memo", submitButtonPressed: ())

        addInvoiceViewModel(input: input) { (output) in
            XCTAssertEqual(output.alertErrorMessage, "Unexpected Error")
            XCTAssertEqual(output.alertNeeded, false)
            XCTAssertEqual(output.amountTextFieldOutput, "")
            XCTAssertEqual(output.copyButtonHidden, false)
            XCTAssertEqual(output.invoiceLabel, "mockInvoice")
            XCTAssertEqual(output.invoiceLabelHidden, false)
            XCTAssertEqual(output.memoTextFieldOutput, "")
        }

    }
    
    func testAddInvoiceViewModelRemoteNodeConnectionSuccessSnapshot() {
        
        Current = .mock
        
        let input = AddInvoiceViewModelInput(amountTextFieldInput: "1", memoTextFieldInput: "memo", submitButtonPressed: ())
        
        addInvoiceViewModel(input: input) { (output) in
            assertSnapshot(matching: output.alertErrorMessage, as: .dump)
            assertSnapshot(matching: output.alertNeeded, as: .dump)
            assertSnapshot(matching: output.amountTextFieldOutput, as: .dump)
            assertSnapshot(matching: output.copyButtonHidden, as: .dump)
            assertSnapshot(matching: output.invoiceLabel, as: .dump)
            assertSnapshot(matching: output.invoiceLabelHidden, as: .dump)
            assertSnapshot(matching: output.memoTextFieldOutput, as: .dump)
        }
        
    }
    
    func testAddInvoiceViewModelSuccess() {
        
        Current = .mock

        let input = AddInvoiceViewModelInput(amountTextFieldInput: "1", memoTextFieldInput: "success", submitButtonPressed: ())

        addInvoiceViewModel(input: input) { (output) in
            XCTAssertEqual(output.copyButtonHidden, false)
            XCTAssertEqual(output.alertNeeded, false)
            XCTAssertEqual(output.amountTextFieldOutput, "")
            XCTAssertEqual(output.memoTextFieldOutput, "")
            XCTAssertEqual(output.invoiceLabel, "mockInvoice")
            XCTAssertEqual(output.invoiceLabelHidden, false)
        }
        
    }
    
    func testAddInvoiceViewModelSuccessSnapshot() {
        
        Current = .mock
        
        let input = AddInvoiceViewModelInput(amountTextFieldInput: "1", memoTextFieldInput: "success", submitButtonPressed: ())
        
        addInvoiceViewModel(input: input) { (output) in
            assertSnapshot(matching: output.alertErrorMessage, as: .dump)
            assertSnapshot(matching: output.alertNeeded, as: .dump)
            assertSnapshot(matching: output.amountTextFieldOutput, as: .dump)
            assertSnapshot(matching: output.copyButtonHidden, as: .dump)
            assertSnapshot(matching: output.invoiceLabel, as: .dump)
            assertSnapshot(matching: output.invoiceLabelHidden, as: .dump)
            assertSnapshot(matching: output.memoTextFieldOutput, as: .dump)
        }
        
    }
    
    func testAddInvoiceViewModelFailure() {
        Current = .test
        
        let input = AddInvoiceViewModelInput(amountTextFieldInput: "1", memoTextFieldInput: "failure", submitButtonPressed: ())
        
        addInvoiceViewModel(input: input) { (output) in
            XCTAssertEqual(output.copyButtonHidden, true)
            XCTAssertEqual(output.alertNeeded, true)
            XCTAssertEqual(output.alertErrorMessage, "Invoice Failure")
            XCTAssertEqual(output.amountTextFieldOutput, "")
            XCTAssertEqual(output.memoTextFieldOutput, "")
            XCTAssertEqual(output.invoiceLabel, "")
            XCTAssertEqual(output.invoiceLabelHidden, true)
        }
        
    }
    
    func testAddInvoiceViewModelFailureSnapshot() {
        Current = .test
        
        let input = AddInvoiceViewModelInput(amountTextFieldInput: "1", memoTextFieldInput: "failure", submitButtonPressed: ())
        
        addInvoiceViewModel(input: input) { (output) in
            assertSnapshot(matching: output.alertErrorMessage, as: .dump)
            assertSnapshot(matching: output.alertNeeded, as: .dump)
            assertSnapshot(matching: output.amountTextFieldOutput, as: .dump)
            assertSnapshot(matching: output.copyButtonHidden, as: .dump)
            assertSnapshot(matching: output.invoiceLabel, as: .dump)
            assertSnapshot(matching: output.invoiceLabelHidden, as: .dump)
            assertSnapshot(matching: output.memoTextFieldOutput, as: .dump)
        }
        
    }
    
    func testAddInvoiceViewModelOutputFetchInfoFailure() {
        Current = .test
        
        let output = AddInvoiceViewModelOutput(alertErrorMessage: "Fetch Info Failure", alertNeeded: true, amountTextFieldOutput: "", copyButtonHidden: false, invoiceLabel: "", invoiceLabelHidden: false, memoTextFieldOutput: "")
        
        if output.alertNeeded {
            XCTAssertEqual(output.alertErrorMessage, DataError.fetchInfoFailure.localizedDescription)
        }
        
    }
    
    func testAddInvoiceViewModelInputInvoiceInfoMissingFailure() {
        Current = .test
        
        let input = AddInvoiceViewModelInput(amountTextFieldInput: "1", memoTextFieldInput: "", submitButtonPressed: ())
        
        let output = AddInvoiceViewModelOutput(alertErrorMessage: "Invoice Info Missing", alertNeeded: true, amountTextFieldOutput: "", copyButtonHidden: false, invoiceLabel: "", invoiceLabelHidden: false, memoTextFieldOutput: "")
        
        if input.memoTextFieldInput.isEmpty {
            XCTAssertEqual(output.alertErrorMessage, DataError.invoiceInfoMissing.localizedDescription)
        }
        
    }
    
}
