//
//  TransactionDataSourceTests.swift
//  SaveALittle
//
//  Created by Tony Mu on 21/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import XCTest
import SwiftDate
import RealmSwift
import SaveALittle

class TransactionDataSourceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Use an in-memory Realm identified by the name of the current test.
        // This ensures that each test can't accidentally access or modify the data
        // from other tests or the application itself, and because they're in-memory,
        // there's nothing that needs to be cleaned up.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testReloadData() {
        
        // Arrange
        let dataSampleSize = 100
        
        for _ in 0..<dataSampleSize {
            let translaction = ExpenseTransaction()
            translaction.expenseType = .Automobile
            translaction.dateTime = NSDate()
            translaction.amount = 10.0
            translaction.from = "Test"
            translaction.save()
        }
        
        // Act
        let dataSource = ExpenseTransactionDataSource()
        dataSource.reloadData()
    
        // Assect
        XCTAssertEqual(dataSource.count, 100 )
        
    }
    
    func testPerformanceExample() {
        
        // Arrange
        var startDate = Date()
        let dataSampleSize = 30000
        
        for _ in 0..<dataSampleSize {
            let translaction = ExpenseTransaction()
            translaction.expenseType = .Automobile
            translaction.dateTime = startDate as NSDate
            translaction.amount = 10.0
            translaction.from = "Test"
            translaction.save()
            
            startDate = startDate + 5.minute
        }
        
        // Act
        let dataSource = ExpenseTransactionDataSource()

        self.measure {
            dataSource.reloadData()
        }
    }
    
}
