//
//  ViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 18/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import XCTest
import SwiftDate

class SequenceTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  
  
  func testGroupsDateInRegions_by_date_only() {
    
    // Arrange
    
    let groupBy: (DateInRegion) -> String = { dateInRageion in
      return dateInRageion.string(dateStyle: .short, timeStyle: .none)
    }
    
    let startDate = try! "2012-09-13T08:57:00Z".date(format: .iso8601(options: .withInternetDateTime)).absoluteDate
    var dateArray = [Date]()
    
    let sampleSize = 20
    
    for n in 0..<sampleSize {
      let date = startDate + n.hours
      dateArray.append(date)
    }
    
    let dateInRanges = dateArray.map { (date) -> DateInRegion in
      date.toDateInRegion()
    }
    
    // Act
    
    let result = dateInRanges.groupedBy(groupBy)
    
    // Assert
    
    XCTAssertEqual(result.count, 2)
    
  }
  
  func testPerformanceGroupsDateInRegions() {
    // Arrange
    
    let groupBy: (DateInRegion) -> String = { dateInRegion in
      return dateInRegion.string(dateStyle: .short, timeStyle: .none)
    }
    
    let startDate = try! "2012-09-13T08:57:00Z".date(format: .iso8601(options: .withInternetDateTime)).absoluteDate
    var dateArray = [Date]()
    
    let sampleSize = 10000
    
    for n in 0..<sampleSize {
      let date = startDate + n.hours
      dateArray.append(date)
    }
    
    let dateInRegions = dateArray.map { (date) -> DateInRegion in
      date.toDateInRegion()
    }
    
    // Act
    
    self.measure {
      _ = dateInRegions.groupedBy(groupBy)
    }
  }
  
}
