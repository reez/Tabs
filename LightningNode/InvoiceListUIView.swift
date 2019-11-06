//
//  InvoiceListUIView.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 11/2/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import SwiftUI
import LNDrpc

class InvoiceListAppState: ObservableObject {
    @Published var invoices = [Invoice]()
}

extension Invoice: Identifiable {
    // might need to change this from paymentRequest later
    public var id: String { self.paymentRequest }
    //    private var id: Int
}

let bodyText = """
🌩
Check out your Lightning Invoices
- or -
Add a new Lightning Invoice
"""

struct InvoiceListUIView: View {
    @State var showAlert = false
    @ObservedObject var state = InvoiceListAppState()
    
    var body: some View {
        
        VStack {
            
            Text(bodyText)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Add an Invoice") { self.showAlert = true }
                .padding()
                .foregroundColor(.blue)
                .padding()
                .sheet(
                    isPresented: $showAlert,
                    onDismiss: { self.showAlert = false})
                { InvoiceCreateUIView() }
            
            List {
                VStack(alignment: .leading) {
                    ForEach(self.state.invoices.reversed()) { invoice in
                        
                        Text(self.invoiceToString(invoice))
                            .font(.caption)
                        
                        Text("\(invoice.memo)")
                            .font(.headline)
                        
                        HStack {
                            Image(systemName: "bolt.circle")
                                .foregroundColor(Color(.mr_gold))
                            Text("\(invoice.value)")
                                .font(.subheadline)
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                        
                    }
                }
            }
            .padding()
            
        }
        .onAppear { self.loadInvoices() }
        // TODO: Need refresh right when comes back from creating invoice
        
    }
}

extension InvoiceListUIView {
    
    func invoiceToString(_ invoice: Invoice) -> String {
        let creationDate = invoice.creationDate
        let cDDouble = Double(creationDate)
        let dr = Date(timeIntervalSince1970: cDDouble)
        let formattedDate = mrDateFormatter.string(from: dr)
        let invoiceState = InvoiceState(state: invoice.state).invoiceState
        return "Creation date: \(formattedDate) • Invoice state: \(invoiceState)"
    }
    
    func loadInvoices(){
        invoices { (result) in
            switch result {
            case let .success(invoices):
                self.state.invoices = invoices
            case .failure(_):
                print("list fail")
            }
        }
    }
}

struct InvoiceListUIView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceListUIView()
    }
}
