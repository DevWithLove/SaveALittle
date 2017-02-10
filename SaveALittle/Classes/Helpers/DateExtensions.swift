//
//  ViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 18/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import SwiftDate

extension Date {

  func toDateInRegion(timeZoneName: TimeZoneName = TimeZoneName.current, localeName: LocaleName = LocaleName.current) ->DateInRegion {
    let localRegion = Region(tz: timeZoneName, cal: CalendarName.gregorian, loc: localeName)
    return DateInRegion(absoluteDate: self, in: localRegion)
  }

}
