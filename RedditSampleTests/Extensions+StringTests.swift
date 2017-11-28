//
//  Extensions+StringTests.swift
//  RedditSampleTests
//
//  Created by Daniel Gilbert on 11/28/17.
//  Copyright © 2017 Danny Gilbert. All rights reserved.
//

import XCTest
@testable import RedditSample

class Extensions_StringTests: XCTestCase {
    
    func testhtml2String() {
        // Test Properties
        let test1 = "Hit &amp; Run".html2String
        let test2 = "Hit & Run".html2String
        let test3 = "".html2String
        let test4 = "Testing".html2String
        
        // Evaluate Test Properties
        XCTAssert(test1 == "Hit & Run", "Test Case 1 failed!")
        XCTAssert(test2 == "Hit & Run", "Test Case 2 failed!")
        XCTAssert(test3 == "", "Test Case 3 failed!")
        XCTAssert(test4 == "Testing", "Test Case 4 failed!")
    }
    
}
