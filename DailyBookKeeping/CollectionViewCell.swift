//
//  CollectionViewCell.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/15.
//

import UIKit
import SnapKit
import Masonry

class CollectionViewCell: UICollectionViewCell {
    
    var containerView: UIView?
    var titleLabel: UILabel?
    var iconLabel: UILabel?
    var moneyLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .red
        
        containerView = UIView()
        containerView?.backgroundColor = .rgbColor(r: 51, g: 53, b: 86)
        containerView?.layer.cornerRadius = 14
        containerView?.layer.shadowColor = UIColor.rgbColor(r: 0, g: 0, b: 0, a: 0.8).cgColor
        containerView?.layer.shadowOffset = .zero
        containerView?.layer.shadowRadius = 1
        containerView?.layer.shadowOpacity = 0.5
        self.contentView.addSubview(containerView!)
        containerView?.mas_makeConstraints({ make in
            make?.top.equalTo()(self.contentView.mas_top)?.offset()(5)
            make?.left.equalTo()(self.contentView.mas_left)
            make?.right.equalTo()(self.contentView.mas_right)
            make?.bottom.equalTo()(self.contentView.mas_bottom)?.offset()(-5)
        })
        
//        let centerView = UIView()
//        centerView.backgroundColor = .gray
//        containerView?.addSubview(centerView)
//
//        titleLabel = UILabel()
//        titleLabel?.textColor = .white
//        titleLabel?.font = .f_m_13
//        titleLabel?.text = "餐饮"
//        centerView.addSubview(titleLabel!)
//
//        titleLabel?.mas_makeConstraints({ make in
//            make?.top.equalTo()(centerView.mas_top)
//            make?.left.equalTo()(centerView.mas_left)
//            make?.right.equalTo()(centerView.mas_right)
//            make?.height.equalTo()(13)
//            make?.bottom.equalTo()(centerView.mas_bottom)
//        })
//
//        centerView.mas_makeConstraints { make in
//            make?.top.mas_lessThanOrEqualTo()(containerView?.mas_top)
//            make?.left.equalTo()(containerView?.mas_left)
//            make?.right.equalTo()(containerView?.mas_right)
//            make?.centerY.equalTo()(containerView?.mas_centerY)
//            make?.bottom.mas_greaterThanOrEqualTo()(containerView?.mas_bottom)
//        }
        
//        iconLabel = UILabel()
//        iconLabel?.font = .f_m_13
//        iconLabel?.text = "🍚"
//        centerView.addSubview(iconLabel!)
//        iconLabel?.mas_makeConstraints({ make in
//            make?.top.equalTo()(titleLabel?.mas_bottom)
//            make?.left.equalTo()(centerView.mas_left)
//            make?.right.equalTo()(centerView.mas_right)
//            make?.height.equalTo()(13)
//            make?.bottom.equalTo()(centerView.mas_bottom)
//        })

//        moneyLabel = UILabel()
//        moneyLabel?.font = .jdBoldFont(size: 13)
//        moneyLabel?.text = "29292"
//        centerView.addSubview(moneyLabel!)
//        moneyLabel?.mas_makeConstraints({ make in
//            make?.top.equalTo()(iconLabel?.mas_bottom)
//            make?.left.equalTo()(centerView.mas_left)
//            make?.right.equalTo()(centerView.mas_right)
//            make?.height.equalTo()(13)
//            make?.bottom.equalTo()(centerView.mas_bottom)
//        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
