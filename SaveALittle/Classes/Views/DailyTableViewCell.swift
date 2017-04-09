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
  
  @IBOutlet weak var containerDateLabel: UILabel!
  @IBOutlet weak var containerWeekDayLabel: UILabel!
  @IBOutlet weak var containerIncomeLabel: UILabel!
  @IBOutlet weak var containerExpenseLabel: UILabel!
  @IBOutlet weak var containerIncomeValueLabel: UILabel!
  @IBOutlet weak var containerExpenseValueLabel: UILabel!
  @IBOutlet weak var transactionsTableView: UITableView!
  
  
  var dailyData: DailyData? {
    didSet{
      guard let dailyData = self.dailyData else {
        return
      }
      
      dateLabel.text = dailyData.date.day.description
      weekDayLabel.text = dailyData.date.shortWeekdayName.uppercased()
      transactionsValueLabel.text = dailyData.transactions.count.description
      expenseValueLabel.text = dailyData.totalExpense.toCurrency
      
      containerDateLabel.text = dateLabel.text
      containerWeekDayLabel.text = weekDayLabel.text
      containerIncomeValueLabel.text = dailyData.totalIncome.toCurrency
      containerExpenseValueLabel.text = expenseValueLabel.text
      transactionsTableView.reloadData()
      
    }
  }
  
  // MARK: Lifecycle
  
  override open func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = .clear
    foregroundView.backgroundColor = Color.whiteColor
    foregroundView.layer.cornerRadius = 5
    foregroundView.layer.masksToBounds = true
    containerView.layer.cornerRadius = 5
    containerView.layer.masksToBounds = true
    containerView.backgroundColor = Color.whiteColor
    backViewColor = Color.whiteColor
    setupViews()
    setupTableView()
  }
  
  override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
    // durations count equal it itemCount
    let durations = [0.33, 0.26, 0.26] // timing animation for each view
    return durations[itemIndex]
  }
  
  
  // MARK: Layout
  
  private func setupViews() {
    dateLabel.textColor = Color.darkerText
    dateLabel.font = Font.titilliumWebRegular(size: 15)
    
    let titleFont = Font.titilliumWebLight(size: 10)
    let valueFont = Font.titilliumWebRegular(size: 10)
    
    weekDayLabel.textColor = Color.darkText
    weekDayLabel.font = titleFont
    
    transactionsLabel.textColor = Color.darkText
    transactionsLabel.font = titleFont
    
    expenseLabel.textColor = Color.darkText
    expenseLabel.font = titleFont
    
    transactionsValueLabel.textColor = Color.darkerText
    transactionsValueLabel.font = valueFont
    
    expenseValueLabel.textColor = Color.darkerText
    expenseValueLabel.font = valueFont
    
    transactionTypesLabel.textColor = Color.darkText
    transactionTypesLabel.font = titleFont
    
    separateLineView.backgroundColor = Color.darkText
    leftBorderView.backgroundColor = Color.lightOrange
    
    containerDateLabel.font = Font.titilliumWebRegular(size: 15)
    containerWeekDayLabel.font = titleFont
    containerIncomeLabel.font = titleFont
    containerExpenseLabel.font = titleFont
    containerExpenseValueLabel.font = valueFont
    containerIncomeValueLabel.font = valueFont
  }
  
  private func setupTableView() {
    let nib = UINib(nibName: "TransactionTableViewCell", bundle: nil)
    transactionsTableView.register(nib, forCellReuseIdentifier: TransactionTableViewCell.cellId)
    transactionsTableView.separatorStyle = .none
    transactionsTableView.delegate = self
    transactionsTableView.dataSource = self
    transactionsTableView.backgroundColor = .clear
  }
}

extension DailyTableViewCell: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dailyData?.transactions.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.cellId, for: indexPath) as! TransactionTableViewCell
    cell.transaction = dailyData?.transactions[indexPath.item];
    cell.applyLightStyle()
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }

}
