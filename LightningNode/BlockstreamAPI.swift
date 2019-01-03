//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation

enum BlockstreamAPITestnet: String {
    case height = "https://blockstream.info/testnet/api/blocks/tip/height"
}

enum BlockstreamAPIMainnet: String {
    case height = "https://blockstream.info/api/blocks/tip/height"
}

func blockstreamAPIRequest(testnet: Bool, completion: @escaping (Result<String>) -> Void) {
    
    var request = URLRequest(url: URL(string: BlockstreamAPITestnet.height.rawValue)!)
    
    switch testnet {
    case true:
        request = URLRequest(url: URL(string: BlockstreamAPITestnet.height.rawValue)!)
    case false:
        request = URLRequest(url: URL(string: BlockstreamAPIMainnet.height.rawValue)!)
    }
    
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(
        with: request,
        completionHandler: { data, response, error in
            
            if let data = data {
                let str = String(data: data, encoding: .utf8)
                if let height = str {
                    completion(Result.success(height))
                } else {
                    completion(Result.failure(error!))
                }
            } else {
                return completion(Result.failure(error!))
            }
            
    }).resume()
    
}
