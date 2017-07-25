//
//  MonthViewHeaderCell.swift
//  SaveALittle
//
//  Created by Tony Mu on 26/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit
import Charts
import SwiftDate

class MonthHeaderCell: UICollectionViewCell {
  
  static let cellId = "monthHeaderCell"
  
  @IBOutlet weak var monthLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var incomeValueLabel: UILabel!
  @IBOutlet weak var expenseValueLabel: UILabel!
  @IBOutlet weak var firstDayLabel: UILabel!
  @IBOutlet weak var lastDayLabel: UILabel!
  @IBOutlet weak var lineChartView: LineChartView!
  
  var data: MonthlyData? {
    didSet{
      guard let data = data else {
        return
      }
      
      self.monthLabel.text = data.firstDay.monthName
      self.yearLabel.text = data.firstDay.year.description
      self.lastDayLabel.text = data.firstDay.monthDays.description
      
      incomeValueLabel.text = data.days.sum({ (dailyData) -> Double in
        dailyData.totalIncome
      }).toCurrency
      
      expenseValueLabel.text = data.days.sum({ (dailyData) -> Double in
        dailyData.totalExpense
      }).toCurrency
      
      loadChartData(expense: data.expenses())
    }
  }
  
  
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
    lastDayLabel.layer.cornerRadius = 10
    firstDayLabel.layer.masksToBounds = true
    lastDayLabel.layer.masksToBounds = true
  }
  
  private func loadChartData(expense:[Double]) {
    
    var dataEntries = [ChartDataEntry]()
    
    for i in 0 ..< expense.count {
      dataEntries.append(ChartDataEntry(x: Double(i), y: expense[i]))
    }
    
    let dataSet = LineChartDataSet(values: dataEntries, label: "")
    dataSet.axisDependency = .left
    dataSet.setColor(Color.orange_08.value)
    dataSet.drawCirclesEnabled = false
    dataSet.drawValuesEnabled = false
    dataSet.lineWidth = 1.5
    dataSet.highlightEnabled = false
    dataSet.mode = .cubicBezier
    
    let gradientColors = [Color.orange_08.value.cgColor, UIColor.clear.cgColor] as CFArray
    let colorLocations:[CGFloat] = [1.0, 0.0]
    let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
    
    dataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
    dataSet.drawFilledEnabled = true
    let chartData = LineChartData(dataSet: dataSet)
    configChart(data: chartData)
    
  }
  
  
  private func configChart(data: LineChartData) {
    
    lineChartView.data = data
    lineChartView.setScaleEnabled(false)
    lineChartView.rightAxis.drawAxisLineEnabled = false
    lineChartView.leftAxis.drawAxisLineEnabled = false
    lineChartView.leftAxis.drawLabelsEnabled = false
    lineChartView.rightAxis.drawLabelsEnabled = false
    lineChartView.backgroundColor = Color.black_29.value
    lineChartView.xAxis.drawAxisLineEnabled = false
    lineChartView.xAxis.drawGridLinesEnabled = false
    lineChartView.leftAxis.drawAxisLineEnabled = false
    lineChartView.rightAxis.drawAxisLineEnabled = false
    lineChartView.leftAxis.drawGridLinesEnabled = false
    lineChartView.rightAxis.drawGridLinesEnabled = false
    lineChartView.chartDescription?.text = nil
    lineChartView.xAxis.labelPosition = .bottom
    lineChartView.legend.enabled = false
    lineChartView.xAxis.drawLabelsEnabled = false
    
    lineChartView.animate(xAxisDuration: 1, easingOption: .easeInOutQuart)
  }
  
}
