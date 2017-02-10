//
//  ViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 18/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import SwiftDate

extension DateInRegion {
  
  var shortWeekdayName: String {
    get{
     return self.string(custom: "EEE")
    }
  }
}
