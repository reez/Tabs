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
    let submitButtonPressed: Void
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

func addInvoiceViewModel(
    input: AddInvoiceViewModelInput,
    output: @escaping (AddInvoiceViewModelOutput) -> Void
    )
{
    var viewModelOutput = AddInvoiceViewModelOutput(
        alertErrorMessage: "Unexpected Error",
        alertNeeded: true,
        amountTextFieldOutput: "",
        copyButtonHidden: true,
        invoiceLabel: "",
        invoiceLabelHidden: true,
        memoTextFieldOutput: ""
    )
    
    if let value = Int(input.amountTextFieldInput) {
        let request = InvoiceRequest(memo: input.memoTextFieldInput, value: value)
            Current.lightningAPIRPC.addInvoice(request.value, request.memo) { result in
                switch result {
                case let .success(invoice):
                    viewModelOutput.invoiceLabelHidden = false
                    viewModelOutput.copyButtonHidden = false
                    viewModelOutput.invoiceLabel = invoice
                    viewModelOutput.amountTextFieldOutput = ""
                    viewModelOutput.memoTextFieldOutput = ""
                    viewModelOutput.alertNeeded = false
                    output(viewModelOutput)
                case let .failure(errorMessage):
                    viewModelOutput.alertNeeded = true
                    viewModelOutput.alertErrorMessage = errorMessage.localizedDescription
                    output(viewModelOutput)
                }
            }
    } else {
        viewModelOutput.alertNeeded = true
        viewModelOutput.alertErrorMessage = "Value for Invoice must be a number"
        output(viewModelOutput)
    }
    
}
