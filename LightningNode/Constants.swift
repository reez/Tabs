//
//  Constants.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 11/7/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation

enum Constants: String {
    
    case lightningImage = "bolt.circle"
    case xImage = "xmark.circle"
    case checkImage = "checkmark.circle"
    case addInvoiceButton = "Add an Invoice"
    case alias = "Alias"
    case pubkey = "Identity Pubkey"
    case tabsVersion = "(Tabs LND Target Version: 0.8.0)"
    case lndVersion = "LND Version:"
    case synced = "Synced"
    case notSynced = "Not Synced"
    
    
    case listInvoicesBodyText = """
    🌩
    Check out your Lightning Invoices
    - or -
    Add a new Lightning Invoice
    """
}
