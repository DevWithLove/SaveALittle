//
//  MonthViewHeaderCell.swift
//  SaveALittle
//
//  Created by Tony Mu on 26/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit

class MonthHeaderCell: UICollectionViewCell {
    
    static let cellId = "monthHeaderCell"
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var incomeValueLabel: UILabel!
    @IBOutlet weak var expenseValueLabel: UILabel!
    @IBOutlet weak var firstDayLabel: UILabel!
    @IBOutlet weak var lastDayLabel: UILabel!
    
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Layout
    
    private func setupViews(){
        firstDayLabel.layer.cornerRadius = 10
        firstDayLabel.layer.masksToBounds = true
        lastDayLabel.layer.cornerRadius = 10
        lastDayLabel.layer.masksToBounds = true
    }
    
}
