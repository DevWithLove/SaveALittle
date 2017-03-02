//
//  CachedLocationInput.swift
//  SaveALittle
//
//  Created by Tony Mu on 27/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import RealmSwift

class CachedLocation: Object {
    
    dynamic var from: String = ""
    
    override public static func indexedProperties() -> [String] {
        return ["from"]
    }
    
    override public static func primaryKey() -> String? {
        return "from"
    }
}
