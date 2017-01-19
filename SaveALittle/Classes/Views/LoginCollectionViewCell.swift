//
//  LoginCollectionViewCell.swift
//  SaveALittle
//
//  Created by Tony Mu on 19/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit

class LoginCollectionViewCell: UICollectionViewCell {
    
    //   weak var delegate: LoginControllerDelegate?
    
    let logoImageView: UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let emailTextFiled: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.placeholder = "Enter email"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let passwordTextFiled: LeftPaddedTextField = {
        let textField = LeftPaddedTextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Enter password"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    
    
    
    // MARK: Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(logoImageView)
        addSubview(emailTextFiled)
        addSubview(passwordTextFiled)
        addSubview(loginButton)
        
        _ = logoImageView.anchor(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -230, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
        
        logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        _ = emailTextFiled.anchor(logoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 45)
        
        _ = passwordTextFiled.anchor(emailTextFiled.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 45)
        
        _ = loginButton.anchor(passwordTextFiled.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 45)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: User Interaction
    
    func handleLogin() {
        //delegate?.finishLoggingIn()
    }
    
    
}
