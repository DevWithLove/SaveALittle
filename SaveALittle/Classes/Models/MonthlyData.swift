//
//  MonthlyData.swift
//  SaveALittle
//
//  Created by Tony Mu on 15/03/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import SwiftDate

public struct MonthlyData: Equatable,Comparable {
  var firstDay: DateInRegion
  var days: [DailyData]
}


public func == (left: MonthlyData, right: MonthlyData) -> Bool {
  return left.firstDay == right.firstDay
}

public func <(left: MonthlyData, right: MonthlyData) -> Bool {
  return left.firstDay < right.firstDay
}


public extension MonthlyData {
  
  func expenses() -> [Double] {
    var expenses = [Double]()
    
    for day in 0..<firstDay.monthDays {
      let currentDate = self.firstDay + day.day
      guard let dailyData = self.days.filter({ (data) -> Bool in
        return data.date.absoluteDate == currentDate.absoluteDate
      }).first else {
        expenses.append(0)
        continue
      }
      expenses.append(dailyData.totalExpense)
    }
    
    return expenses
  }
  
}
