//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation
import LNDrpc

struct LightningApiRPC {
    var addInvoice = addInvoice(value: memo: completion:)
    var canConnect = canConnect(completion:)
    var info = info(completion:)
}

func addInvoice(value: Int, memo: String, completion: @escaping (Result<String, DataError>) -> Void) {
    guard let rnc = Current.remoteNodeConnectionFormatted else { return }
    let host = rnc.uri
    let lnd = Lightning(host: host)

    try? GRPCCall.setTLSPEMRootCerts(rnc.certificate, forHost: host)

    let invoice = Invoice(value: value, memo: memo)
    
    lnd.rpcToAddInvoice(withRequest: invoice) { (response, _) in
        response?.paymentRequest.flatMap {
            completion(Result.success($0))
        }
        }.runWithMacaroon(rnc.macaroon)
}

func invoices(completion: @escaping (Result<[Invoice], DataError>) -> Void) {
    guard let rnc = Current.remoteNodeConnectionFormatted else { return }
    let host = rnc.uri
    let lnd = Lightning(host: host)
    
    try? GRPCCall.setTLSPEMRootCerts(rnc.certificate, forHost: host)
    
    let invoices = ListInvoiceRequest()

    lnd.rpcToListInvoices(with: invoices) { (response, _) in
        // does this need to be compactmap?
        response?.invoicesArray.flatMap {
            let invoice = $0 as? [Invoice]
            guard let invoiceArray = invoice else { return }
            completion(Result.success(invoiceArray))
        }
        }.runWithMacaroon(rnc.macaroon)

}

func canConnect(completion: @escaping (Bool) -> Void) {
    guard let rnc = Current.remoteNodeConnectionFormatted else { return }
    let host = rnc.uri
    let lnd = Lightning(host: host)

    try? GRPCCall.setTLSPEMRootCerts(rnc.certificate, forHost: host)

    lnd.rpcToGetInfo(with: GetInfoRequest()) { (response, _) in
        completion(response != nil)
        }.runWithMacaroon(rnc.macaroon)
}

func info(completion: @escaping (Result<Info, DataError>) -> Void) {
    guard let rnc = Current.remoteNodeConnectionFormatted else { return }
    let host = rnc.uri
    let lnd = Lightning(host: host)

    try? GRPCCall.setTLSPEMRootCerts(rnc.certificate, forHost: host)

    lnd.rpcToGetInfo(with: GetInfoRequest()) { (response, _) in
        _ = response.flatMap {
            let info = Info.init(getInfoResponse: $0)
            completion(Result.success(info))
        }
        }.runWithMacaroon(rnc.macaroon)
}

extension GRPCProtoCall {
    func runWithMacaroon(_ macaroon: String) {
        requestHeaders["macaroon"] = macaroon
        start()
    }
}
