//
//  AddInvoiceViewModelTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 2/15/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
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
    
}
