//
//  DailyTableViewCell.swift
//  SaveALittle
//
//  Created by Tony Mu on 25/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit
import FoldingCell

class DailyTableViewCell: FoldingCell {
    
    static let cellId = "dailyTableViewCellId"
    
     // MARK: Lifecycle
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26] // timing animation for each view
        return durations[itemIndex]
    }
    
}
