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

let lndCertificate = """
-----BEGIN CERTIFICATE-----
MIICiDCCAi+gAwIBAgIQdo5v0QBXHnji4hRaeeMjNDAKBggqhkjOPQQDAjBHMR8w
HQYDVQQKExZsbmQgYXV0b2dlbmVyYXRlZCBjZXJ0MSQwIgYDVQQDExtKdXN0dXNz
LU1hY0Jvb2stUHJvLTMubG9jYWwwHhcNMTgwODIzMDU1ODEwWhcNMTkxMDE4MDU1
ODEwWjBHMR8wHQYDVQQKExZsbmQgYXV0b2dlbmVyYXRlZCBjZXJ0MSQwIgYDVQQD
ExtKdXN0dXNzLU1hY0Jvb2stUHJvLTMubG9jYWwwWTATBgcqhkjOPQIBBggqhkiO
PQMBBwNCAASFhRm+w/T10PoKtg4lm9hBNJjJD473fkzHwPUFwy91vTrQSf7543j2
JrgFo8mbTV0VtpgqkfK1IMVKMLrF21xio4H8MIH5MA4GA1UdDwEB/wQEAwICpDAP
BgNVHRMBAf8EBTADAQH/MIHVBgNVHREEgc0wgcqCG0p1c3R1c3MtTWFjQm9vay1Q
cm8tMy5sb2NhbIIJbG9jYWxob3N0ggR1bml4ggp1bml4cGFja2V0hwR/AAABhxAA
AAAAAAAAAAAAAAAAAAABhxD+gAAAAAAAAAAAAAAAAAABhxD+gAAAAAAAAAwlc9Zc
k7bDhwTAqAEEhxD+gAAAAAAAABiNp//+GxXGhxD+gAAAAAAAAKWJ5tliDORjhwQK
DwAChxD+gAAAAAAAAG6Wz//+3atFhxD92tDQyv4TAQAAAAAAABAAMAoGCCqGSM49
BAMCA0cAMEQCIA9O9xtazmdxCKj0MfbFHVBq5I7JMnOFPpwRPJXQfrYaAiBd5NyJ
QCwlSx5ECnPOH5sRpv26T8aUcXbmynx9CoDufA==
-----END CERTIFICATE-----
"""

let lndMacaroon = "AgEDbG5kArsBAwoQ3/I9f6kgSE6aUPd85lWpOBIBMBoWCgdhZGRyZXNzEgRyZWFkEgV3cml0ZRoTCgRpbmZvEgRyZWFkEgV32ml0ZRoXCghpbnZvaWNlcxIEcmVhZBIFd3JpdGUaFgoHbWVzc2FnZRIEcmVhZBIFd3JpdGUaFwoIb2ZmY2hhaW4SBHJlYWQSBXdyaXRlGhYKB29uY2hhaW4SBHJlYWQSBXdyaXRlGhQKBXBlZXJzEgRyZWFkEgV3cml0ZQAABiAiUTBv3Eh6iDbdjmXCfNxp4HBEcOYNzXhrm/ncLHf5jA=="

let lndURI = "192.168.1.4:10009"
