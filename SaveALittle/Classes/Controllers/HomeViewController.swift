//
//  HomeViewController.swift
//  SaveALittle
//
//  Created by Tony Mu on 20/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showLoginView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Additional Helpers
    
    func showLoginView() {
        guard !UserDefaults.standard.isLoggedIn() else {
            return
        }
        performSegue(withIdentifier: "LoginView", sender: self)
    }
}
