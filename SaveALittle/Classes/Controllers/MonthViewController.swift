//
//  MonthViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 1/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit
import FoldingCell
import SwiftDate

fileprivate struct C {
  struct CellHeight {
    static let close: CGFloat = 140 // equal or greater foregroundView height
    static let open: CGFloat = 370 // equal or greater containerView height
  }
}

class MonthViewController: BaseViewController {
  
  let kCloseCellHeight: CGFloat = 140
  let kOpenCellHeight: CGFloat = 370
  
  var cellHeights = (0..<31).map { _ in C.CellHeight.close }
  
  let dailyDataSource = DailyDataSource.shared
  var monthlyData = [MonthlyData]()
  var currentMonth: MonthlyData?
  
  let separatorLineView: UIView = {
    let lineView = UIView()
    lineView.backgroundColor = Color.gray_15.value
    return lineView
  }()
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .clear
    cv.dataSource = self
    cv.delegate = self
    cv.isPagingEnabled = true
    let nib = UINib(nibName: "MonthHeaderCellView", bundle: nil)
    cv.register(nib, forCellWithReuseIdentifier: MonthHeaderCell.cellId)
    return cv
  }()
  
  lazy var tableView: UITableView = {
    let tv = UITableView(frame: .zero, style: .plain)
    tv.backgroundColor = .clear
    tv.dataSource = self
    tv.delegate = self
    let nib = UINib(nibName: "DailyTableViewCellView", bundle: nil)
    tv.register(nib, forCellReuseIdentifier: DailyTableViewCell.cellId)
    tv.separatorStyle = .none
    return tv
  }()
  
  
  // MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    refreshView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    scrollToFirstMonth()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: Layout
  
  private func setupViews() {
    self.automaticallyAdjustsScrollViewInsets = false
    view.addSubview(collectionView)
    view.addSubview(separatorLineView)
    view.addSubview(tableView)
    
    addViewConstraints()
  }
  
  private func addViewConstraints() {
    _ = collectionView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 180)
    
    _ = separatorLineView.anchor(collectionView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
    
    _ = tableView.anchor(separatorLineView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
  }
  
  private func refreshView(){
    dailyDataSource.reload()
    monthlyData = dailyDataSource.groupedByMonth()
    collectionView.reloadData()
  }
  
  // MARK: Additional Helpers
  
  fileprivate func scrollToFirstMonth() {
    guard let firstMonth = monthlyData.first else {
      return
    }
    currentMonth = firstMonth
    tableView.reloadData()
    let firstMonthIndexPath = IndexPath(item: 0, section: 0)
    collectionView.scrollToItem(at: firstMonthIndexPath, at: .centeredHorizontally, animated: true)
  }
  
  fileprivate func updateSelectedMonth() {
    
    guard !monthlyData.isEmpty else {
      return
    }
    
    let xFinal = self.collectionView.contentOffset.x + (self.view.frame.size.width)
    let viewIndex = Int(floor(xFinal / self.view.frame.size.width)) - 1
    currentMonth = monthlyData[viewIndex]
    tableView.reloadData()
  }
}


extension MonthViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return monthlyData.count
  }
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthHeaderCell.cellId, for: indexPath) as! MonthHeaderCell
    currentMonth = monthlyData[indexPath.item]
    cell.data = currentMonth
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }
  
  //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
  //        return UIEdgeInsetsMake(0, 0, 0, 0)
  //    }
}

extension MonthViewController: UIScrollViewDelegate {
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if !decelerate {
      updateSelectedMonth()
    }
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    updateSelectedMonth()
  }
}

extension MonthViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentMonth?.days.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellHeights[indexPath.item]
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.cellId, for: indexPath) as! DailyTableViewCell
    cell.dailyData = currentMonth?.days[indexPath.item]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    guard case let cell as FoldingCell = tableView.cellForRow(at: indexPath) else {
      return
    }
    
    var duration = 0.0
    if cellHeights[indexPath.row] == kCloseCellHeight { // open cell
      cellHeights[indexPath.row] = kOpenCellHeight
      cell.unfold(true, animated: true, completion: nil)
      duration = 0.5
    } else {// close cell
      cellHeights[indexPath.row] = kCloseCellHeight
      cell.unfold(false, animated: true, completion: nil)
      duration = 1.1
    }
    
    UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { _ in
      tableView.beginUpdates()
      tableView.endUpdates()
    }, completion: nil)
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard case let cell as DailyTableViewCell = cell  else {
      return
    }
    
    if cellHeights[indexPath.item] == kCloseCellHeight
    {
      cell.unfold(false, animated: false, completion: nil)
    } else {
      cell.unfold(true, animated: false, completion: nil)
    }
  }
}
