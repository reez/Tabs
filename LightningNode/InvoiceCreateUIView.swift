//
//  InvoiceCreateUIView.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 11/2/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import SwiftUI

class InvoiceCreateAppState: ObservableObject {
    @Published var newInvoice: String = ""
}

struct InvoiceCreateUIView: View {
    @ObservedObject var state = InvoiceCreateAppState()
    @State var memo: String = ""
    @State var value: String = ""
    @State var showInvoice = false
    
    var body: some View {
        
        VStack {
            
            TextField("Memo", text: $memo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.leading)
            
            TextField("Value", text: $value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.leading)
                .font(.callout)
            
            Button("Add Invoice") {
                self.showInvoice = true
                
                let input = AddInvoiceViewModelInput(
                    amountTextFieldInput: self.value,
                    memoTextFieldInput: self.memo,
                    submitButtonPressed: ()
                )
                
                addInvoiceViewModel(input: input) { (output) in
                    self.state.newInvoice = output.invoiceLabel
                }
                
            }
            .padding()
            
            Text(verbatim: self.state.newInvoice)
                .font(.caption)
                .opacity(self.showInvoice ? 1 : 0) // This works opposite of hwo I'd think based on bool
            
            Button("Copy Invoice") {
                self.showInvoice = false
                self.memo = ""
                self.value = ""
                UIPasteboard.general.string = self.state.newInvoice
            }
                .opacity(self.showInvoice ? 1 : 0) // This works opposite of hwo I'd think based on bool
            
            Spacer()
            
        }
        .multilineTextAlignment(.center)
        .padding()
        
    }
    
}

struct InvoiceCreateUIView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceCreateUIView()
    }
}
