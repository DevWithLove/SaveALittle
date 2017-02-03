//
//  UsageProgressView.swift
//  SaveALittle
//
//  Created by Tony Mu on 4/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit
import UICircularProgressRing

class UsageProgressView: UIView, UICircularProgressRingDelegate {

    @IBOutlet weak var usageProgressRingView: UICircularProgressRingView!
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var bottomLabel: UILabel!
    
    // MARK: Life Cycle
    override open func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    // MARK: Layout
    private func setupViews(){
        backgroundColor = .clear
        lineView.layer.cornerRadius = 1
        lineView.layer.masksToBounds = true
        lineView.backgroundColor = Color.darkerBackground
        
        
        usageProgressRingView.delegate = self
        usageProgressRingView.maxValue = 100
        usageProgressRingView.viewStyle = 2
        usageProgressRingView.outerRingColor = Color.darkerBackground
        usageProgressRingView.outerRingCapStyle = 2
        usageProgressRingView.outerRingWidth = 10
        usageProgressRingView.innerRingCapStyle = 2
        usageProgressRingView.innerRingColor = Color.lightOrange
        usageProgressRingView.innerRingWidth = 9
        usageProgressRingView.startAngle = -240
        usageProgressRingView.endAngle = 62
        usageProgressRingView.valueIndicator = " %"
        usageProgressRingView.fontColor = Color.whiteColor
        usageProgressRingView.customFontWithName = "OpenSans-Bold"
        usageProgressRingView.fontSize = 20
    }

    func finishedUpdatingProgress(forRing ring: UICircularProgressRingView) {
        if ring === self.usageProgressRingView {
            print("From delegate: Ring 1 finished")
        }
    }
    
    func refresh(usage: CGFloat){
        usageProgressRingView.setProgress(value: usage, animationDuration: 2)
    }
}
