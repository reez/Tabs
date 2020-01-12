//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation

struct RemoteNodeConnection: Codable, Equatable {
    var uri: String
    var certificate: String
    var macaroon: String
}

extension Data {
    var hexDescription: String {
        return reduce("") {$0 + String(format: "%02x", $1)}
    }
}

class Pem {
    private let prefix = "-----BEGIN CERTIFICATE-----"
    private let suffix = "-----END CERTIFICATE-----"
    let string: String
    
    init(key: String) {
        if key.hasPrefix(prefix) {
            string = key
        } else {
            string = "\(prefix)\n\(key.separate(every: 64, with: "\n"))\n\(suffix)\n"
        }
    }
}

extension String {
    func base64UrlToBase64() -> String {
        var base64 = self
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        if base64.count % 4 != 0 {
            base64.append(String(repeating: "=", count: 4 - base64.count % 4))
        }
        
        return base64
    }
    
    func separate(every: Int, with separator: String) -> String {
        let result = stride(from: 0, to: count, by: every)
            .map { Array(Array(self)[$0..<min($0 + every, count)]) }
            .joined(separator: separator)
        return String(result)
    }
}

extension URL {
    var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems
            else { return nil }
        
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        return parameters
    }
}
