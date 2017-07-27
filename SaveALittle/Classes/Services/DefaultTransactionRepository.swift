//
//  DefaultTransactionRepository.swift
//  SaveALittle
//
//  Created by Tony Mu on 26/07/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit
import RealmSwift

public class DefaultTransactionRepository: RealmRepository, TransactionRepository {
  
  public func getExpense()-> [ExpenseTransaction] {
    return realm.objects(ExpenseTransaction.self).map{$0}
  }
  
  public func getExpense(id: String) -> ExpenseTransaction? {
    return realm.objects(ExpenseTransaction.self).filter("id = '\(id)'").first
  }
  
  public func getIncome()-> [IncomeTransaction] {
    return realm.objects(IncomeTransaction.self).map{$0}
  }
  
  public func getIncome(id: String) -> IncomeTransaction? {
    return realm.objects(IncomeTransaction.self).filter("id = '\(id)'").first
  }
  
  public func save(transaction: Transaction) {
    if transaction.id.isEmpty {
        transaction.id = newId
    }
    save(object: transaction)
  }
  
  public func delete(transaction: Transaction) {
    delete(object: transaction)
  }
}

extension RealmRepository {
  var newId: String {
    return UUID().uuidString
  }
}
