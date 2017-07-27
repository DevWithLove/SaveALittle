//
//  LocationRepository.swift
//  SaveALittle
//
//  Created by Tony Mu on 26/07/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit

protocol LocationRepository {

  func save(location:String)
  
  func get()-> [String]
}
