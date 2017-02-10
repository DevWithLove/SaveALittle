//
//  ViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 18/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import XCTest
import SwiftDate

class DayIteratorTests: XCTestCase {
    
    func testDayIterator_100_days() {
        // Arrange
        let daysAgo = DateInRegion() - 100.day
        
        // Act
        let dayIterator = DayIterator(startDate: daysAgo)
        let days = dayIterator.map{$0}
        let firstDay = daysAgo.startOfDay
        let lastDay = DateInRegion().startOfDay
        
        // Assert
        XCTAssertEqual(days.count, 101)
        XCTAssertEqual(days.min(), firstDay)
        XCTAssertEqual(days.max(), lastDay)
    }
    
    
    func testDayIterator_from_now() {
        // Arrange
        let daysAgo = DateInRegion()
        
        // Act
        let dayIterator = DayIterator(startDate: daysAgo)
        let days = dayIterator.map{$0}
        let firstDay = daysAgo.startOfDay
        let lastDay = DateInRegion().startOfDay
        
        // Assert
        XCTAssertEqual(days.count, 1)
        XCTAssertEqual(days.min(), firstDay)
        XCTAssertEqual(days.max(), lastDay)
    }
    
    func testDayIterator_from_now_to_end() {
        // Arrange
        let daysAgo = DateInRegion()
        let endDate = daysAgo + 10.day
        
        // Act
        let dayIterator = DayIterator(startDate: daysAgo, endDate: endDate)
        let days = dayIterator.map{$0}
        let firstDay = daysAgo.startOfDay
        let lastDay =  endDate.startOfDay
        
        // Assert
        XCTAssertEqual(days.count, 11)
        XCTAssertEqual(days.min(), firstDay)
        XCTAssertEqual(days.max(), lastDay)
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
