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
  
  var transaction: TransactionViewModel? {
    didSet{
      guard let strongTransaction = transaction else {
        return
      }
      
      timeLabel.text = strongTransaction.dateTime.string(custom: "HH:mm")
      amountLabel.text = strongTransaction.amount.toCurrency
      storeLabel.text = strongTransaction.from
      iconLabel.text = strongTransaction.transactionType == .Expense ? "\u{f063}" : "\u{f062}"
    }
  }
  
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel!
  @IBOutlet weak var storeLabel: UILabel!
  @IBOutlet weak var lineViewOne: UIView!
  @IBOutlet weak var lineViewTwo: UIView!
  @IBOutlet weak var iconLabel: UILabel!
  @IBOutlet weak var containerView: UIView!
  
  // MARK: Life Cycle
  override func awakeFromNib() {
    super.awakeFromNib()
    setupViews()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func applyLightStyle(){
    self.containerView.backgroundColor = Color.whiteColor
    timeLabel.backgroundColor = Color.lightBlue
    timeLabel.textColor = Color.darkBackground
    amountLabel.textColor = Color.darkBackground
    storeLabel.textColor = Color.darkerText
  }
  
  // MARK: Layout
  private func setupViews(){
    backgroundColor = .clear
    selectionStyle = .none
    
    timeLabel.layer.cornerRadius = 15
    timeLabel.layer.masksToBounds = true
    timeLabel.backgroundColor = Color.darkerBackground
    
    lineViewOne.layer.cornerRadius = 1
    lineViewOne.layer.masksToBounds = true
    lineViewOne.backgroundColor = Color.darkLine
    
    lineViewTwo.layer.cornerRadius = 1
    lineViewTwo.layer.masksToBounds = true
    lineViewTwo.backgroundColor = Color.darkLine
    
    timeLabel.font = Font.titilliumWebRegular(size: 12)
    amountLabel.font = Font.titilliumWebSemiBold(size: 15)
    storeLabel.font = Font.titilliumWebLight(size: 12)
    iconLabel.font = Font.iconRegular(size: 16)
    iconLabel.textColor = Color.lightOrange
  }
  
}
