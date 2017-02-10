//
//  DayCell.swift
//  SaveALittle
//
//  Created by Tony Mu on 10/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import SwiftDate

enum DayCellDataType {
   case selectedable
   case noSelectedable
}

public struct DayCellData: Hashable, Equatable, Comparable {
    
    let type: DayCellDataType
    let date: DateInRegion
    
    public var hashValue: Int {
        get{
            return date.hashValue
        }
    }
}

public func <(left: DayCellData, right: DayCellData) -> Bool{
    return left.date < right.date
}

public func == (left: DayCellData, right: DayCellData) -> Bool {
    return left.date == right.date
}
