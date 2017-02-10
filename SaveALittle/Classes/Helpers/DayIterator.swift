//
//  ViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 18/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import SwiftDate

struct DayIterator:Sequence, IteratorProtocol {
    
    private var startDate: DateInRegion
    private var endDate: DateInRegion?
    
    init(startDate: DateInRegion, endDate: DateInRegion? = nil){
        self.startDate = startDate.startOfDay
        self.endDate = endDate
    }
    
    mutating func next() -> DateInRegion? {
        defer {
            startDate = startDate + 1.day
        }
        
        if let end = endDate {
            return startDate <= end ? startDate : nil
        }
        
        return !startDate.isInFuture ? startDate : nil
    }
}

