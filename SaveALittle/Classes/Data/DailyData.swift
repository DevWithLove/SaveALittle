//
//  DailyData.swift
//  SaveALittle
//
//  Created by Tony Mu on 22/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import SwiftDate

public struct DailyData: Equatable, Comparable {
    public let date: DateInRegion
    public var transactions = [TransactionViewModel]()
    
    public var totalIncome: Double {
        let incomes = transactions.filter({$0.transactionType == .Income})
        
        return incomes.sum({ (transaction) -> Double in
            return Double(transaction.amount)
        })
    }
    
    public var totalExpense: Double {
        let expenses = transactions.filter({$0.transactionType == .Expense})
        
        return expenses.sum({ (transaction) -> Double in
            return Double(transaction.amount)
        })
    }
    
    public init (date: DateInRegion){
        self.date = date
    }
}

public func == (left: DailyData, right: DailyData) -> Bool {
    return left.date == right.date
}

public func <(left: DailyData, right: DailyData) -> Bool {
    return left.date < right.date
}
