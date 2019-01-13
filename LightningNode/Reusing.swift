//
//  Reusing.swift
//  LightningNode
//
//  Created by Matthew Ramsden on 1/13/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import Foundation

struct Reusing<A> {
    var identifier: () -> String
    
    init(identifier: @escaping () -> String = { String(describing: A.self) }) {
        self.identifier = identifier
    }
}
