//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation
import LNDrpc

extension Invoice {
    convenience init(value: Int, memo: String) {
        self.init()
        self.memo = memo
        self.value = Int64(value)
    }
}

extension ListInvoiceRequest {
    convenience init(reversed: Bool) {
        self.init()
        self.reversed = reversed
    }
}

struct InvoiceRequest {
    let memo: String
    let value: Int
}

struct InvoiceState {
    let invoiceState: String
}

extension InvoiceState {
    init(state: Invoice_InvoiceState) {
        switch state {
        case .gpbUnrecognizedEnumeratorValue:
            invoiceState = "gpbUnrecognizedEnumeratorValue"
        case .open:
            invoiceState = "open"
        case .settled:
            invoiceState = "settled"
        case .canceled:
            invoiceState = "canceled"
        case .accepted:
            invoiceState = "accepted"
        @unknown default:
            invoiceState = "unknown"
        }
    }
}
