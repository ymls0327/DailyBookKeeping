//
//  AddCategoryViewController.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/17.
//

import UIKit
import SnapKit

class AddCategoryViewController: BaseViewController, UITextFieldDelegate {
    
    // 刷新回调
    open var refreshBlock: (() -> Void)?
    
    lazy var containerView: UIView = lazyContainerView()
    lazy var shadowView: UIView = lazyShadowView()
    lazy var centerView: UIView = lazyCenterView()
    lazy var titleTextField: UITextField = lazyTitleTextField()
    lazy var tempTextField: UITextField = lazyTempTextField()
    lazy var iconLabel: UILabel = lazyIconLabel()
    lazy var moneyLabel: UILabel = lazyMoneyLabel()
    lazy var colorWell: UIColorWell = lazyColorWell()
    lazy var finishControl: UIControl = lazyFinishControl()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    
    override func placeSubViews() {
       
        title = "添加分类"
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.addSubview(finishControl)
        
        view.addSubview(shadowView)
        view.addSubview(containerView)
        containerView.addSubview(centerView)
        containerView.addSubview(tempTextField)
        centerView.addSubview(titleTextField)
        centerView.addSubview(iconLabel)
        centerView.addSubview(moneyLabel)
        view.addSubview(colorWell)
        
        shadowView.snp.makeConstraints { make in
            make.top.equalTo(25)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
        containerView.snp.makeConstraints { make in
            make.top.equalTo(25)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(100)
            make.height.equalTo(150)
        }
        centerView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(containerView.snp.top)
            make.left.equalTo(containerView.snp.left).offset(2)
            make.centerY.equalTo(containerView.snp.centerY)
            make.right.equalTo(containerView.snp.right).offset(-2)
            make.bottom.lessThanOrEqualTo(containerView.snp.bottom)
        }
        titleTextField.snp.makeConstraints { make in
            make.top.left.right.equalTo(centerView)
            make.height.equalTo(30)
        }
        iconLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.left.right.equalTo(centerView)
            make.height.equalTo(40)
        }
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(iconLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(centerView)
            make.height.equalTo(30)
        }
        colorWell.snp.makeConstraints { make in
            make.centerX.equalTo(containerView.snp.right).offset(-2)
            make.centerY.equalTo(containerView.snp.top).offset(2)
            make.width.height.equalTo(30)
        }
    }
    
    @objc func colorWellValueChanged() {
        containerView.backgroundColor = colorWell.selectedColor?.withAlphaComponent(0.3)
        shadowView.layer.shadowColor = colorWell.selectedColor?.withAlphaComponent(0.4).cgColor
    }
    
    @objc func iconLabelTap() {
        titleTextField.endEditing(false)
        tempTextField.becomeFirstResponder()
    }
    
    @objc func finishControlTap() {
        view.endEditing(true)
        // 检查分类名称
        guard let categoryName = titleTextField.text, !categoryName.isEmpty else {
            DBProgressHUD.show(message: "请输入分类名称", overlay: false)
            return
        }
        guard let selectColor = colorWell.selectedColor else {
            DBProgressHUD.show(message: "请选择颜色", overlay: false)
            return
        }
        guard let colorHex = selectColor.hex(), !colorHex.isEmpty else {
            DBProgressHUD.show(message: "颜色转换失败", overlay: false)
            return
        }
        guard let icon = iconLabel.text, !icon.isEmpty else {
            DBProgressHUD.show(message: "请选择一个心仪的图标", overlay: false)
            return
        }
        // 存储分类
        if DBManager.share.insert_into_category_table_with(name: categoryName, color: colorHex, icon: icon) {
            DBProgressHUD.show(message: "添加成功", overlay: false)
            refreshBlock?()
            reset()
        }
    }
    
    private func reset() {
        titleTextField.text = ""
        iconLabel.text = "😁"
        colorWell.selectedColor = nil
        containerView.backgroundColor = .white
        shadowView.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
    }
    
    // MARK: - Lazy
    private func lazyShadowView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.6
        return view
    }
    
    private func lazyContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.roundCorners(.allCorners, rect: CGRect(x: 0, y: 0, width: 100, height: 150), radius: 16)
        return view
    }
    
    private func lazyCenterView() -> UIView {
        let view = UIView()
        return view
    }
    
    private func lazyTitleTextField() -> UITextField {
        let textField = UITextField()
        textField.textColor = .title_color
        textField.font = .f_m_(18)
        textField.attributedPlaceholder = NSAttributedString.init(string: "分类名称", attributes: [.font: UIFont.f_m_(18), .foregroundColor: UIColor.sub_title_color])
        textField.textAlignment = .center
        return textField
    }
    
    private func lazyIconLabel() -> UILabel {
        let label = UILabel()
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(iconLabelTap)))
        label.isUserInteractionEnabled = true
        label.font = .f_r_(35)
        label.textAlignment = .center
        label.text = "😄"
        return label
    }
    
    private func lazyTempTextField() -> UITextField {
        let textField = UITextField()
        textField.isHidden = true
        textField.inputView = lazyIconSelectInputView()
        return textField
    }
    
    private func lazyColorWell() -> UIColorWell {
        let well = UIColorWell()
        well.addTarget(self, action: #selector(colorWellValueChanged), for: .valueChanged)
        well.supportsAlpha = false
        well.backgroundColor = .clear
        return well
    }
    
    private func lazyMoneyLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .title_color
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        let attributedText = NSMutableAttributedString.init(string: "￥0.00")
        attributedText.addAttributes([.font: UIFont.jdBoldFont(size: 14)], range: NSRange(location: 0, length: 1))
        attributedText.addAttributes([.font: UIFont.jdBoldFont(size: 22)], range: NSRange(location: 1, length: 1))
        attributedText.addAttributes([.font: UIFont.jdBoldFont(size: 14)], range: NSRange(location: 2, length: 3))
        label.attributedText = attributedText
        return label
    }
    
    private func lazyIconSelectInputView() -> IconSelectInputView {
        let selectView = IconSelectInputView()
        selectView.didSelectEmojiWithComplete = { [weak self] emoji in
            self?.iconLabel.text = emoji
        }
        return selectView
    }
    
    private func lazyFinishControl() -> UIControl {
        let control = UIControl(frame: CGRect(x: kScreenWidth-45, y: 0, width: 40, height: 44))
        control.addTarget(self, action: #selector(finishControlTap), for: .touchUpInside)
        let shaperLayer = CALayer.finishLayer(width: 20)
        shaperLayer.origin(x: 12, y: 12)
        control.layer.addSublayer(shaperLayer)
        return control
    }
}
