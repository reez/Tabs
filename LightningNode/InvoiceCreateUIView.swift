//
//  InvoiceCreateUIView.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 11/2/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import SwiftUI

//class InvoiceCreateAppState: ObservableObject {
//    @Published var newInvoice: String = ""
//}

struct InvoiceCreateUIView: View {
    // If i use state newInvoice then invoicelabel updates and disappears
    // so need to use @State for now
    // @ObservedObject var state = InvoiceCreateAppState()
    @State var memo: String = ""
    @State var value: String = ""
    @State var showInvoice = false
    @State var showCopy = false
    @State var newInvoice = ""

    var body: some View {
        
        VStack {
            
            TextField("Memo", text: $memo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.leading)
                .border(Color.blue)

            TextField("Value", text: $value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.leading)
                .border(Color.blue)
            
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
                        print("self before: \(self.newInvoice)")
                        self.newInvoice = output.invoiceLabel //self.state.newInvoice
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                        print("self after: \(self.newInvoice)")
                    }
                    
                }
                
            }
            .padding()
            
            Group {
            Text(verbatim: self.newInvoice)//self.state.newInvoice
                .font(.caption)
                .opacity(self.showInvoice ? 1 : 0)
                .padding()
            
            Button("Copy Invoice") {
                self.showCopy = false
                self.showInvoice = false
                self.memo = ""
                self.value = ""
                UIPasteboard.general.string = self.newInvoice//self.state.newInvoice
            }
            .opacity(self.showCopy ? 1 : 0)
            .padding()
            }
            .animation(.interactiveSpring())
            
            Spacer()
            
        }
        .multilineTextAlignment(.center)
        .padding()
        
    }
    
}

struct InvoiceCreateUIView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceCreateUIView()
            .previewDevice(.some(PreviewDevice.init(stringLiteral: "iPhone 8")))
    }
}
