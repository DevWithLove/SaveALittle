//
//  WeekHeaderView.swift
//  SaveALittle
//
//  Created by Tony Mu on 2/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit

class WeekHeaderView: UIView {
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Life Cycle
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    // Layout
    
    func setupViews() {
        backgroundColor = .clear
        lineView.layer.cornerRadius = 1
        lineView.layer.masksToBounds = true
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
