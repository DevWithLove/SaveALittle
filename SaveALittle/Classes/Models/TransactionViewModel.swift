//
//  TransactionViewModel.swift
//  SaveALittle
//
//  Created by Tony Mu on 19/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import SwiftDate

public class TransactionViewModel: Hashable, Equatable, Comparable {
    
    public var hashValue: Int {
        get{
            return id.hashValue
        }
    }
    
    public var id: String
    public var amount: Float
    public var dateTime: DateInRegion
    public var from: String? = nil
    public var transactionType: TransactionType
    
    public init(id:String , amount: Float, dateTime: Date, transactionType: TransactionType) {
        self.id = id
        self.amount = amount
        self.dateTime = dateTime.toDateInRegion()
        self.transactionType = transactionType
    }
}

public func == (left: TransactionViewModel, right: TransactionViewModel) -> Bool {
    return left.id == right.id
}

public func <(left: TransactionViewModel, right: TransactionViewModel) -> Bool {
    return left.dateTime < right.dateTime
}


public class ExpenseTransactonViewModel: TransactionViewModel {
    var type: Expense
    
    init(id: String, amount: Float, dateTime: Date, type: Expense) {
        self.type = type
        super.init(id: id, amount: amount, dateTime: dateTime, transactionType: .Expense)
    }
}

public class IncomeTransactionViewModel: TransactionViewModel {
    var type: Income
    
    init(id: String, amount: Float, dateTime: Date, type: Income) {
        self.type = type
        super.init(id: id, amount: amount, dateTime: dateTime, transactionType: .Income)
    }
}


