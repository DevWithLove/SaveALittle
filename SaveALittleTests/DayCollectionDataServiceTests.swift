//
//  DayCollectionDataServiceTests.swift
//  SaveALittle
//
//  Created by Tony Mu on 10/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import XCTest
import SwiftDate

class DayCollectionDataServiceTests: XCTestCase {
    
    // MARK: Days
    
    func testDays_no_offset_days() {
        // Arrange
        let today = DateInRegion().startOfDay
        let service = DayCollectionDataService(offsetDays: 0)
        
        // Act
        let days = service.days()
        let firstDayCell = days.first!
        let lastDayCell = days.last!
        
        // Assect
        XCTAssertEqual(firstDayCell.date, today.startOf(component: .month))
        XCTAssertEqual(lastDayCell.date, today)
        XCTAssertEqual(firstDayCell.type, .selectedable)
        XCTAssertEqual(lastDayCell.type, .selectedable)
    }
    
    func testDays_with_offset_days() {
        // Arrange
        let today = DateInRegion().startOfDay
        let service = DayCollectionDataService(offsetDays: 5)
        
        // Act
        let days = service.days()
        let firstDayCell = days.first!
        let sixthDayCell = days[5]
        let lastDayCell = days.last!
        
        // Assect
        XCTAssertEqual(firstDayCell.date, today.startOf(component: .month) - 5.days)
        XCTAssertEqual(lastDayCell.date, today + 5.days)
        XCTAssertEqual(firstDayCell.type, .noSelectedable)
        XCTAssertEqual(lastDayCell.type, .noSelectedable)
        XCTAssertEqual(sixthDayCell.date, today.startOf(component: .month))
        XCTAssertEqual(sixthDayCell.type, .selectedable)
    }
    
}
