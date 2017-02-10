//
//  ViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 18/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import XCTest
import SwiftDate

class MonthIteratorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMonthIterator_from_today() {
      // Arrange
      let now = DateInRegion()
      let monthIterator = MonthIterator(startDate: now)
      
      // Act
      
      let monthes = monthIterator.map{$0}
      
      // Assert
      
      XCTAssertEqual(monthes.count, 1)
    }
  
  
  func testMonthIterator_from_3monthAgo() {
    // Arrange
    let threeMonthAgo = DateInRegion() - 80.day
    let monthIterator = MonthIterator(startDate: threeMonthAgo)
    
    // Act
    
    let monthes = monthIterator.map{$0}
    
    // Assert
    
    XCTAssertEqual(monthes.count, 4)
  }
  
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
