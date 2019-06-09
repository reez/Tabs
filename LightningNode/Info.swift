//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation
import LNDrpc

struct Info: Equatable {
    let alias: String
    let bestHeaderTimestamp: Date
    let blockHash: String
    let blockHeight: Int
    let chainsArray: String//NSMutableArray
    let identityPubkey: String
    let network: String
    let numActiveChannels: Int
    let numPeers: Int
    let numPendingChannels: Int
    let syncedToChain: Bool
//    let testnet: Bool
    let version: String
}

extension Info {
    init(getInfoResponse: GetInfoResponse) {
        alias = getInfoResponse.alias
        bestHeaderTimestamp = Date(timeIntervalSince1970: TimeInterval(getInfoResponse.bestHeaderTimestamp))
        blockHash = getInfoResponse.blockHash
        blockHeight = Int(getInfoResponse.blockHeight)
        if
            let chains = getInfoResponse.chainsArray as? [Chain],
            let chain = chains.first?.chain
        {
            chainsArray = chain
        } else {
            chainsArray = "No Chain Info" //getInfoResponse.testnet ? Network.testnet.rawValue : Network.mainnet.rawValue
        }
        identityPubkey = getInfoResponse.identityPubkey
        if
            let chains = getInfoResponse.chainsArray as? [Chain],
            let chainNetwork = chains.first?.network
        {
            network = chainNetwork
        } else {
            network = getInfoResponse.testnet ? Network.testnet.rawValue : Network.mainnet.rawValue
        }
        numActiveChannels = Int(getInfoResponse.numActiveChannels)
        numPeers = Int(getInfoResponse.numPeers)
        numPendingChannels = Int(getInfoResponse.numPendingChannels)
        syncedToChain = getInfoResponse.syncedToChain
//        testnet = getInfoResponse.testnet
        version = getInfoResponse.version
    }
}

public enum Network: String {
    case testnet = "testnet"
    case mainnet = "mainnet"
}
