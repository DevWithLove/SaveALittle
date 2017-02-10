//
//  DayCell.swift
//  SaveALittle
//
//  Created by Tony Mu on 10/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import SwiftDate

enum DayCellType {
   case selectedable
   case noSelectedable
}

struct DayCell {
    let type: DayCellType
    let date: DateInRegion
}
