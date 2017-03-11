//
//  FloatExtensions.swift
//  SaveALittle
//
//  Created by Tony Mu on 24/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import UIKit


extension Float {
    
    var toCurrency:String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        let price = self as NSNumber
        return formatter.string(from: price)!
    }
    
    var twoDecimpalPlacesString: String {
        return String(format: "%.2f", self)
    }
    
}

extension Double {
    
    var toCurrency:String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        let price = self as NSNumber
        return formatter.string(from: price)!
    }
    
    var twoDecimpalPlacesString: String {
        return String(format: "%.2f", self)
    }
}
