//
//  TransactionTableViewCell.swift
//  SaveALittle
//
//  Created by Tony Mu on 4/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    static let cellId = String(describing: type(of:TransactionTableViewCell.self))

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var storeLabel: UILabel!
    @IBOutlet weak var lineViewOne: UIView!
    @IBOutlet weak var lineViewTwo: UIView!
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Layout
    private func setupViews(){
        backgroundColor = .clear
        
        timeLabel.layer.cornerRadius = 15
        timeLabel.layer.masksToBounds = true
        timeLabel.backgroundColor = Color.darkerBackground
        
        lineViewOne.layer.cornerRadius = 1
        lineViewOne.layer.masksToBounds = true
        lineViewOne.backgroundColor = Color.darkLine
        
        lineViewTwo.layer.cornerRadius = 1
        lineViewTwo.layer.masksToBounds = true
        lineViewTwo.backgroundColor = Color.darkLine
    }

}
