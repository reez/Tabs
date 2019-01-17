//
//  AddInvoiceViewModel.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/17/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation

struct AddInvoiceViewModelInput {
    let amountTextFieldInput: String
    let memoTextFieldInput: String
}

struct AddInvoiceViewModelOutput {
    var alertErrorMessage: String
    var alertNeeded: Bool
    var amountTextFieldOutput: String
    var copyButtonHidden: Bool
    var invoiceLabel: String
    var invoiceLabelHidden: Bool
    var memoTextFieldOutput: String
}
