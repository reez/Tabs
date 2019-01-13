//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation

enum DataError: Error {
    case encodingFailure
    case fetchInfoFailure
    case invoiceInfoMissing
    case macaroonFormatting
    case noRemoteData
    case noSavedData
    case remoteNodeInfoMissing
}

extension DataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .encodingFailure:
            return NSLocalizedString("Encoding Failure", comment: "Failed to encode data and save")
        case .fetchInfoFailure:
            return NSLocalizedString("Fetch Info Failure", comment: "Received failure when fetching data")
        case .invoiceInfoMissing:
            return NSLocalizedString("Invoice Info Missing", comment: "Could not submit, missing Invoice data")
        case .macaroonFormatting:
            return NSLocalizedString("Macaroon failure", comment: "Could not format Macaroon")
        case .noRemoteData:
            return NSLocalizedString("No Remote Data", comment: "Could not get remote Node data")
        case .noSavedData:
            return NSLocalizedString("No Saved Data", comment: "Could not get saved Node data")
        case .remoteNodeInfoMissing:
            return NSLocalizedString("Remote Node Info Missing", comment: "Incorrect Remote Info")
        }
    }
}
