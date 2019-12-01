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

struct InvoiceListUIView: View {
    @State var showAlert = false
    @ObservedObject var state = InvoiceListAppState()
    
    var body: some View {
        
        VStack {
            
            Text(Constants.listInvoicesBodyText.rawValue)
                .multilineTextAlignment(.center)
                .font(Font.largeTitle.smallCaps())
                .padding()
            
            Button(Constants.addInvoiceButton.rawValue) { self.showAlert = true }
                .padding()
                .foregroundColor(.blue)
                .font(.system(.headline, design: Font.Design.monospaced))
                .padding()
                .sheet(isPresented: $showAlert, onDismiss: { self.showAlert = false}) { InvoiceCreateUIView() }
            
            List {
                VStack {
                    InvoiceRow(invoices: self.state.invoices)
                }
            }
            .padding()
            
        }
        .onAppear {
            self.loadInvoices()
            
            NotificationCenter.default.addObserver(
                forName: NSNotification.Name(rawValue: "load"),
                object: nil,
                queue: nil
            ) { notification in
                if notification.name.rawValue == "load" {
                    self.loadInvoices()
                }
            }
            
        }
        
    }
}

extension Invoice: Identifiable {
    // might need to change this from paymentRequest later
    public var id: String { self.paymentRequest }
    //    private var id: Int
}

struct InvoiceRow: View {
    var invoices: [Invoice]
    
    var body: some View {
        
        ForEach(invoices.reversed()) { invoice in
            
            VStack(alignment: .leading) {
                
                Text(self.invoiceToString(invoice))
                    .font(.system(.caption, design: .monospaced))
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                
                Text("\(invoice.memo)")
                    .font(.system(.headline, design: .monospaced))
                
                HStack {
                    
                    Image(systemName: Constants.lightningImage.rawValue)
                        .foregroundColor(Color(.mr_gold))
                        .font(Font.subheadline.weight(.ultraLight))
                    
                    Text("\(invoice.value)")
                        .font(.system(.subheadline, design: .monospaced))
                    
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                
            }
            
        }
        
    }
}


extension InvoiceRow {
    func invoiceToString(_ invoice: Invoice) -> String {
        let creationDate = invoice.creationDate
        let cDDouble = Double(creationDate)
        let dr = Date(timeIntervalSince1970: cDDouble)
        let formattedDate = mrDateFormatter.string(from: dr)
        let invoiceState = InvoiceState(state: invoice.state).invoiceState
        return "Creation date: \(formattedDate) • Invoice state: \(invoiceState)"
    }
}

extension InvoiceListUIView {
    
    func loadInvoices(){
        invoices { (result) in
            switch result {
            case let .success(invoices):
                self.state.invoices = invoices
            case .failure(_):
                break
            }
        }
    }
}

struct InvoiceListUIView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceListUIView()
    }
}
