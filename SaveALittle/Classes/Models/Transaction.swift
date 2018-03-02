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


@objcMembers
public class Transaction: Object {
    
    public dynamic var id = ""
    public dynamic var type: Int = -1
    public dynamic var amount: Float = 0.0
    public dynamic var dateTime: NSDate = NSDate()
    public dynamic var from: String? = nil
    
    override public static func indexedProperties() -> [String] {
        return ["dateTime"]
    }
    
    override public static func primaryKey() -> String? {
        return "id"
    }
}

public class ExpenseTransaction: Transaction {
    public var expenseType: Expense {
        get {
            return Expense(rawValue: self.type)!
        }
        set {
            self.type = newValue.rawValue
        }
    }
}


public class IncomeTransaction: Transaction {
    public var incomeType: Income {
        get {
            return Income(rawValue: self.type)!
        }
        set {
            self.type = newValue.rawValue
        }
    }
}
