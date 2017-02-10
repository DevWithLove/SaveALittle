//
//  DayCollectionDataSource.swift
//  SaveALittle
//
//  Created by Tony Mu on 11/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import SwiftDate

public class DayCollectionDataSource: Collection {

    private var data = [DayCellData]()
    
    var offsetDays = 0
    
    public init(offsetDays: Int) {
        self.offsetDays = offsetDays
        reload()
    }
    
    public var startIndex: Int {
        return data.startIndex
    }
    
    public var endIndex: Int {
        return data.endIndex
    }
    
    public subscript(index: Int) -> DayCellData {
        return data[index]
    }
    
    public func index(after i: Int) -> Int {
        return data.index(after: i)
    }
    
    public var last: DayCellData? {
        return data.last
    }
    
    public var firstSelectableIndex: Int? {
        let firstCell = data.first { $0.type == .selectedable}!
        return data.index(of: firstCell)
    }
    
    public var lastSelectableIndex: Int? {
        let lastCell = data.filter{ $0.type == .selectedable }.last!
        return data.index(of: lastCell)
    }
    
    public func reload() {
        
        let today = DateInRegion().startOfDay
        let monthStart = today.startOf(component: .month)
        
        let start = monthStart - offsetDays.day
        let end = DateInRegion() + offsetDays.day
        
        let dayIterator = DayIterator(startDate: start, endDate: end)
        data = dayIterator.map{ DayCellData(type: self.dayCellType(date: $0), date: $0) }
    }
    
    public func getIndex(date: DateInRegion)-> Int? {
        guard let dayCell = (data.filter {$0.date == date}).first else {
            return nil
        }
        return data.index(of: dayCell)
    }
    
    
    // MARK: Helper Methods
    
    private func dayCellType(date: DateInRegion) -> DayCellDataType {
        let today = DateInRegion().startOfDay
        
        // Only days between first day of the month until today
        // can be selected.
        if date < today.startOf(component: .month) || date > today {
            return .noSelectedable
        }
        
        return .selectedable
    }
}
