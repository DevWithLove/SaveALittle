//
//  ViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 18/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//
import Foundation
import SwiftDate

struct MonthIterator:Sequence, IteratorProtocol {

  private var dateOfMonth: DateInRegion
  
  init(startDate: DateInRegion){
    self.dateOfMonth = startDate.startOf(component: .month)
  }
  
  mutating func next() -> DateInRegion? {
  
    defer {
      dateOfMonth = dateOfMonth.nextMonth
    }
    
    return !dateOfMonth.isInFuture ? dateOfMonth : nil
  }
}
