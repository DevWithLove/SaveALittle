//
//  NoEditableTextFiled.swift
//  SaveALittle
//
//  Created by Tony Mu on 17/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField


class NoEditableOptionTextFieldWithIcon: SkyFloatingLabelTextFieldWithIcon {

    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        if action == #selector(copy(_:)) || action == #selector(paste(_:)) || action == #selector(cut(_:)) || action == #selector(delete(_:)) {
//            return false
//        }
//        
        return false
    }
    
}
