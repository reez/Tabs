//
//  FreeFunctionsTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 5/25/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
@testable import LightningNode

class FreeFunctionsTests: XCTestCase {

    func incr(_ x: Int) -> Int { return x + 1 }

    func testMapArray() {
        let i = [1, 2, 3]
            |> map(incr)
        
        XCTAssertEqual(i, [2, 3, 4])
    }
    
    func testMapOptionalSome() {
        let i = Int?.some(2)
            .map(incr)
        
        XCTAssertEqual(i, 3)
    }
    
    func testMapOptionalNone() {
        let i = Int?.none
            .map(incr)
        
        XCTAssertEqual(i, nil)
    }
    
    func testFlatMapArray() {
        let i = [1, 2, 3]
            |> flatMap(incr)
        
        XCTAssertEqual(i, [2, 3, 4])
    }
    
    func testFlatMapOptional() {
        let i = Int?.some(2)
            |> flatMap(incr)
        
        XCTAssertEqual(i, 3)
    }
    
}
