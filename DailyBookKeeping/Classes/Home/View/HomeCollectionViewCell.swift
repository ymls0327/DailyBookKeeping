//
//  HomeCollectionViewCell.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/17.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    open var deleteCategoryBlockToRefresh:((_ id: Int64, _ name: String) -> Void)?
    
    lazy var containerView: UIView = lazyContainerView()
    lazy var shadowView: UIView = lazyShadowView()
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
        contentView.addSubview(shadowView)
        contentView.addSubview(containerView)
        containerView.addSubview(centerView)
        centerView.addSubview(titleLabel)
        centerView.addSubview(iconLabel)
        centerView.addSubview(moneyLabel)
        containerView.addSubview(deleteControl)
        containerView.addSubview(addControl)
        
        shadowView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView)
        }
        containerView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView)
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
            make.bottom.equalTo(-8)
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
            if model.isAdd {
                containerView.backgroundColor = .white
                shadowView.layer.shadowColor = UIColor.black.withAlphaComponent(0.3).cgColor
            }else {
                titleLabel.text = model.name
                iconLabel.text = model.icon
                moneyLabel.attributedText = model.money.formatterMoneyStyle()
                containerView.backgroundColor = .color(fromHexString: model.color as NSString?).withAlphaComponent(0.3)
                shadowView.layer.shadowColor = UIColor.color(fromHexString: model.color as NSString?).withAlphaComponent(0.4).cgColor
            }
        }
    }
    
    @objc func deleteControlTap() {
        if let model = model, model.categoryId > 0 {
            deleteCategoryBlockToRefresh?(model.categoryId, model.name)
        }
    }
    
    // MARK: - Lazy
    private func lazyShadowView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.6
        return view
    }
    
    private func lazyContainerView() -> UIView {
        let view = UIView()
        view.roundCorners(.allCorners, rect: bounds, radius: 14)
        return view
    }
    
    private func lazyCenterView() -> UIView {
        let view = UIView()
        return view
    }
    
    private func lazyTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .title_color
        label.font = .f_m_(13)
        label.textAlignment = .center
        return label
    }
    
    private func lazyIconLabel() -> UILabel {
        let label = UILabel()
        label.font = .f_r_(25)
        label.textAlignment = .center
        return label
    }
    
    private func lazyMoneyLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .title_color
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    private func lazyDeleteControl() -> UIControl {
        let control = UIControl()
        control.addTarget(self, action: #selector(deleteControlTap), for: .touchUpInside)
        control.layer.cornerRadius = 12
        control.layer.masksToBounds = false
        control.backgroundColor = .red_color
        control.layer.shadowColor = UIColor.black.cgColor
        control.layer.shadowOffset = .zero
        control.layer.shadowRadius = 1
        control.layer.shadowOpacity = 0.6
        
        let shapLayer = CALayer.deleteLayer(width: 20, lineWidth: 1.5, needleWidth: 1.5, rectColor: .white, needleColor: .white)
        shapLayer.origin(x: (frame.size.width-40)*0.5, y: 2)
        control.layer.addSublayer(shapLayer)
        
        control.isHidden = true
        return control
    }
    
    private func lazyAddControl() -> UIView {
        let view = UIView()
        view.isHidden = true
        let shapLayer = CALayer.addLayer(width: 20, lineWidth: 3, lineColor: .title_color)
        view.layer.addSublayer(shapLayer)
        return view
    }
}
