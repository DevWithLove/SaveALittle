//
//  MonthViewHeaderCell.swift
//  SaveALittle
//
//  Created by Tony Mu on 26/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit

class MonthHeaderCell: UICollectionViewCell {
    
    static let monthHeaderCellId = "monthHeaderCell"
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    private func setupViews(){
        backgroundColor = .clear
    }
    
}
