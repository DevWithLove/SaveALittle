//
//  ExpenseType.swift
//  SaveALittle
//
//  Created by Tony Mu on 16/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation

public enum Expense: Int, CustomStringConvertible {
    
    case Automobile = 0
    case BankCharges = 1
    case Charity = 2
    case Childcare = 3
    case EatOut = 20
    case Education = 4
    case Entertainment = 5
    case Events = 6
    case FoodGroceries = 7
    case Gifts = 8
    case Healthcare = 9
    case Hobbies = 10
    case Household = 11
    case Insurance = 12
    case JobExpense = 13
    case Mortage = 14
    case Leisure = 15
    case PetCare = 16
    case Rent = 17
    case Utilities = 18
    case Vacation = 19
    
    static var count: Int { return Expense.Vacation.rawValue + 1 }
    
    
    public var description: String {
        switch self {
        case .Automobile: return "Automobile"
        case .BankCharges: return "Bank Charges"
        case .Charity: return "Charity"
        case .Childcare: return "Childcare"
        case .EatOut: return "Eat Out"
        case .Education: return "Education"
        case .Entertainment: return "Entertainment"
        case .Events: return "Events"
        case .FoodGroceries: return "Food and Groceries"
        case .Gifts: return "Gifts"
        case .Healthcare: return "Healthcare"
        case .Hobbies: return "Hobbies"
        case .Household: return "Household"
        case .Insurance: return "Insurance"
        case .JobExpense: return "JobExpense"
        case .Mortage: return "Mortage"
        case .Leisure: return "Leisure"
        case .PetCare: return "PetCare"
        case .Rent: return "Rent"
        case .Utilities: return "Utilities"
        case .Vacation: return "Vacation"
        }
    }
    

    
}
