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
//    @ObservedObject var state = InvoiceCreateAppState()
    @State var memo: String = ""
    @State var value: String = ""
    @State var showInvoice = false
    @State var showCopy = false
    @State var inv = ""

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
                self.showCopy = true
                
                let input = AddInvoiceViewModelInput(
                    amountTextFieldInput: self.value,
                    memoTextFieldInput: self.memo,
                    submitButtonPressed: ()
                )
                
                addInvoiceViewModel(input: input) { (output) in
                    
                    if !output.alertNeeded {
                        print("self before: \(self.inv)")
                        self.inv = output.invoiceLabel //self.state.newInvoice
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                        print("self after: \(self.inv)")

                    }
                    
                }
                
            }
            .padding()
            
            Text(verbatim: self.inv)
                .font(.caption)
                .opacity(self.showInvoice ? 1 : 0)
            
            
            
            Button("Copy Invoice") {
                self.showCopy = false
                self.memo = ""
                self.value = ""
                //  UIPasteboard.general.string = self.state.newInvoice
            }
                .opacity(self.showCopy ? 1 : 0)
            
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
