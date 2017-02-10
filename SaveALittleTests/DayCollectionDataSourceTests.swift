//
//  DayCollectionDataServiceTests.swift
//  SaveALittle
//
//  Created by Tony Mu on 10/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import XCTest
import SwiftDate

class DayCollectionDataSourceTests: XCTestCase {
    
    // MARK: Days
    
    func testDays_no_offset_days() {
        // Arrange
        let today = DateInRegion().startOfDay
        let dataSource = DayCollectionDataSource(offsetDays: 0)
        
        // Act
        let firstDayCell = dataSource.first!
        let lastDayCell = dataSource.last!
        
        // Assect
        XCTAssertEqual(firstDayCell.date, today.startOf(component: .month))
        XCTAssertEqual(lastDayCell.date, today)
        XCTAssertEqual(firstDayCell.type, .selectedable)
        XCTAssertEqual(lastDayCell.type, .selectedable)
    }
    
    func testDays_with_offset_days() {
        // Arrange
        let today = DateInRegion().startOfDay
        let dataSource = DayCollectionDataSource(offsetDays: 5)
        
        // Act
        let firstDayCell = dataSource.first!
        let sixthDayCell = dataSource[5]
        let lastDayCell = dataSource.last!
        
        // Assect
        XCTAssertEqual(firstDayCell.date, today.startOf(component: .month) - 5.days)
        XCTAssertEqual(lastDayCell.date, today + 5.days)
        XCTAssertEqual(firstDayCell.type, .noSelectedable)
        XCTAssertEqual(lastDayCell.type, .noSelectedable)
        XCTAssertEqual(sixthDayCell.date, today.startOf(component: .month))
        XCTAssertEqual(sixthDayCell.type, .selectedable)
    }
    
    
    // MARK: Get Index of the day
    
    
    func testDays_with_getTodayIndex() {
        // Arrange
        let today = DateInRegion().startOfDay
        let dataSource = DayCollectionDataSource(offsetDays: 5)
        
        // Act
        let todayIndex = dataSource.getIndex(date: today)
        let expectedCell = dataSource[todayIndex!]
        
        // Assect
        XCTAssertEqual(expectedCell.date, today)
        XCTAssertEqual(expectedCell.type, .selectedable)
    }
    
    
    func testDays_with_getDateOfIndex() {
        // Arrange
        let firstDayOfTheMonth = DateInRegion().startOf(component: .month)
        let dataSource = DayCollectionDataSource(offsetDays: 5)
        
        // Act
        let firstDayOfMonthIndex = dataSource.getIndex(date: firstDayOfTheMonth)
        let expectedCell = dataSource[firstDayOfMonthIndex!]
        
        // Assect
        XCTAssertEqual(expectedCell.date, firstDayOfTheMonth)
        XCTAssertEqual(expectedCell.type, .selectedable)
    }
    
    
    // MARK: Get First and Last selectedable Index
    
    
    func testDays_with_get_first_selectable_Index() {
        // Arrange
        let dataSource = DayCollectionDataSource(offsetDays: 5)
        
        // Act
        let index = dataSource.firstSelectableIndex!
        let expectedCell = dataSource[index]
        
        // Assect
        XCTAssertEqual(expectedCell.date, DateInRegion().startOf(component: .month))
        XCTAssertEqual(expectedCell.type, .selectedable)
    }
    
    
    func testDays_with_get_last_selectable_Index() {
        // Arrange
        let dataSource = DayCollectionDataSource(offsetDays: 5)
        
        // Act
        let index = dataSource.lastSelectableIndex!
        let expectedCell = dataSource[index]
        
        // Assect
        XCTAssertEqual(expectedCell.date, DateInRegion().startOfDay)
        XCTAssertEqual(expectedCell.type, .selectedable)
    }
    
}
