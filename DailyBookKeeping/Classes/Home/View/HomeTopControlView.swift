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
}

class HomeTopControlView: UIView {

    weak var delegate: HomeTopControlViewDelegate?
    
    private lazy var timeControl: UIControl = lazyTimeControl()
    private lazy var timeArrow: UIView = lazyTimeArrow()
    private lazy var timeLabel: UILabel = lazyTimeLabel()
    private lazy var historyControl: UIControl = lazyHistoryControl()
    
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
        historyControl.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(50)
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
        let view = UIView(frame: .init(x: 0, y: 0, width: 15, height: 15))
        let shaperLayer = CALayer.arrowLayer(width: 15, lineWidth: 2, isLeft: false)
        view.layer.addSublayer(shaperLayer)
        return view
    }
    
    private func lazyHistoryControl() -> UIControl {
        let control = UIControl()
        control.addTarget(self, action: #selector(historyControlTap), for: .touchUpInside)
        let shaperLayer = CAShapeLayer()
        shaperLayer.frame = CGRect(x: 13, y: 13, width: 24, height: 24)
        shaperLayer.strokeColor = UIColor.title_color.cgColor
        shaperLayer.fillColor = UIColor.clear.cgColor
        shaperLayer.lineWidth = 1.5
        shaperLayer.lineCap = .round
        let bezierPath = UIBezierPath()
        bezierPath.addArc(withCenter: CGPoint(x: 12, y: 12), radius: 8, startAngle: 0, endAngle: .pi*2, clockwise: true)
        bezierPath.move(to: CGPoint(x: 12, y: 8))
        bezierPath.addLine(to: CGPoint(x: 12, y: 12))
        bezierPath.addLine(to: CGPoint(x: 15, y: 13.5))
        shaperLayer.path = bezierPath.cgPath
        control.layer.addSublayer(shaperLayer)
        return control
    }
}
