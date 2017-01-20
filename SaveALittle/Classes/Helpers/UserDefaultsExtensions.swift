//
//  UserDefaultsExtensions.swift
//  SaveALittle
//
//  Created by Tony Mu on 20/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import Foundation

extension UserDefaults {

    enum UserdefaultsKeys: String {
        case isLoggedIn
    }
    
    func setIsUserLoggedIn(value: Bool){
        self.set(value, forKey: UserdefaultsKeys.isLoggedIn.rawValue)
        self.synchronize()
    }
    
    func isLoggedIn()->Bool {
        return bool(forKey: UserdefaultsKeys.isLoggedIn.rawValue)
    }

}
