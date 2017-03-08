//
//  DailyDataSourceTests.swift
//  SaveALittle
//
//  Created by Tony Mu on 08/03/2017.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import SwiftDate
import XCTest
import SaveALittle

class DailyDataSourceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testDailyDataSource_get_month_data() {
        
        // Arrange
        let dataSampleSize: Int = 500
        var startDate = Date() - 1.year
        let dailyDataSource = DailyDataSource()
        
        for _ in 0..<dataSampleSize {
            let dailyData = DailyData(date: DateInRegion(absoluteDate: startDate))
            dailyDataSource[startDate] = dailyData
            startDate = startDate + 1.day
        }
        
        let c: [Calendar.Component : Int] = [.year: 2017, .month: 2, .hour: 5, .day: 4, .minute: 6, .second: 7, .nanosecond: 0]
        let date = try! DateInRegion(components: c, fromRegion: nil)
        
        // Act
        let dailyData = dailyDataSource.dataOfTheMonth(date: date)
        
        // Assect
        XCTAssertEqual(dailyData.count, 28)
        
    }
    
    func testPerformance_get_month_data() {
        
        // Arrange
        let dataSampleSize: Int = 10000
        var startDate = Date() - 5.year
        let dailyDataSource = DailyDataSource()
        
        for _ in 0..<dataSampleSize {
            let dailyData = DailyData(date: DateInRegion(absoluteDate: startDate))
            dailyDataSource[startDate] = dailyData
            startDate = startDate + 1.day
        }
        
        let c: [Calendar.Component : Int] = [.year: 2017, .month: 3, .hour: 5, .day: 4, .minute: 6, .second: 7, .nanosecond: 0]
        let date = try! DateInRegion(components: c, fromRegion: nil)
        
        self.measure {
            _ = dailyDataSource.dataOfTheMonth(date: date)
        }
    }
}
