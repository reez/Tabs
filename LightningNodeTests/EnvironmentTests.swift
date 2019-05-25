//
//  EnvironmentTests.swift
//  LightningNodeTests
//
//  Created by Matthew Ramsden on 5/25/19.
//  Copyright © 2019 Matthew Ramsden. All rights reserved.
//

import XCTest
@testable import LightningNode

class EnvironmentTests: XCTestCase {

    func testEnvironmentMock() {
        Current = .mock
        
        let date = Current.date()
        let mock = Date(timeIntervalSinceReferenceDate: 547152021)
        XCTAssertEqual(date, mock)
    }
    
    func testEnvironmentTest() {
        Current = .test
        
        let date = Current.date()
        let test = Date(timeIntervalSinceReferenceDate: 547152021)
        XCTAssertEqual(date, test)
    }

}
