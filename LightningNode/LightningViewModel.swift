//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation

final class LightningViewModel {
    
    var lightningNodeInfo = Info.init(
        alias: "No alias",
        bestHeaderTimestamp: Current.date(),
        blockHash: "No blockHash",
        blockHeight: 0,
        chainsArray: "No chainz",
        identityPubkey: "No identityPubkey",
        network: "Testnetwork",
        numActiveChannels: 0,
        numPeers: 0,
        numPendingChannels: 0,
        syncedToChain: false,
        version: "No version")
    
    var callback: ((Info) -> Void)
    
    init(callback: @escaping (Info) -> Void) {
        self.callback = callback
        self.callback(lightningNodeInfo)
    }
    
}
