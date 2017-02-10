//
//  DayCollectionDataService.swift
//  SaveALittle
//
//  Created by Tony Mu on 10/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import SwiftDate

class DayCollectionDataService {

    var offsetDays = 0
    
    init(offsetDays: Int) {
        self.offsetDays = offsetDays
    }
    
    
    func days() -> [DayCell] {
        
        let today = DateInRegion().startOfDay
        let monthStart = today.startOf(component: .month)
        
        let start = monthStart - offsetDays.day
        let end = DateInRegion() + offsetDays.day
        
        let dayIterator = DayIterator(startDate: start, endDate: end)
        let cells: [DayCell] = dayIterator.map{ DayCell(type: self.dayCellType(date: $0), date: $0) }
        
        return cells
    }
    
    
    // MARK: Helper Methods
    
    
    private func dayCellType(date: DateInRegion) -> DayCellType {
        let today = DateInRegion().startOfDay
    
        // Only days between first day of the month until today
        // can be selected.
        if date < today.startOf(component: .month) || date > today {
            return .noSelectedable
        }
        
        return .selectedable
    }

}
