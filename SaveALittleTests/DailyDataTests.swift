//
//  DailyDataTests.swift
//  SaveALittle
//
//  Created by Tony Mu on 22/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import XCTest
import SaveALittle
import RealmSwift
import SwiftDate

class DailyDataTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Use an in-memory Realm identified by the name of the current test.
        // This ensures that each test can't accidentally access or modify the data
        // from other tests or the application itself, and because they're in-memory,
        // there's nothing that needs to be cleaned up.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    func testGroupToDailyData() {
        
        // Arrange
        let dataSampleSize = 5
        var startDate = Date() - 1.day
        
        for _ in 0..<dataSampleSize {
            let translaction = ExpenseTransaction()
            translaction.expenseType = .Automobile
            translaction.dateTime = startDate as NSDate
            translaction.amount = 10.0
            translaction.from = "Test"
            translaction.save()
            
            startDate = startDate + 10.hour
        }
        
        // Act
        let dataSource = ExpenseTransactionDataSource()
        dataSource.reloadData()
        
        let groupedDailyData = dataSource.map{$0}.groupedBy { (transaction) -> DateInRegion in
            return transaction.dateTime.startOfDay
        }
        
        let dailyDataSource = DailyDataSource()
        
        for data in groupedDailyData {
            print(data.key)
            var dailyData = DailyData(date: data.key)
            dailyData.transactions = data.value
            dailyDataSource[dailyData.date.absoluteDate] = dailyData
        }
        
        _ = dailyDataSource[DateInRegion().startOfDay.absoluteDate]
    
        // Assect
        XCTAssertEqual(dataSource.count, 5)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
