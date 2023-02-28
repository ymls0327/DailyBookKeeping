//
//  HomeCollectionReusableHeaderView.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/27.
//

import UIKit

class HomeCollectionReusableHeaderView: UICollectionReusableView {
    
    private lazy var moneyControl: UIControl = lazyMoneyControl()
    private lazy var moneyLabel: UILabel = lazyMoneyLabel()
    private lazy var tempLabel: UILabel = lazyTempLabel()
    
    var totalMoney: String? {
        didSet {
            if let money = totalMoney, !money.isEmpty {
                let attribute = NSMutableAttributedString()
                attribute.append(money.formatterMoneyStyle(small: 14, large: 18))
                moneyLabel.attributedText = attribute
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(moneyControl)
        moneyControl.addSubview(tempLabel)
        moneyControl.addSubview(moneyLabel)
        
        tempLabel.snp.makeConstraints { make in
            make.left.equalTo(moneyControl.snp.left).offset(3)
            make.centerY.equalTo(moneyControl.snp.centerY).offset(1)
        }
        moneyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(moneyControl.snp.centerY)
            make.left.equalTo(tempLabel.snp.right)
            make.right.equalTo(moneyControl.snp.right).offset(-3)
        }
        
        moneyControl.snp.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.centerX.equalTo(self.snp.centerX)
            make.left.greaterThanOrEqualTo(self.snp.left)
            make.right.lessThanOrEqualTo(self.snp.right)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func lazyMoneyControl() -> UIControl {
        let control = UIControl()
        return control
    }
    
    private func lazyMoneyLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .title_color
        return label
    }
    
    private func lazyTempLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .title_color
        let attribute = NSMutableAttributedString.init(string: "总支出:")
        attribute.addAttributes([.font: UIFont.f_r_(12)], range: NSRange(location: 0, length: 4))
        label.attributedText = attribute
        return label
    }
}
