//
//  DefaultLocationRepository.swift
//  SaveALittle
//
//  Created by Tony Mu on 26/07/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit
import RealmSwift

class DefaultLocationRepository:RealmRepository, LocationRepository {
  
  func save(location: String){
    let loc = CachedLocation()
    loc.from = location
    save(object: loc)
  }
  
  func get()-> [String]{
    let locations = realm.objects(CachedLocation.self)
    return locations.map{ $0.from }
  }
  
}
