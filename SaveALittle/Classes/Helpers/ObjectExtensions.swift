//
//  ObjectExtensions.swift
//  SaveALittle
//
//  Created by Tony Mu on 18/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation
import RealmSwift


enum RealmObjectError: Error {

    case invalidId
    
}

public extension ExpenseTransaction {

    override func save() {
        if self.id.isEmpty {
            self.id = newId
        }
        self.saveObject()
    }
    
}

public extension Object {
    
    func save() {
        self.saveObject()
    }
    
    func delete() {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(self)
        }
    }
}

fileprivate extension Object {
    
    var newId: String {
        return UUID().uuidString
    }
    
    func saveObject() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self, update: true)
        }
    }
}
