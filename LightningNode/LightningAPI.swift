//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation
import LNDrpc

final class LightningApiRPC {
    private let lnd: Lightning
    private let macaroon: String
    
    init(configuration: RemoteNodeConnection) {
        let host = configuration.uri
        lnd = Lightning(host: host)
        try? GRPCCall.setTLSPEMRootCerts(configuration.certificate, forHost: host)
        macaroon = configuration.macaroon
    }
    
    func addInvoice(value: Int, memo: String, completion: @escaping (Result<String>) -> Void) {
        let invoice = Invoice(value: value, memo: memo)
        lnd.rpcToAddInvoice(withRequest: invoice) { (response, _) in
            response?.paymentRequest.flatMap {
                completion(Result.success($0))
            }
            }.runWithMacaroon(macaroon)
    }
    
    func canConnect(completion: @escaping (Bool) -> Void) {
        lnd.rpcToGetInfo(with: GetInfoRequest()) { (response, _) in
            completion(response != nil)
            }.runWithMacaroon(macaroon)
    }
    
    func info(completion: @escaping (Result<Info>) -> Void) {
        lnd.rpcToGetInfo(with: GetInfoRequest()) { (response, _) in
            _ = response.flatMap {
                let info = Info.init(getInfoResponse: $0)
                completion(Result.success(info))
            }
            }.runWithMacaroon(macaroon)
    }
    
}

extension PayReqString {
    convenience init(payReq: String) {
        self.init()
        self.payReq = payReq
    }
}

extension GRPCProtoCall {
    func runWithMacaroon(_ macaroon: String) {
        requestHeaders["macaroon"] = macaroon
        start()
    }
}
