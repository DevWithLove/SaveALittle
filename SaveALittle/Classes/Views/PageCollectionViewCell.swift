//
//  PageCollectionViewCell.swift
//  SaveALittle
//
//  Created by Tony Mu on 19/01/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        // To make the image scale propley for the view
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    let lineSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()
    
    var page: Page? {
        didSet {
            guard let page = page else {
                return
            }
            setImage(imageName: page.imageName)
            setContent(title: page.title, message: page.message)
        }
    }
    
    
    // MARK: Lifecycle
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparatorView)
        
        makeViewConstraints()
    }
    
    private func makeViewConstraints() {
        
        imageView.anchorToTop(topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        
        textView.anchorWithConstantsToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        lineSeparatorView.anchorToTop(nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        
        lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    // MARK: Helpers
    
    private func setImage(imageName: String) {
        var name = imageName
        if UIDevice.current.orientation.isLandscape {
            name += "_landscape"
        }
        imageView.image = UIImage(named: name)
    }
    
    private func setContent(title: String , message: String) {
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium), NSForegroundColorAttributeName: Color.textColor])
        
        attributedText.append(NSAttributedString(string: "\n\n\(message)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14), NSForegroundColorAttributeName: Color.textColor]))
        
        let paragraphyStyle = NSMutableParagraphStyle()
        paragraphyStyle.alignment = .center
        
        let length = attributedText.string.characters.count
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphyStyle,range: NSRange(location: 0, length: length))
        
        textView.attributedText = attributedText
    }
    
}
