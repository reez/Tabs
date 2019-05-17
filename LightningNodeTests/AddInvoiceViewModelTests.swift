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
    
    func testAmountTextFieldInputFailure() {
        
        Current = .mock

        let input = AddInvoiceViewModelInput(amountTextFieldInput: "+", memoTextFieldInput: "memo", submitButtonPressed: ())
        
        addInvoiceViewModel(input: input) { (output) in
            XCTAssertEqual(output.alertErrorMessage, "Value for Invoice must be a number")
            XCTAssertEqual(output.alertNeeded, true)
            XCTAssertEqual(output.amountTextFieldOutput, "")
            XCTAssertEqual(output.copyButtonHidden, true)
            XCTAssertEqual(output.invoiceLabel, "")
            XCTAssertEqual(output.invoiceLabelHidden, true)
            XCTAssertEqual(output.memoTextFieldOutput, "")
            assertSnapshot(matching: output, as: .dump)
        }
        
    }
    
    func testAddInvoiceSuccess() {
        
        Current = .mock

        let input = AddInvoiceViewModelInput(amountTextFieldInput: "1", memoTextFieldInput: "success", submitButtonPressed: ())

        addInvoiceViewModel(input: input) { (output) in
            XCTAssertEqual(output.alertErrorMessage, "Unexpected Error")
            XCTAssertEqual(output.alertNeeded, false)
            XCTAssertEqual(output.amountTextFieldOutput, "")
            XCTAssertEqual(output.copyButtonHidden, false)
            XCTAssertEqual(output.invoiceLabel, "mockInvoice")
            XCTAssertEqual(output.invoiceLabelHidden, false)
            XCTAssertEqual(output.memoTextFieldOutput, "")
            assertSnapshot(matching: output, as: .dump)
        }
        
    }
    
    func testAddInvoiceFailure() {
        
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
            assertSnapshot(matching: output, as: .dump)
        }
        
    }
    
    func testInputInvoiceMemoMissingFailure() {
        
        Current = .test
        
        let input = AddInvoiceViewModelInput(amountTextFieldInput: "1", memoTextFieldInput: "", submitButtonPressed: ())
        
        let output = AddInvoiceViewModelOutput(alertErrorMessage: "Invoice Info Missing", alertNeeded: true, amountTextFieldOutput: "", copyButtonHidden: false, invoiceLabel: "", invoiceLabelHidden: false, memoTextFieldOutput: "")
        
        if input.memoTextFieldInput.isEmpty {
            XCTAssertEqual(output.alertErrorMessage, DataError.invoiceInfoMissing.localizedDescription)
        }
        
    }
    
    func testInputInvoiceAmountMissingFailure() {
        
        Current = .test
        
        let input = AddInvoiceViewModelInput(amountTextFieldInput: "", memoTextFieldInput: "memo", submitButtonPressed: ())
        
        let output = AddInvoiceViewModelOutput(alertErrorMessage: "Invoice Info Missing", alertNeeded: true, amountTextFieldOutput: "", copyButtonHidden: false, invoiceLabel: "", invoiceLabelHidden: false, memoTextFieldOutput: "")
        
        if input.memoTextFieldInput.isEmpty {
            XCTAssertEqual(output.alertErrorMessage, DataError.invoiceInfoMissing.localizedDescription)
        }
        
    }
    
    func testOutputFetchInfoFailure() {
        
        Current = .test
        
        let output = AddInvoiceViewModelOutput(alertErrorMessage: "Fetch Info Failure", alertNeeded: true, amountTextFieldOutput: "", copyButtonHidden: false, invoiceLabel: "", invoiceLabelHidden: false, memoTextFieldOutput: "")
        
        if output.alertNeeded {
            XCTAssertEqual(output.alertErrorMessage, DataError.fetchInfoFailure.localizedDescription)
        }
        
    }
    
}
