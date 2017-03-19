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
  
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var weekDayLabel: UILabel!
  @IBOutlet weak var separateLineView: UIView!
  @IBOutlet weak var transactionsLabel: UILabel!
  @IBOutlet weak var expenseLabel: UILabel!
  @IBOutlet weak var transactionsValueLabel: UILabel!
  @IBOutlet weak var expenseValueLabel: UILabel!
  @IBOutlet weak var leftBorderView: UIView!
  @IBOutlet weak var transactionTypesLabel: UILabel!
  
  var dailyData: DailyData? {
    didSet{
      guard let dailyData = self.dailyData else {
        return
      }
      
      dateLabel.text = dailyData.date.day.description
      weekDayLabel.text = dailyData.date.shortWeekdayName
    }
  }
  
  // MARK: Lifecycle
  
  override open func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = .clear
    foregroundView.backgroundColor = Color.whiteColor
    foregroundView.layer.cornerRadius = 10
    foregroundView.layer.masksToBounds = true
    setupViews()
  }
  
  override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
    // durations count equal it itemCount
    let durations = [0.33, 0.26, 0.26] // timing animation for each view
    return durations[itemIndex]
  }
  
  
  // MARK: Layout
  
  private func setupViews() {
    dateLabel.textColor = Color.darkerText
    weekDayLabel.textColor = Color.darkText
    transactionsLabel.textColor = Color.darkText
    expenseLabel.textColor = Color.darkText
    separateLineView.backgroundColor = Color.darkText
    transactionsValueLabel.textColor = Color.darkerText
    expenseValueLabel.textColor = Color.darkerText
    transactionTypesLabel.textColor = Color.darkText
    leftBorderView.backgroundColor = Color.lightOrange
  }
  
  
}
