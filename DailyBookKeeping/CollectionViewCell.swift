//
//  CollectionViewCell.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/15.
//

import UIKit
import SnapKit
import SQLite

class CollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(containerView)
        containerView.addSubview(centerView)
        centerView.addSubview(titleLabel)
        centerView.addSubview(iconLabel)
        centerView.addSubview(moneyLabel)
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top).offset(5)
            make.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView.snp.bottom)
        }
        centerView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(containerView.snp.top)
            make.left.equalTo(containerView.snp.left).offset(2)
            make.centerY.equalTo(containerView.snp.centerY)
            make.right.equalTo(containerView.snp.right).offset(-2)
            make.bottom.lessThanOrEqualTo(containerView.snp.bottom)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(centerView)
            make.height.equalTo(20)
        }
        iconLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.right.equalTo(centerView)
            make.height.equalTo(20)
        }
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(iconLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(centerView)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Getter & Setter
    private var model: Row!
    var item: Row {
        set {
            model = newValue
            titleLabel.text = try? model.get(CategoryTable.share.categoryName)
            iconLabel.text = try? model.get(CategoryTable.share.iconUrl)
        }
        get {
            model
        }
    }
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .rgbColor(r: 51, g: 53, b: 86)
        containerView.layer.cornerRadius = 6
        containerView.layer.shadowColor = UIColor.rgbColor(r: 0, g: 0, b: 0, a: 0.8).cgColor
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 1
        containerView.layer.shadowOpacity = 0.5
        return containerView
    }()
    lazy var centerView: UIView = {
        let centerView = UIView()
        return centerView
    }()
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .white
        titleLabel.font = .f_m_13
        titleLabel.textAlignment = .center
        titleLabel.text = "餐饮"
        return titleLabel
    }()
    lazy var iconLabel: UILabel = {
        let iconLabel = UILabel()
        iconLabel.font = .f_m_16
        iconLabel.text = "🤹‍♂️"
        iconLabel.textAlignment = .center
        return iconLabel
    }()
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textColor = .white
        moneyLabel.font = .jdBoldFont(size: 13)
        moneyLabel.textAlignment = .center
        moneyLabel.adjustsFontSizeToFitWidth = true
        
        let attri = NSMutableAttributedString.init(string: "￥7893.99")
        attri.addAttributes([NSAttributedString.Key.font : UIFont.jdBoldFont(size: 8)], range: NSRange(location: 0, length: 1))
        attri.addAttributes([NSAttributedString.Key.font : UIFont.jdBoldFont(size: 13)], range: NSMakeRange(1, 4))
        attri.addAttributes([NSAttributedString.Key.font : UIFont.jdBoldFont(size: 8)], range: NSMakeRange(5, 3))
        moneyLabel.attributedText = attri
        
        return moneyLabel
    }()
}
