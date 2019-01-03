//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation
import LNDrpc

struct Info {
    let alias: String
    let bestHeaderTimestamp: Date
    let blockHash: String
    let blockHeight: Int
    let chainsArray: NSMutableArray
    let identityPubkey: String
    let numActiveChannels: Int
    let numPeers: Int
    let numPendingChannels: Int
    let syncedToChain: Bool
    let testnet: Bool
    let urisArray: [URL]
    let version: String
}

extension Info {
    init(getInfoResponse: GetInfoResponse) {
        alias = getInfoResponse.alias
        bestHeaderTimestamp = Date(timeIntervalSince1970: TimeInterval(getInfoResponse.bestHeaderTimestamp))
        blockHash = getInfoResponse.blockHash
        blockHeight = Int(getInfoResponse.blockHeight)
        chainsArray = getInfoResponse.chainsArray
        identityPubkey = getInfoResponse.identityPubkey
        numActiveChannels = Int(getInfoResponse.numActiveChannels)
        numPeers = Int(getInfoResponse.numPeers)
        numPendingChannels = Int(getInfoResponse.numPendingChannels)
        syncedToChain = getInfoResponse.syncedToChain
        testnet = getInfoResponse.testnet
        urisArray = getInfoResponse.urisArray.compactMap { URL(string: $0 as! String) }
        version = getInfoResponse.version
    }
}
