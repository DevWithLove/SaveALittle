//
//  ViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 18/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import XCTest
import SwiftDate

class DateTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  // MARK: ToLocalDateTime
  
  func testToDateInRange_with_current_timezone_local() {
    
    // Arrange
    let date = try! "2012-09-13T08:57:00Z".date(format: .iso8601(options: .withInternetDateTime)).absoluteDate
    
    // Act
    let dateInRange = date.toDateInRegion()
    
    // Assert
    XCTAssertEqual(dateInRange.day, 13)
    XCTAssertEqual(dateInRange.month, 9)
    XCTAssertEqual(dateInRange.year, 2012)
    XCTAssertEqual(dateInRange.hour, 20)
    XCTAssertEqual(dateInRange.minute, 57)
    XCTAssertEqual(dateInRange.absoluteDate, date)
  }
  
  // MARK: Other
  
  func testGetCurrentMonth() {
    let now = DateInRegion()
    now.isInSameDayOf(date: now)
    
    
  }
  
  func testPerformanceToDateInRange() {
    
    // Arrange
    let startDate = try! "2012-09-13T08:57:00Z".date(format: .iso8601(options: .withInternetDateTime)).absoluteDate
    var dateArray = [Date]()
    
    let sampleSize = 1000
    
    for n in 0..<sampleSize {
      let date = startDate + n.day
      dateArray.append(date)
    }
    
    // Act
    
    self.measure {
      _ = dateArray.map({ (date) -> DateInRegion in
        date.toDateInRegion()
      })
    }
  }
  
}
