//
//  UnitTests.swift
//  UnitTests
//
//  Created by EyreFree on 2018/3/5.
//  Copyright © 2018年 EyreFree. All rights reserved.
//

import XCTest

class UnitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample0() {
        let result = input(rects: [(1, 2, 2), (3, 4, 3), (5, 8, 1), (9, 10, 2)])
        XCTAssert(result.0 == .success && result.1 == 9, "算错了，快来查查！")
    }
    
    func testExample1() {
        let result = input(rects: [(1, 2, 2), (3, 4, 3), (5, 8, 1), (9, 10, 100)])
        XCTAssert(result.0 == .success && result.1 == 14, "算错了，快来查查！")
    }
    
    func testExample2() {
        let result = input(rects: [(1, 2, 2), (3, 4, 3)])
        XCTAssert(result.0 == .success && result.1 == 2, "算错了，快来查查！")
    }
    
    func testExample3() {
        let result = input(rects: [(1, 2, 2), (3, 4, 3), (5, 8, 4), (9, 10, 2)])
        XCTAssert(result.0 == .success && result.1 == 7, "算错了，快来查查！")
    }
    
    func testExample4() {
        let result = input(rects: [(1, 2, 2)])
        XCTAssert(result.0 == .tooFewRects && result.1 == -1, "输入错误没检测成功，快来查查！")
    }
    
    func testExample5() {
        let result = input(rects: [])
        XCTAssert(result.0 == .tooFewRects && result.1 == -1, "输入错误没检测成功，快来查查！")
    }
    
    func testExample6() {
        let result = input(rects: [(1, 2, 2), (1, 4, 5), (5, 8, 4), (9, 10, 2)])
        XCTAssert(result.0 == .errorRect && result.1 == -1, "输入错误没检测成功，快来查查！")
    }
    
    func testExample7() {
        let result = input(rects: [(1, 2, 2), (3, 4, 100), (5, 8, 1), (9, 10, 2)])
        XCTAssert(result.0 == .success && result.1 == 9, "算错了，快来查查！")
    }
    
    func testExample8() {
        let result = input(rects: [(1, 2, 1), (3, 4, 100), (5, 8, 1), (9, 10, 2)])
        XCTAssert(result.0 == .success && result.1 == 8, "算错了，快来查查！")
    }
    
    func testExample9() {
        let result = input(rects: [(1, 2, 2), (3, 4, 100), (5, 8, 1), (10, 11, 2)])
        XCTAssert(result.0 == .success && result.1 == 11, "算错了，快来查查！")
    }
    
    func testExample10() {
        let result = input(rects: [(1, 2, 1), (3, 4, 1), (5, 8, 1), (9, 10, 1)])
        XCTAssert(result.0 == .success && result.1 == 3, "算错了，快来查查！")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
