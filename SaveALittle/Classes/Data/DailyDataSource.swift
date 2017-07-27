//
//  DailyDataSource.swift
//  SaveALittle
//
//  Created by Tony Mu on 22/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import SwiftDate

public class DailyDataSource: Sequence {
  
  fileprivate var data: Dictionary<Date, DailyData>
  private let transactionRepository: TransactionRepository
  
  public var count: Int {
    get{
      return data.count
    }
  }
  
  public init(transactionRepository: TransactionRepository){
    data = Dictionary<Date, DailyData>()
    self.transactionRepository = transactionRepository
  }
  
  public static var shared: DailyDataSource {
    struct Singleton{
      static let instance = DailyDataSource(transactionRepository: DefaultTransactionRepository())
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
    var transactions: [TransactionViewModel] = getExpenseTransactions()
    transactions += getIncomeTransactions() as [TransactionViewModel]
    
    let groupedDailyData = transactions.map{$0}.groupedBy { (transaction) -> DateInRegion in
      return transaction.dateTime.startOfDay
    }
    
    for item in groupedDailyData {
      var dailyData = DailyData(date: item.key)
      dailyData.transactions = item.value.sorted()
      data[dailyData.date.absoluteDate] = dailyData
    }
  }
  
  private func getExpenseTransactions() ->[ExpenseTransactonViewModel] {
    
    let expenses = self.transactionRepository.getExpense()
    
    return expenses.map({ (transaction) -> ExpenseTransactonViewModel in
      let transactionViewModel = ExpenseTransactonViewModel(id: transaction.id, amount: transaction.amount, dateTime: transaction.dateTime as Date, type: Expense(rawValue: transaction.type)!)
      transactionViewModel.from = transaction.from
      return transactionViewModel
    })
  }
  
  private func getIncomeTransactions() ->[IncomeTransactionViewModel] {
    
    let expenses = self.transactionRepository.getIncome()
    
    return expenses.map({ (transaction) -> IncomeTransactionViewModel in
      let transactionViewModel = IncomeTransactionViewModel(id: transaction.id, amount: transaction.amount, dateTime: transaction.dateTime as Date, type: Income(rawValue: transaction.type)!)
      transactionViewModel.from = transaction.from
      return transactionViewModel
    })
  }
  
}

extension DailyDataSource {
  
  public func dataOfTheMonth(date: DateInRegion) ->[DailyData] {
    let targetMonth = date.month
    let targetYear = date.year
    
    let data = self.flatMap { (key, value) -> DailyData? in
      let month = value.date.month
      let year = value.date.year
      
      if month == targetMonth && year == targetYear {
        return value
      }
      return nil
    }
    
    return data
  }
  
//  public func groupedByMonth() ->[Date:[DailyData]] {
//    let groupBy: (DailyData) -> Date = { dailyData in
//      return dailyData.date.startOf(component: .month).absoluteDate
//    }
//    
//    let data = self.map{$0.value}.groupedBy{groupBy($0)}
//    return data
//  }
  
  public func groupedByMonth() ->[MonthlyData] {
    let groupBy: (DailyData) -> Date = { dailyData in
      return dailyData.date.startOf(component: .month).absoluteDate
    }
    
    let data = self.map{$0.value}.groupedBy{groupBy($0)}.map { (key, value) -> MonthlyData in
      return MonthlyData(firstDay: DateInRegion(absoluteDate:key), days: value.sorted())
    }
    return data.sorted()
  }
}
