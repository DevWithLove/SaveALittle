//
//  Color.swift
//  SaveALittle
//
//  Created by Tony Mu on 19/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//
import Foundation
import UIKit

//struct Color {
//
//    static let whiteColor = UIColor.white
//    static let orangeColor = UIColor(red: 247/255, green: 154/255, blue: 27/255, alpha: 1)
//    
//    static let lightOrange = UIColor(r:235 ,g:147, b:123)
//    static let lightBlue = UIColor(red: 184/255, green: 197/255, blue: 214/255, alpha: 1)
//    
//    
//    // MARK: Background
//    static let darkBackground = UIColor(r:50 ,g:60, b:70)
//    static let darkBackgroundWith05alpha = UIColor(r: 50, g: 60, b: 70, a: 0.5)
//    static let darkerBackground = UIColor(r:38 ,g:47, b:56)
//    
//    // MARK: Line
//    static let darkLine = UIColor(r:91 ,g:99, b:107)
//
//    // MARK: Text
//    static let darkerText = UIColor(r:60, g:79, b:94)
//    static let darkText = UIColor(r:98, g:116, b:133)
//    
//    static let textColor = UIColor(white: 0.2, alpha: 1)
//}


enum Color {
  
  case white
  case white_02
  case orange
  case orange_08
  case blue_14
  case blue_34
  case gray_15
  case gray_26
  case black_29
  case black_32
  case custom(hex:String , alpha:Double)
  
  var value: UIColor {
    switch self {
    case .white:
      return UIColor.white
    case .white_02:
      return UIColor(white: 02, alpha: 1)
    case .orange:
      return UIColor(red: 247, green: 154, blue: 27)
    case .orange_08:
      return UIColor(red: 235, green: 147, blue: 123)
    case .blue_14:
      return UIColor(red: 184, green: 197, blue: 214)
    case .blue_34:
      return UIColor(red: 60, green: 79, blue: 94)
    case .gray_15:
      return UIColor(red: 91, green: 99, blue: 107)
    case .gray_26:
      return UIColor(red: 98, green: 116, blue: 133)
    case .black_29:
      return UIColor(red: 50, green: 60, blue: 70)
    case .black_32:
      return UIColor(red: 38, green: 47, blue: 56)
    case .custom(let hex, let opacity):
      return UIColor(hexString: hex).withAlphaComponent(CGFloat(opacity))
    }
  }
  
  
  func withAlpha(_ alpha:Double) -> UIColor {
    return self.value.withAlphaComponent(CGFloat(alpha))
  }
}
