//
//  BaseViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 26/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit
import SCLAlertView

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.black_29.value
        setupNavigationBar()
        setNavigationBarItem()
    }
    
    
    // MARK: Helper Methods
    
    private func setupNavigationBar() {
        // to remove the nav bar bottom line
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "nav_bar_background"), for: .default)
        navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName:UIFont.TitilliumWeb.semiBold.withSize(18),NSForegroundColorAttributeName: Color.white.value]
        
        // Set the status bar to white color
        UIApplication.shared.statusBarStyle = .lightContent
        
        self.navigationController?.navigationBar.isTranslucent = false;
    }
    
    
    private func setNavigationBarItem() {
        self.addLeftBarButtonWithImage(#imageLiteral(resourceName: "menu"))
        // Add right button with own action
        self.addRightBarButton(#imageLiteral(resourceName: "plus"))
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
    }
    
    
    private func addRightBarButton(_ buttonImage: UIImage) {
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.addTransaction))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc private func addTransaction(){
        let alert = SCLAlertView()
        
        _ = alert.addButton("Add Expnese") {
            let transactionViewController = TransactionViewController()
            self.navigationController?.pushViewController(transactionViewController, animated: true)
        }
        
        _ = alert.addButton("Add Income") {
            let transactionViewController = TransactionViewController()
            transactionViewController.transactionType = .Income
            self.navigationController?.pushViewController(transactionViewController, animated: true)
        }
        
        
        let icon = #imageLiteral(resourceName: "shopping")
        let color = Color.orange_08.value
        
        _ = alert.showCustom("Add a transaction", subTitle: "Add Transaction", color: color, icon: icon)
    }
    
    
    //    private func removeNavigationBarItem() {
    //        self.navigationItem.leftBarButtonItem = nil
    //        self.navigationItem.rightBarButtonItem = nil
    //        self.slideMenuController()?.removeLeftGestures()
    //        self.slideMenuController()?.removeRightGestures()
    //    }
}
