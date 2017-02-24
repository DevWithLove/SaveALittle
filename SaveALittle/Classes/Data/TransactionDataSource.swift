//
//  TransactionDataSource.swift
//  SaveALittle
//
//  Created by Tony Mu on 19/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import RealmSwift

public class TransactionDataSource: Sequence {
    
    fileprivate var data = Set<TransactionViewModel>()
    
    public init() {
    }
    
    public var count: Int {
        get{
            return data.count
        }
    }
    
    public func makeIterator() -> IndexingIterator<[TransactionViewModel]> {
        return Array(data).makeIterator()
    }
    
    public func reloadData(){
        fatalError("Must override")
    }
}


public class ExpenseTransactionDataSource: TransactionDataSource {
    
    override public func reloadData() {
        let realm = try! Realm()
        let expenses: [TransactionViewModel] = realm.objects(ExpenseTransaction.self).map { (translaction) -> ExpenseTransactonViewModel in
            return ExpenseTransactonViewModel(id: translaction.id, amount: translaction.amount, dateTime: translaction.dateTime as Date, type: Expense(rawValue: translaction.type)!)
        }
        
       data.formUnion(expenses)
    }
}
