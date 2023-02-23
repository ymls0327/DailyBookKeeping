//
//  HomeTopControlView.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/23.
//

import UIKit

protocol HomeTopControlViewDelegate: AnyObject {
    
    // 点击日期
    func controlViewDidClickTimeAt(date: Date?)
    
    // 点击历史
    func controlViewDidClickHistory()
    
    // 点击编辑按钮
    func controlViewDidClickEdit()
}

class HomeTopControlView: UIView {

    weak var delegate: HomeTopControlViewDelegate?
    
    private lazy var timeControl: UIControl = lazyTimeControl()
    private lazy var timeArrow: UIView = lazyTimeArrow()
    private lazy var timeLabel: UILabel = lazyTimeLabel()
    private lazy var historyControl: UIControl = lazyHistoryControl()
    private lazy var editControl: UIControl = lazyEditControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        placeSubViews()
    }
    
    private func placeSubViews() {
        addSubview(timeControl)
        timeControl.addSubview(timeLabel)
        timeControl.addSubview(timeArrow)
        addSubview(historyControl)
        addSubview(editControl)
        
        timeControl.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.bottom.top.equalTo(self)
            make.right.equalTo(timeArrow.snp.right).offset(10)
        }
        timeLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(timeControl)
        }
        timeArrow.snp.makeConstraints { make in
            make.left.equalTo(timeLabel.snp.right).offset(3)
            make.centerY.equalTo(timeControl.snp.centerY);
            make.width.height.equalTo(15)
        }
        editControl.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.right.equalTo(-5)
            make.bottom.equalTo(0)
            make.width.equalTo(40)
        }
        historyControl.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.right.equalTo(editControl.snp.left).offset(-5)
            make.bottom.equalTo(0)
            make.width.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func timeControlTap(control: UIControl) {
        delegate?.controlViewDidClickTimeAt(date: Date())
    }
    
    @objc func historyControlTap(control: UIControl) {
        delegate?.controlViewDidClickHistory()
    }
    
    @objc func editControlTap(control: UIControl) {
        delegate?.controlViewDidClickEdit()
    }
     
    // MARK: - Lazy
    private func lazyTimeControl() -> UIControl {
        let control = UIControl()
        control.addTarget(self, action: #selector(timeControlTap), for: .touchUpInside)
        return control
    }
    
    private func lazyTimeLabel() -> UILabel {
        let label = UILabel()
        label.text = "今年"
        label.textColor = .title_color
        label.font = .f_sb_(30)
        return label
    }
    
    private func lazyTimeArrow() -> UIView {
        let view = UIView()
        let shaperLayer = CALayer.arrowLayer(width: 15, lineWidth: 2, isLeft: false)
        view.layer.addSublayer(shaperLayer)
        return view
    }
    
    private func lazyHistoryControl() -> UIControl {
        let control = UIControl()
        control.addTarget(self, action: #selector(historyControlTap), for: .touchUpInside)
        let shaperLayer = CALayer.lockLayer(width: 20)
        shaperLayer.origin(x: 10, y: 15)
        control.layer.addSublayer(shaperLayer)
        return control
    }
    
    private func lazyEditControl() -> UIControl {
        let control = UIControl()
        control.addTarget(self, action: #selector(editControlTap), for: .touchUpInside)
        let shaperLayer = CALayer.editLayer(width: 18)
        shaperLayer.origin(x: 11, y: 16)
        control.layer.addSublayer(shaperLayer)
        return control
    }
}
