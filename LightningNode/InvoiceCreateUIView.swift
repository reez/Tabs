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
                .font(.system(.subheadline, design: .monospaced))
                .border(Color.blue)
            
            TextField("Value", text: $value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .multilineTextAlignment(.leading)
                .font(.system(.subheadline, design: .monospaced))
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
                        self.newInvoice = output.invoiceLabel
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
                    }
                    
                }
                
            }
            .font(.system(.headline, design: Font.Design.monospaced))
            .padding()
            
            Group {
                Text(verbatim: self.newInvoice)
                    .font(.system(.caption, design: .monospaced))
                    .opacity(self.showInvoice ? 1 : 0)
                    .padding()
                
                Button("Copy Invoice") {
                    UIPasteboard.general.string = self.newInvoice
                    self.showCopy = false
                    self.showInvoice = false
                    self.memo = ""
                    self.value = ""
                }
                .opacity(self.showCopy ? 1 : 0)
                .font(.system(.headline, design: Font.Design.monospaced))
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
