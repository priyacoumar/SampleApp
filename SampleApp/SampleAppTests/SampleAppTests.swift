//
//  SampleAppTests.swift
//  SampleAppTests
//
//  Created by Swaminathan, Priya on 5/23/17.
//  Copyright © 2017 Allstate Insurance Corporation. All rights reserved.
//

import XCTest
@testable import SampleApp

class SampleAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        var asyncExpectation: XCTestExpectation? = expectation(description: "Testing Sample App First Test Case")
        //asyncExpectation?.fulfill()
        //asyncExpectation = nil
        
        let result =  SimpleNetwork.makeGetCall()
        XCTAssertNotNil(result)
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
