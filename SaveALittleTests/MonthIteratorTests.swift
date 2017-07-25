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
  
//  func testSample(){
//    
//    var start = try! DateInRegion(components: [.year: 2007, .month: 3, .day: 1])
//    var end = try! DateInRegion(components: [.year: 2007, .month: 3, .day: 7])
//    
//    
//    var array = [MetricData]()
//    let data1 = MetricData(dateInRegion: try! DateInRegion(components: [.year: 2007, .month: 3, .day: 1]), isHighLeak: true)
//    let data2 = MetricData(dateInRegion: try! DateInRegion(components: [.year: 2007, .month: 3, .day: 3]), isHighLeak: true)
//    let data3 = MetricData(dateInRegion: try! DateInRegion(components: [.year: 2007, .month: 3, .day: 4]), isHighLeak: true)
//    let data4 = MetricData(dateInRegion: try! DateInRegion(components: [.year: 2007, .month: 3, .day: 5]), isHighLeak: true)
//    let data5 = MetricData(dateInRegion: try! DateInRegion(components: [.year: 2007, .month: 3, .day: 6]), isHighLeak: false)
//    
//    array.append(data1)
//    array.append(data2)
//    array.append(data3)
//    array.append(data4)
//    array.append(data5)
//    
//
//    let dateRange = DateRange(start: start, end: end)
//    let ranges = DateRangeIterator(dateRange: dateRange).map{$0}
//    
//    for range in ranges {
//      let data = array.filter({ (metricData) -> Bool in
//        range.contains(metricData.dateInRegion) && metricData.isHighLeak
//      })
//      
//      if data.count == 3 {
//        print(range)
//      }
//      
//    }
//    
//    
//    
//    let input = [1,2,3,4,8,10,12,19]
//    
//    let d = input.enumerated().flatMap { (index, element) -> Int? in
//      
//      if index < input.count - 1 {
//        return element + 1 == input[index + 1] ? nil : element
//      }
//      return nil
//    }
//    
//    for (index, item) in input.enumerated() {
//      print("Found \(item) at position \(index)")
//    }
//    
//    let output = input.enumerated().flatMap { index, element in
//      return index > 0 && input[index - 1] + 1 == element ? nil : element
//    }
//    
//    
//  }
  
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

struct MetricData {
  let dateInRegion: DateInRegion
  let isHighLeak: Bool
}

class DateRange: CustomStringConvertible {
  
  let start: DateInRegion
  let end: DateInRegion
  
  var description: String {
    return "\(start) - \(end)"
  }
  
  init(start:DateInRegion , end:DateInRegion){
    self.start = start
    self.end = end
  }
  
  func contains(_ date: DateInRegion) -> Bool{
    return date >= start && date <= end
  }
}


struct DateRangeIterator:Sequence, IteratorProtocol {
  
  private let dateRange: DateRange
  private var start: DateInRegion
  
  init(dateRange: DateRange){
    self.dateRange = dateRange
    start = dateRange.start
  }
  
  mutating func next() -> DateRange? {
    defer {
      start = start + 1.day
    }
    
    let end = start + 2.day
    
    return dateRange.contains(end) ? DateRange(start: start, end: end) : nil
  }
}

