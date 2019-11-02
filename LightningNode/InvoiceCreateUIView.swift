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
            
            if self.showInvoice {
                Text(verbatim: self.state.newInvoice)
                
                Button("Copy Invoice") {
                    withAnimation(.easeOut) {
                        self.showInvoice.toggle()
                        self.memo = ""
                        self.value = ""
                    }
                }
                
            }
            
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
