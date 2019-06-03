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

func blockstreamAPIRequest(testnet: Bool, completion: @escaping (Result<String, Error>) -> Void) {
    
    let main = BlockstreamAPIMainnet.height.rawValue
    let test = BlockstreamAPITestnet.height.rawValue
    
    let mainURL = URL(string: main)
    let testURL = URL(string: test)
    
    if let main = mainURL, let test = testURL {
        
        var request = URLRequest(url: test)
        switch testnet {
        case true:
            request = URLRequest(url: test)
        case false:
            request = URLRequest(url: main)
        }
        
        request.httpMethod = "GET"
        URLSession.shared.dataTask(
            with: request,
            completionHandler: { data, response, error in
                if let data = data,
                    let height = String(data: data, encoding: .utf8) {
                    completion(.success(height))
                } else {
                    completion(.failure(error ?? DataError.fetchInfoFailure))
                }
        }).resume()
        
    }
    
}
