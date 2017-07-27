//
//  RealmRepository.swift
//  SaveALittle
//
//  Created by Tony Mu on 27/07/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit
import RealmSwift

enum RealmObjectError: Error {
  case invalidId
}


public class RealmRepository {
  
  var realm: Realm {
    get{
      return try! Realm()
    }
  }
  
  func save(object: Object) {
    try! realm.write {
      realm.add(object, update: true)
    }
  }
  
  func delete(object: Object) {
    try! realm.write {
      realm.delete(object)
    }
  }
}
