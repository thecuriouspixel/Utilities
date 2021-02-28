//
//  UtilitiesTests.swift
//  UtilitiesTests
//
//  Created by Jose A Ramirez on 25/05/2020.
//  Copyright © 2020 The Curious Pixel. All rights reserved.
//

import XCTest
@testable import Utilities

class UtilitiesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHexColor() throws {
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        let color = UIColor.init(hexString: "#FF0000", alpha: 1.0)
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        XCTAssert(red == 255.0/255.0)
    }
    
    func testLoopingIterator() throws {
        
        let array = [ 1, 2, 3, 4]
        let iterator = array.makeInfiniteLoopIterator()
        
        let expectedNext = [1,2,3,4,1,2,3,4,1,2]
        
        for expected in expectedNext {
            if let next = iterator.next() {
                XCTAssert(expected == next)
            }
        }
        
        // prep 10 items ahead of time
        let tenItems = iterator.prefix(10)
        XCTAssert(Set(tenItems) == Set(expectedNext))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
