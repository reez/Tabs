//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation

enum Result<Value>: CustomStringConvertible, CustomDebugStringConvertible {
    case success(Value)
    case failure(Error)
    
    init(value: Value?, error: Error) {
        if let value = value {
            self = .success(value)
        } else {
            self = .failure(error)
        }
    }
    
    var value: Value? {
        switch self {
        case let .success(value):
            return value
        case .failure:
            return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .success:
            return nil
        case let .failure(error):
            return error
        }
    }
    
    var description: String {
        switch self {
        case let .success(value):
            return ".success(\(value))"
        case let .failure(error):
            return ".failure(\(error))"
        }
    }
    
    var debugDescription: String {
        return description
    }
    
}
