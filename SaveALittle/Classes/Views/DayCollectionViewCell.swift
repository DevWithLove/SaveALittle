//
//  DayCollectionViewCell.swift
//  SaveALittle
//
//  Created by Tony Mu on 5/02/17.
//  Copyright © 2017 DevWithLove.com. All rights reserved.
//

import UIKit
import SwiftDate

class DayCollectionViewCell: UICollectionViewCell {
    
    static let cellId = String(describing: type(of: DayCollectionViewCell.self))
    
    var type: DayCellDataType? {
        didSet{
            if type == .noSelectedable {
                ghostDayStyle()
                return
            }
            noSelectedStyle()
        }
    }
    
    var date: DateInRegion? {
        didSet{
            guard let theDate = date else {
                return
            }
            
            self.dateLable.text = theDate.day.description
            self.weekDayLable.text = theDate.shortWeekdayName.uppercased()
        }
    }
    
    let weekDayLable: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.TitilliumWeb.light.withSize(10)
        lable.textAlignment = .center
        lable.textColor = Color.gray_26.value
        return lable
    }()
    
    let dateLable: UILabel = {
        let lable = UILabel()
        lable.textAlignment = .center
        lable.font = UIFont.TitilliumWeb.regular.withSize(15)
        lable.textColor = Color.white.value
        return lable
    }()
    
    let lineView: UIView = {
        let lv = UIView(frame: .zero)
        lv.backgroundColor = Color.orange_08.value
        lv.layer.cornerRadius = 1
        lv.layer.masksToBounds = true
        return lv
    }()
    
    // MARK: Life Cycle
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Layout
    
    func selectedStyle(){
        
        guard type != .noSelectedable else {
            return
        }
        
        dateLable.textColor = Color.white.value
        lineView.isHidden = false
    }
    
    func noSelectedStyle(){
        
        guard type != .noSelectedable else {
            return
        }
        
        dateLable.textColor = Color.white.value
        lineView.isHidden = true
    }
    
    func ghostDayStyle(){
        dateLable.textColor = Color.gray_26.value
        lineView.isHidden = true
    }
    
    
    private func setupViews(){
        backgroundColor = .clear
        addSubview(lineView)
        addSubview(weekDayLable)
        addSubview(dateLable)
        
        _ = weekDayLable.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 12, rightConstant: 0, widthConstant: 0, heightConstant: 10)
        
        _ = dateLable.anchor(nil, left: leftAnchor, bottom: weekDayLable.topAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 10, rightConstant: 0, widthConstant: 0, heightConstant: 13)
        
        _ = lineView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 12, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 2)
    }
    
    
}
