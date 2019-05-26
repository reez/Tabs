//
//  LightningNode
//
//  Created by Matthew Ramsden on 1/1/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation

precedencegroup ForwardApplication {
    associativity: left
}

infix operator |>: ForwardApplication

public func |> <A, B>(x: A, f: (A) -> B) -> B {
    return f(x)
}

precedencegroup ForwardComposition {
    associativity: left
    higherThan: ForwardApplication
}

infix operator >>>: ForwardComposition

//public func >>> <A, B, C>(
//    f: @escaping (A) -> B,
//    g: @escaping (B) -> C
//    ) -> ((A) -> C) {
//    
//    return { a in g(f(a)) }
//}

precedencegroup SingleTypeComposition {
    associativity: left
    higherThan: ForwardApplication
}

infix operator <>: SingleTypeComposition

//public func <> <A>(f: @escaping (A) -> A, g: @escaping (A) -> A) -> (A) -> A {
//    return f >>> g
//}
//
//public func <> <A>(f: @escaping (inout A) -> Void, g: @escaping (inout A) -> Void) -> (inout A) -> Void {
//    return { a in
//        f(&a)
//        g(&a)
//    }
//}

func <> <A: AnyObject>(f: @escaping (A) -> Void, g: @escaping (A) -> Void) -> (A) -> Void {
    return { a in
        f(a)
        g(a)
    }
}
