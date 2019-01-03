//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation

public func map<A, B>(_ f: @escaping (A) -> B) -> ([A]) -> [B] {
    return { xs in xs.map(f) }
}

public func map<A, B>(_ f: @escaping (A) -> B) -> (A?) -> B? {
    return { $0.map(f) }
}

public func flatMap<A, B>(_ f: @escaping (A) -> B?) -> ([A]) -> [B?] {
    return { xs in xs.map(f) }
}

public func flatMap<A, B>(_ f: @escaping (A) -> B?) -> (A?) -> B? {
    return { $0.flatMap(f)}
}

public func prop<Root, Value> (
    _ keyPath: WritableKeyPath<Root, Value>
    )
    -> (@escaping (Value) -> Value)
    -> (Root) -> Root {
        return { update in
            { root in
                var copy = root
                copy[keyPath: keyPath] = update(copy[keyPath: keyPath])
                return copy
            }
        }
}

public func over<Root, Value> (
    _ keyPath: WritableKeyPath<Root, Value>,
    _ update: @escaping (Value) -> Value
    )
    -> (Root) -> Root {
        return prop(keyPath)(update)
}

public func set<Root, Value>(
    _ keyPath: WritableKeyPath<Root, Value>,
    _ value: Value
    )
    -> (Root) -> Root {
        return over(keyPath) { _ in value }
}

public func set<Root, Value>(
    _ keyPath: ReferenceWritableKeyPath<Root, Value>,
    _ value: Value
    )
    -> (Root) -> Root {
        return over(keyPath) { _ in value }
}
