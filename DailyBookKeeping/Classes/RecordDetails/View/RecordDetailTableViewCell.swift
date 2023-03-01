//
//  RecordDetailTableViewCell.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/3/1.
//

import UIKit
import SnapKit

class RecordDetailTableViewCell: UITableViewCell {
    
    var icon: String = "" {
        didSet {
            iconLabel.text = icon
        }
    }
    
    var category: String = "" {
        didSet {
            titleLabel.text = category
        }
    }
    
    var remark: String = "" {
        didSet {
            remarkLabel.text = remark
            if remark.isEmpty {
                remarkLabel.snp.updateConstraints { make in
                    make.height.equalTo(0)
                }
            }else {
                remarkLabel.snp.updateConstraints { make in
                    make.height.equalTo(20)
                }
            }
        }
    }
    
    var money: String = "" {
        didSet {
            moneyLabel.attributedText = money.formatterMoneyStyle(small: 12, large: 16)
        }
    }
    
    var time: String = "" {
        didSet {
            timeLabel.text = time
        }
    }
    
    private lazy var iconLabel: UILabel = {
        let label = UILabel()
        label.font = .f_r_(25)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .f_m_(14)
        label.textColor = .title_color
        return label
    }()
    
    private lazy var remarkLabel: UILabel = {
        let label = UILabel()
        label.font = .f_r_(12)
        label.textColor = .sub_title_color
        return label
    }()
    
    private lazy var rightBox: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var moneyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .red_color
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .f_l_(11)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .sub_title_color
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(iconLabel)
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(remarkLabel)
        contentView.addSubview(rightBox)
        rightBox.addSubview(moneyLabel)
        rightBox.addSubview(timeLabel)
        
        iconLabel.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.width.height.equalTo(30)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        rightBox.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(contentView.snp.top)
            make.right.equalTo(contentView.snp.right).offset(-15)
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(120)
        }
        moneyLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(rightBox)
            make.height.equalTo(20)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(moneyLabel.snp.bottom)
            make.bottom.left.right.equalTo(rightBox)
            make.height.equalTo(20)
        }
        containerView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(contentView.snp.top)
            make.left.equalTo(iconLabel.snp.right).offset(15)
            make.right.equalTo(rightBox.snp.left)
            make.bottom.lessThanOrEqualTo(contentView.snp.bottom)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.right.top.equalTo(containerView)
            make.height.equalTo(20)
        }
        remarkLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(containerView)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
