//
//  ViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 18/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//



extension Sequence {
  
  func groupedBy<T : Hashable>(_ keyFunc: (Iterator.Element) -> T) -> [T:[Iterator.Element]] {
    var dict: [T:[Iterator.Element]] = [:]
    for element in self {
      let key = keyFunc(element)
      if case nil = dict[key]?.append(element) { dict[key] = [element] }
    }
    return dict
  }
  
  func weightedAverage(_ valueFunc: (Iterator.Element) -> Double ,weightFunc: (Iterator.Element) -> Double) -> Double {
    let weightSum = self.reduce(0){$0 + weightFunc($1)}
    guard weightSum > 0 else {return 0}
    
    let weightValueSum = self.reduce(0){$0 + (valueFunc($1) * weightFunc($1))}
    return weightValueSum / weightSum
  }
  
  func sum(_ valueFunc: (Iterator.Element) -> Double) -> Double {
    let total = self.reduce(0){$0 + valueFunc($1)}
    return total
  }
  
  func average(_ valueFunc: (Iterator.Element) -> Double) -> Double {
    let count = self.map{$0}.count
    guard count > 0 else {return 0}
    let total = self.sum({valueFunc($0)})
    return total / Double(count)
  }
  
}

