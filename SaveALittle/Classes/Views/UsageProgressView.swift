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
        topLabel.font = Font.titilliumWebRegular(size: 15)
        bottomLabel.font = Font.titilliumWebLight(size: 11)
        
        
        usageProgressRingView.delegate = self
        usageProgressRingView.maxValue = 100
        usageProgressRingView.ringStyle = .ontop
        usageProgressRingView.outerRingColor = Color.darkerBackground
        usageProgressRingView.outerCapStyle = .round
        usageProgressRingView.outerRingWidth = 10
        usageProgressRingView.innerCapStyle = .round
        usageProgressRingView.innerRingColor = Color.lightOrange
        usageProgressRingView.innerRingWidth = 9
        usageProgressRingView.startAngle = -240
        usageProgressRingView.endAngle = 62
        usageProgressRingView.fullCircle = false
        usageProgressRingView.valueIndicator = " %"
        usageProgressRingView.fontColor = Color.whiteColor
        usageProgressRingView.font = Font.titilliumWebLight(size: 16)
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
