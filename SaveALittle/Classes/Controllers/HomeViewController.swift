//
//  HomeViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 20/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class HomeViewController: BaseViewController {
    
    let borderColor = Color.darkLine
    let borderWidth: CGFloat = 0.5
    let usageViewTopConstant: CGFloat = 20.0
    
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
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showLoginView()
        usageProgressView.refresh(usage: 80)
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
        
        _ = headerLeftView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: headerViewHeight , heightConstant: headerViewHeight)
        
        _ = headerRightView.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: headerViewHeight , heightConstant: headerViewHeight)
        
        _ = headerMeddileView.anchor(view.topAnchor, left: headerLeftView.rightAnchor, bottom: nil, right: headerRightView.leftAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: headerViewHeight)
        
        _ = usageProgressView.anchor(headerMeddileView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: usageViewTopConstant, leftConstant: usageViewleftConstant, bottomConstant: 0, rightConstant: usageViewleftConstant, widthConstant: 0, heightConstant: usageViewHeight)
        
        _ = tableView.anchor(usageProgressView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 20
            , leftConstant: 10, bottomConstant: 50, rightConstant: 10, widthConstant: 0, heightConstant: 0)
    }
    
    
    
    // MARK: Additional Helpers
    
    private func showLoginView() {
        guard !UserDefaults.standard.isLoggedIn() else {
            return
        }
        performSegue(withIdentifier: "LoginView", sender: self)
    }
}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.cellId, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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





