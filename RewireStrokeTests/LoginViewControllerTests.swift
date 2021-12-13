//
//  LoginViewControllerTests.swift
//  RewireStrokeTests
//
//  Created by Amy Ha on 08/08/2021.
//  Copyright © 2021 Amy Ha. All rights reserved.
//

import XCTest
import Foundation
@testable import RewireStroke

class LoginViewControllerTests: XCTestCase {
    
    func test_fail() {
//        XCTFail("We have a problem")
    }

    
    func test_withSimpleStruct_assertNil() {
        let optionalValue: SimpleStruct? = SimpleStruct(x: 1, y: 2)
        XCTAssertNotNil(optionalValue)
    }
    
    func test_assertEqual() {
        let actual = "actual"
        XCTAssertNotEqual(actual, "expected")
    }
    
    
}
 

 
struct SimpleStruct: CustomStringConvertible {
    
    let x: Int
    let y: Int
    
    var description: String {"Test message \(x)"}
}
