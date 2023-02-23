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
    lazy var deleteControl: UIControl = lazyDeleteControl()
    lazy var addControl: UIView = lazyAddControl()
    
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
        containerView.addSubview(deleteControl)
        containerView.addSubview(addControl)
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top)
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
        deleteControl.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-5)
            make.height.equalTo(24)
        }
        addControl.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(containerView)
            make.width.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setter
    var isEditing: Bool? {
        didSet {
            if let edit = isEditing, edit, let model = model, !model.isAdd {
                deleteControl.isHidden = false
            }else {
                deleteControl.isHidden = true
            }
        }
    }
    
    var model: HomeCategoryItemModel? {
        didSet {
            // 如果没有模型，那么就隐藏所有内容
            guard let model = model else {
                containerView.isHidden = true
                return
            }
            containerView.isHidden = false
            addControl.isHidden = !model.isAdd
            centerView.isHidden = model.isAdd
            if !model.isAdd {
                titleLabel.text = model.name
                iconLabel.text = model.icon
                moneyLabel.attributedText = model.money.formatterMoneyStyle()
                containerView.backgroundColor = .color(fromHexString: model.color as NSString?)
            }
        }
    }
    
    
    // MARK: - Lazy
    private func lazyContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .main1Color
        view.layer.cornerRadius = 12
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
        return label
    }
    
    private func lazyDeleteControl() -> UIControl {
        let control = UIControl()
        control.layer.cornerRadius = 12
        control.layer.masksToBounds = false
        control.backgroundColor = .red_color
        control.layer.shadowColor = UIColor.black.cgColor
        control.layer.shadowOffset = .zero
        control.layer.shadowRadius = 1
        control.layer.shadowOpacity = 0.6
        control.isHidden = true
        return control
    }
    
    private func lazyAddControl() -> UIView {
        let view = UIView()
        view.isHidden = true
        let shapLayer = CALayer.addLayer(width: 20, lineWidth: 3, lineColor: .white)
        view.layer.addSublayer(shapLayer)
        return view
    }
}
