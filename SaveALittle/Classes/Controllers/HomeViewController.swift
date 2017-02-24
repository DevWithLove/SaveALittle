//
//  HomeViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 20/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import SwiftDate

class HomeViewController: BaseViewController {
    
    let borderColor = Color.darkLine
    let borderWidth: CGFloat = 0.5
    let usageViewTopConstant: CGFloat = 20.0
    let dayCellWidth: CGFloat = 50
    
    let days = DayCollectionDataSource(offsetDays: 4)
    var selectedDate = DateInRegion().startOfDay
    let dailyDataSource = DailyDataSource.shared
    
    
    private var usageViewleftConstant: CGFloat {
        return self.view.bounds.width / 4.3
    }
    
    let headerLeftView: WeekHeaderView = {
        let nib = UINib(nibName: "WeekHeaderView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! WeekHeaderView
        return view
    }()
    
    let headerMeddileView: WeekHeaderView = {
        let nib = UINib(nibName: "WeekHeaderView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! WeekHeaderView
        return view
    }()
    
    let headerRightView: WeekHeaderView = {
        let nib = UINib(nibName: "WeekHeaderView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! WeekHeaderView
        return view
    }()
    
    let usageProgressView: UsageProgressView = {
        let nib = UINib(nibName: "UsageProgressView", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UsageProgressView
        return view
    }()
    
    let seperateLineView: UIView = {
        let cv = UIView(frame: .zero)
        return cv
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        let nib = UINib(nibName: "TransactionTableViewCell", bundle: nil)
        tv.register(nib, forCellReuseIdentifier: TransactionTableViewCell.cellId)
        tv.separatorStyle = .none
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        return tv
    }()
    
    lazy var dayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: DayCollectionViewCell.cellId)
        return cv
    }()
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        // Register notification run everytime when app will enter foreground.
        NotificationCenter.default.addObserver(self, selector: #selector(enterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dailyDataSource.reload()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupSeperateLine()
        showLoginView()
        usageProgressView.refresh(usage: 80)
        
        refreshDayCollectionView()
        
        // Scroll the selected to the current date
        let indexPath = IndexPath(item: days.lastSelectableIndex!, section: 0)
        scrollToDate(indexPath: indexPath)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Layout
    
    private func setupViews() {
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(headerLeftView)
        view.addSubview(headerRightView)
        view.addSubview(headerMeddileView)
        view.addSubview(usageProgressView)
        view.addSubview(tableView)
        view.addSubview(seperateLineView)
        view.addSubview(dayCollectionView)
        
        addViewConstraints()
        
        headerLeftView.setBottomBorder(color: borderColor, borderWidth: borderWidth)
        headerLeftView.setRightBorder(color: borderColor, borderWidth: borderWidth)
        headerMeddileView.setBottomBorder(color: borderColor, borderWidth: borderWidth)
        headerRightView.setBottomBorder(color: borderColor, borderWidth: borderWidth)
        headerRightView.setLeftBorder(color: borderColor, borderWidth: borderWidth)
    }
    
    private func addViewConstraints() {
        let headerViewHeight = view.bounds.size.width / 3
        let usageViewHeight = view.bounds.size.width - (usageViewleftConstant * 2)
        
        _ = headerLeftView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: headerViewHeight , heightConstant: headerViewHeight)
        
        _ = headerRightView.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: headerViewHeight , heightConstant: headerViewHeight)
        
        _ = headerMeddileView.anchor(view.topAnchor, left: headerLeftView.rightAnchor, bottom: nil, right: headerRightView.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: headerViewHeight)
        
        _ = usageProgressView.anchor(headerMeddileView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: usageViewTopConstant, leftConstant: usageViewleftConstant, bottomConstant: 0, rightConstant: usageViewleftConstant, widthConstant: 0, heightConstant: usageViewHeight)
        
        _ = dayCollectionView.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 70)
        
        _ = tableView.anchor(usageProgressView.bottomAnchor, left: view.leftAnchor, bottom: dayCollectionView.topAnchor, right: view.rightAnchor, topConstant: 15
            , leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        _ = seperateLineView.anchor(nil, left: view.leftAnchor, bottom: dayCollectionView.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
    }
    
    
    
    // MARK: Additional Helpers
    
    private func showLoginView() {
        guard !UserDefaults.standard.isLoggedIn() else {
            return
        }
        performSegue(withIdentifier: "LoginView", sender: self)
    }
    
    private func setupSeperateLine(){
        let gradient = CAGradientLayer()
        gradient.frame = seperateLineView.bounds
        gradient.colors = [Color.darkBackgroundWith05alpha.cgColor, Color.darkerBackground.cgColor]
        seperateLineView.backgroundColor = .clear
        gradient.locations = [0.0, 1.0]
        seperateLineView.layer.insertSublayer(gradient, at: 0)
    }
    
    
    fileprivate func getSelectedIndexPath()-> IndexPath {
        let xFinal = self.dayCollectionView.contentOffset.x + (self.view.frame.size.width / 2)
        var viewIndex = Int(floor(xFinal / self.dayCellWidth))
        
        if viewIndex < 0 { viewIndex = 0 }
        if viewIndex > days.count - 1 { viewIndex = days.count - 1 }
        
        let dayCell = days[viewIndex]
        
        guard dayCell.type == .noSelectedable else {
            return IndexPath(item: viewIndex, section: 0)
        }
        
        guard dayCell.date.isInFuture else {
            return IndexPath(item: days.firstSelectableIndex!, section: 0)
        }
        
        return IndexPath(item:days.lastSelectableIndex!, section: 0)
    }
    
    fileprivate func scrollToDate(indexPath: IndexPath) {
        selectedDate = days[indexPath.item].date
        tableView.reloadData()
        dayCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    fileprivate func centerDayCollectionView() {
        let indexPath = getSelectedIndexPath()
        scrollToDate(indexPath: indexPath)
    }
    
    private func refreshDayCollectionView() {
        // TODO: if the current changed to pass date,(e.g. time zone change), refresh as well
        
        // If today is not in the day collection, refresh the day collection
        guard days.getIndex(date: DateInRegion().startOfDay) == nil else {
            return
        }
        
        days.reload()
        dayCollectionView.reloadData()
        let indexPath = IndexPath(item: days.lastSelectableIndex!, section: 0)
        dayCollectionView.scrollToItem(at:indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    // MARK: Notification
    
    func enterForeground(noftification:NSNotification){
        refreshDayCollectionView()
    }
    
    
}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let selectedDayData = dailyDataSource[selectedDate.absoluteDate] else {
            return 0
        }
        return selectedDayData.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.cellId, for: indexPath) as! TransactionTableViewCell
        cell.transaction =  dailyDataSource[selectedDate.absoluteDate]?.transactions[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.cellId, for: indexPath) as! DayCollectionViewCell
        let day = days[indexPath.item]
        cell.date = day.date
        cell.type = day.type
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: dayCellWidth, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard days[indexPath.item].type != .noSelectedable else {
            return
        }
        scrollToDate(indexPath: indexPath)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let indexPath = self.getSelectedIndexPath()
        
        if let cell = dayCollectionView.cellForItem(at: indexPath) as? DayCollectionViewCell {
            cell.selectedStyle()
        }
        
        if let cell = dayCollectionView.cellForItem(at: IndexPath(item: indexPath.item + 1, section: 0)) as? DayCollectionViewCell {
            cell.noSelectedStyle()
        }
        
        if let cell = dayCollectionView.cellForItem(at: IndexPath(item: indexPath.item - 1, section: 0)) as? DayCollectionViewCell {
            cell.noSelectedStyle()
        }
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //    var targetX = targetContentOffset.pointee.x + (view.frame.size.width / 2)
        //    let targetIndex = floor(targetX / dayCellWidth)
        //    targetX = targetIndex * dayCellWidth + (view.frame.size.width / 2) + (dayCellWidth / 2)
        //
        //    print("targetx: \(targetX)")
        //    print("targetIndex: \(targetIndex)")
        //
        //    targetContentOffset.pointee.x = targetX
        //    let newPoint = CGPoint(x: CGFloat(newTargetOffset), y: 0)
        //    scrollView.setContentOffset(newPoint, animated: true)
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            centerDayCollectionView()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        centerDayCollectionView()
    }
}


extension HomeViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}





