//
//  TransactionRepository.swift
//  SaveALittle
//
//  Created by Tony Mu on 26/07/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit

public protocol TransactionRepository {

  func getExpense()-> [ExpenseTransaction]
  
  func getExpense(id: String)-> ExpenseTransaction?
  
  func getIncome()-> [IncomeTransaction]
  
  func getIncome(id: String)-> IncomeTransaction?
  
  func save(transaction: Transaction)
  
  func delete(transaction: Transaction)
  
}
