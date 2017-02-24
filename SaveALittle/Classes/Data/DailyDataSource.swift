//
//  DailyDataSource.swift
//  SaveALittle
//
//  Created by Tony Mu on 22/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import SwiftDate
import RealmSwift

public class DailyDataSource: Sequence {
    
    fileprivate var data: Dictionary<Date, DailyData>
    
    public var count: Int {
        get{
            return data.count
        }
    }
    
    public init(){
        data = Dictionary<Date, DailyData>()
    }
    
    public static var shared: DailyDataSource {
        struct Singleton{
            static let instance = DailyDataSource()
        }
        return Singleton.instance
    }
    
    public func getProperty(_ key: Date) ->DailyData?{
        guard let value = data[key] else {return nil}
        return value
    }
    
    public func makeIterator() -> DictionaryIterator<Date, DailyData> {
        return data.makeIterator()
    }
    
    public subscript(key: Date) -> DailyData? {
        get {
            return getProperty(key)
        }
        set(newValue){
            data[key] = newValue
        }
    }
    
    public func reload(){
        
        let expenses = getExpenseTransactions()
        
        let groupedDailyData = expenses.map{$0}.groupedBy { (transaction) -> DateInRegion in
            return transaction.dateTime.startOfDay
        }
        
        for item in groupedDailyData {
            var dailyData = DailyData(date: item.key)
            dailyData.transactions = item.value.sorted()
            data[dailyData.date.absoluteDate] = dailyData
        }
    }
    
    private func getExpenseTransactions() ->[ExpenseTransactonViewModel] {
        let realm = try! Realm()
        let expenses = realm.objects(ExpenseTransaction.self)
        
        return expenses.map({ (transaction) -> ExpenseTransactonViewModel in
           let transactionViewModel = ExpenseTransactonViewModel(id: transaction.id, amount: transaction.amount, dateTime: transaction.dateTime as Date, type: Expense(rawValue: transaction.type)!)
           transactionViewModel.from = transaction.from
           return transactionViewModel
        })
    }

}
