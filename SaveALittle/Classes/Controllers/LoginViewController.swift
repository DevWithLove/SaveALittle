//
//  ViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 18/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let pageCellId = "pageCellId"
    let loginCellId = "loginCellId"
    
    var pageControllBottomAnchor: NSLayoutConstraint?
    var skipButtonTopAnchor: NSLayoutConstraint?
    var nextButtonTopAnchor: NSLayoutConstraint?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = Color.whiteColor
        cv.isPagingEnabled = true
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = Color.orangeColor
        pc.pageIndicatorTintColor = .lightGray
        pc.numberOfPages = self.pages.count + 1
        return pc
    }()
    
    lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(Color.orangeColor, for: .normal)
        button.addTarget(self, action: #selector(skipPage), for: .touchUpInside)
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(Color.orangeColor, for: .normal)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        return button
    }()
    
    let pages:[Page] = {
        
        let firstPage = Page(title: "Share a great listen", message: "It's free to send your books to the people in your life. Every recepient's first book is on us.", imageName: "page1")
        
        let secondPage = Page(title: "Send from your library", message: "It's free to send your books to the people in your life. Every recepient's first book is on us.", imageName: "page1")
        
        let thirdPage = Page(title: "Page three", message: "It's free to send your books to the people in your life. Every recepient's first book is on us.", imageName: "page1")
        
        return [firstPage, secondPage, thirdPage]
    }()
    
    
    // MARK: Lifecycle
    
    // Custom initializers go here
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        //scroll to indexpath after the rotation is going
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.collectionView.reloadData()
        }
    }
    
    // MARK: Layout
    
    private func setupViews() {
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        makeViewConstraints()
        registerCollectionViewCells()
    }
    
    private func makeViewConstraints() {
        pageControllBottomAnchor = pageControl.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 40)[1]
        
        skipButtonTopAnchor = skipButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
        
        nextButtonTopAnchor = nextButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 50).first
        
        collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    private func registerCollectionViewCells() {
        collectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: pageCellId)
        collectionView.register(LoginCollectionViewCell.self, forCellWithReuseIdentifier: loginCellId)
    }
    
    // MARK: User Interaction
    
    func skipPage() {
        pageControl.currentPage = pages.count - 1
        nextPage()
    }
    
    func nextPage() {
        
        guard pageControl.currentPage < pages.count else {
            return
        }
        // the second last page
        if pageControl.currentPage == pages.count - 1 {
            moveControlConstraintsOffScreen()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                // This method need to be called when we make constraint changes
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        let indexPath = IndexPath(item: pageControl.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath , at: .centeredHorizontally, animated: true)
        pageControl.currentPage += 1
    }
    
    
    func keyboardShow() {
        
        // Not the best solution
        
        let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -50
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    func keyboardHide() {
        // Not the best solution
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    
    
    // MARK: Additional Helpers
    
    fileprivate func moveControlConstraintsOffScreen() {
        pageControllBottomAnchor?.constant = 40
        skipButtonTopAnchor?.constant = -40
        nextButtonTopAnchor?.constant = -40
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

extension LoginViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCollectionViewCell
           //loginCell.delegate = self
            return loginCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pageCellId, for: indexPath) as! PageCollectionViewCell
        
        cell.page = pages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage =  pageNumber
        
        // we are on the last page
        if pageNumber == pages.count {
            moveControlConstraintsOffScreen()
        } else {
            pageControllBottomAnchor?.constant = 0
            skipButtonTopAnchor?.constant = 16
            nextButtonTopAnchor?.constant = 16
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            // This method need to be called when we make constraint changes
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // every time scroll the view, hide keyboard
        view.endEditing(true)
    }
    
}
