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
    
    public var total: Double {
        return transactions.sum({ (transaction) -> Double in
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
