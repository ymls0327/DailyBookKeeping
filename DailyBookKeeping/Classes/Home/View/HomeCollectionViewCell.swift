//
//  HomeCollectionViewCell.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/17.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    lazy var containerView: UIView = lazyContainerView()
    lazy var centerView: UIView = lazyCenterView()
    lazy var titleLabel: UILabel = lazyTitleLabel()
    lazy var iconLabel: UILabel = lazyIconLabel()
    lazy var moneyLabel: UILabel = lazyMoneyLabel()
    
    private var itemModel: HomeCategoryItemModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.placeSubViews()
    }
    
    private func placeSubViews() {
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
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.right.equalTo(centerView)
            make.height.equalTo(30)
        }
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(iconLabel.snp.bottom).offset(5)
            make.left.right.bottom.equalTo(centerView)
            make.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func refreshCellWithModel(_ model: HomeCategoryItemModel) {
        itemModel = model
        titleLabel.text = model.categoryName
        iconLabel.text = model.categoryIcon
        moneyLabel.attributedText = model.money!.formatterMoneyStyle()
        containerView.backgroundColor = .color(fromHexString: model.categoryColor as NSString?)
    }
    
    // MARK: - Lazy
    private func lazyContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .main1Color
        view.layer.cornerRadius = 6
        view.layer.shadowColor = UIColor.rgbColor(r: 0, g: 0, b: 0, a: 0.8).cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 0.5
        return view
    }
    
    private func lazyCenterView() -> UIView {
        let view = UIView()
        return view
    }
    
    private func lazyTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.font = .f_m_13
        label.textAlignment = .center
        return label
    }
    
    private func lazyIconLabel() -> UILabel {
        let label = UILabel()
        label.font = .f_r_25
        label.textAlignment = .center
        return label
    }
    
    private func lazyMoneyLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
//        let attri = NSMutableAttributedString.init(string: "￥7893.99")
//        attri.addAttributes([NSAttributedString.Key.font : UIFont.jdBoldFont(size: 8)], range: NSRange(location: 0, length: 1))
//        attri.addAttributes([NSAttributedString.Key.font : UIFont.jdBoldFont(size: 13)], range: NSMakeRange(1, 4))
//        attri.addAttributes([NSAttributedString.Key.font : UIFont.jdBoldFont(size: 8)], range: NSMakeRange(5, 3))
//        label.attributedText = attri
        
        return label
    }
    
}
