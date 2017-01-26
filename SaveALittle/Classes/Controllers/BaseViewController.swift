//
//  BaseViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 26/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    func setupNavigationBar() {
        // to remove the nav bar bottom line
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "nav_bar_background"), for: .default)
        
        // Set the status bar to white color
        UIApplication.shared.statusBarStyle = .lightContent
    }
}
