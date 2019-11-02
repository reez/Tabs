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
    // assuming `name` is unique, it can be used as our identifier
    public var id: String { self.paymentRequest }
}

struct InvoiceListUIView: View {
    @State var showAlert = false
    @ObservedObject var state = InvoiceListAppState()
    
    let bodyText = """
    🌩
    Check out your Lightning Invoices
    - or -
    Add a new Lightning Invoice
    """
    
    func loadInvoices(){
        invoices { (result) in // [weak self]
            switch result {
            case let .success(invoices):
                self.state.invoices = invoices
                print(invoices)
                //                self?.tableView.reloadData()
            //                self?.tableView.refreshControl?.endRefreshing()
            case .failure(_):
                print("list fail")
                //                self?.tableView.refreshControl?.endRefreshing()
            }
        }
        
    }
    
    var body: some View {
        
        VStack {
            
            Text(bodyText)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Add an Invoice") {
                //                self.store.send(.showAddInvoice)
                self.showAlert = true
            }
            .padding()
            .foregroundColor(.blue)
            .padding()
            .sheet(isPresented: $showAlert, onDismiss: {
                print("Dismissed")
                self.showAlert = false
                
            }) {
                InvoiceCreateUIView()
            }
            
            List {
                ForEach(self.state.invoices) { invoice in
                    HStack {
                        Text("\(invoice.memo)")
                        Text("|")
                        Text("\(invoice.value)")
                    }
                    
                }
            }
            .padding()
            
        }.onAppear {
            print("appear")
            self.loadInvoices()
            
        }
        
    }
}

struct InvoiceListUIView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceListUIView()
    }
}
