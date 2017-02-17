//
//  Transaction.swift
//  SaveALittle
//
//  Created by Tony Mu on 18/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import SwiftDate
import RealmSwift


@objc enum TransactionType: Int {
    case expense = 0
    case income = 1
}

class Transaction: Object {
    
    dynamic var id = ""
    dynamic var type: Int = -1
    dynamic var amount: Float = 0.0
    dynamic var dateTime: NSDate = NSDate()
    dynamic var from: String? = nil
    
    override static func indexedProperties() -> [String] {
        return ["dateTime"]
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    lazy var dateInRegion: DateInRegion = {
        let swiftDate = self.dateTime as Date
        return swiftDate.toDateInRegion()
    }()

}

class ExpenseTransaction: Transaction {
    var expenseType: Expense {
        get {
            return Expense(rawValue: self.type)!
        }
        set {
            self.type = newValue.rawValue
        }
    }
}


//class incomeTransaction: Transaction {
//    
//    init(amount:Decimal, dateTime: Date) {
//        super.init(type: .income, amount: amount, dateTime: dateTime)
//    }
//}
