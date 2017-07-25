//
//  StasticsHeaderCell.swift
//  SaveALittle
//
//  Created by Tony Mu on 27/04/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit
import Charts

class StasticsHeaderCell: UICollectionViewCell {
  
  static let cellId = "stasticHeaderCell"
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var chartView: RadarChartView!
  
  var expenses = [Expense: Double]()
  
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
    configChart()
  }
  
  
  private func configChart(){
  
    expenses = [ Expense.Automobile: 200, Expense.BankCharges: 30, Expense.Childcare: 2032, Expense.EatOut: 1212, Expense.Education: 1500 ]
    
    let values = expenses.map{$0.value}
    let keys = expenses.map{$0.key.description}
    
    let yse1 = values.map{return RadarChartDataEntry(value: Double($0))}
    let data = RadarChartData()
    let ds1 = RadarChartDataSet(values: yse1, label: "")

    
    ds1.colors = [NSUIColor.red]
    data.addDataSet(ds1)
    
    self.chartView.data = data
    self.chartView.backgroundColor = .clear
    self.chartView.legend.enabled = false
    self.chartView.chartDescription?.text = nil
    self.chartView.xAxis.drawGridLinesEnabled = false
    self.chartView.yAxis.drawGridLinesEnabled = false
    self.chartView.yAxis.axisMinimum = 0
    self.chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values:keys)
    self.chartView.xAxis.labelTextColor = Color.lightBlue
    self.chartView.xAxis.labelFont = Font.titilliumWebLight(size: 8)
    self.chartView.yAxis.drawZeroLineEnabled = false
    self.chartView.xAxis.drawLabelsEnabled = true
    self.chartView.yAxis.drawLabelsEnabled = true
  }
}
