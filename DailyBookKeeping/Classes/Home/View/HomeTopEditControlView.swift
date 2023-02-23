//
//  HomeTopEditControlView.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/23.
//

import UIKit

class HomeTopEditControlView: UIView {

    private lazy var titleLabel: UILabel = lazyTitleLabel()
    private lazy var finishControl: UIControl = lazyFinishControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        placeSubViews()
    }
    
    private func placeSubViews() {
        addSubview(titleLabel)
        addSubview(finishControl)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.bottom.top.equalTo(self)
        }
        finishControl.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.right.equalTo(-5)
            make.bottom.equalTo(0)
            make.width.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lazy
    private func lazyTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "编辑"
        label.textColor = .title_color
        label.font = .f_sb_(30)
        return label
    }
    
    private func lazyFinishControl() -> UIControl {
        let control = UIControl()
        let shaperLayer = CALayer.finishLayer(width: 20)
        shaperLayer.origin(x: 10, y: 15)
        control.layer.addSublayer(shaperLayer)
        return control
    }
}
