//
//  StasticsViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 27/04/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit

class StasticsViewController: BaseViewController {
  
  
  let separatorLineView: UIView = {
    let lineView = UIView()
    lineView.backgroundColor = Color.darkLine
    return lineView
  }()
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .clear
    cv.isPagingEnabled = true
    cv.dataSource = self
    cv.delegate = self
    let nib = UINib(nibName: "StasticsHeaderCellView", bundle: nil)
    cv.register(nib, forCellWithReuseIdentifier: StasticsHeaderCell.cellId)
    return cv
  }()
  
  
  
  // MARK: View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
  // MARK: Layout
  
  private func setupViews() {
    self.automaticallyAdjustsScrollViewInsets = false
    view.addSubview(collectionView)
    view.addSubview(separatorLineView)
    
    addViewConstraints()
  }
  
  private func addViewConstraints() {
    _ = collectionView.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 280)
    
    _ = separatorLineView.anchor(collectionView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
    
  }
  
}


extension StasticsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StasticsHeaderCell.cellId, for: indexPath) as! StasticsHeaderCell
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }

}
