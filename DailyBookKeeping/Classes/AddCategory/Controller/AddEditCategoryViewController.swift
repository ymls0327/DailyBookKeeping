//
//  AddEditCategoryViewController.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/17.
//

import UIKit
import SnapKit

class AddEditCategoryViewController: BaseViewController, UITextFieldDelegate {
    
    open var categoryModel: HomeCategoryItemModel?
    
    lazy var containerView: UIView = lazyContainerView()
    lazy var shadowView: UIView = lazyShadowView()
    lazy var centerView: UIView = lazyCenterView()
    lazy var titleTextField: UITextField = lazyTitleTextField()
    lazy var emojiControl: AddCategoryEmojiControl = lazyEmojiControl()
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
        centerView.addSubview(titleTextField)
        centerView.addSubview(emojiControl)
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
        emojiControl.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(10)
            make.left.right.equalTo(centerView)
            make.height.equalTo(40)
        }
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(emojiControl.snp.bottom).offset(10)
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
        guard let icon = emojiControl.content, !icon.isEmpty else {
            DBProgressHUD.show(message: "请选择一个心仪的图标", overlay: false)
            return
        }
        // 存储分类
        if DBManager.share.update_insert_into_category_table_with(id: categoryModel?.categoryId, name: categoryName, color: colorHex, icon: icon) {
            if let model = categoryModel, model.isAdd {
                AlertController.alert(with: self, title: "添加成功", message: "您可以点击”继续添加“，来添加更多分类", cancleTitle: "取消", confirmTitle: "继续添加", confirmBlock: { [weak self] in
                    self?.reset()
                }, cancleBlock: { [weak self] in
                    self?.navigationController?.popViewController()
                })
            }else {
                DBProgressHUD.show(message: "修改成功", duration: 1, complete: { [weak self] in
                    self?.navigationController?.popViewController()
                })
            }
        }
    }
    
    @objc func emojiControlTap() {
        emojiControl.becomeFirstResponder()
    }
    
    private func reset() {
        emojiControl.reset()
        titleTextField.text = ""
        colorWell.selectedColor = nil
        containerView.backgroundColor = .white
        shadowView.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emojiControl.resignFirstResponder()
    }
    
    // MARK: - Lazy
    private func lazyShadowView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.6
        if let model = categoryModel, !model.color.isEmpty {
            view.layer.shadowColor = UIColor.color(fromHexString: model.color as NSString).withAlphaComponent(0.4).cgColor
        }else {
            view.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        }
        return view
    }
    
    private func lazyContainerView() -> UIView {
        let view = UIView()
        if let model = categoryModel, !model.color.isEmpty {
            view.backgroundColor = UIColor.color(fromHexString: model.color as NSString).withAlphaComponent(0.3)
        }else {
            view.backgroundColor = .white
        }
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
        textField.text = categoryModel?.name
        textField.attributedPlaceholder = NSAttributedString.init(string: "分类名称", attributes: [.font: UIFont.f_m_(18), .foregroundColor: UIColor.sub_title_color])
        textField.textAlignment = .center
        return textField
    }
    
    private func lazyEmojiControl() -> AddCategoryEmojiControl {
        let control = AddCategoryEmojiControl()
        control.addTarget(self, action: #selector(emojiControlTap), for: .touchUpInside)
        control.content = categoryModel?.icon
        return control
    }
    
    private func lazyColorWell() -> UIColorWell {
        let well = UIColorWell()
        well.addTarget(self, action: #selector(colorWellValueChanged), for: .valueChanged)
        well.supportsAlpha = false
        well.backgroundColor = .clear
        if let model = categoryModel, !model.color.isEmpty {
            well.selectedColor = UIColor.color(fromHexString: model.color as NSString)
        }
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
    
    private func lazyFinishControl() -> UIControl {
        let control = UIControl(frame: CGRect(x: kScreenWidth-45, y: 0, width: 40, height: 44))
        control.addTarget(self, action: #selector(finishControlTap), for: .touchUpInside)
        let shaperLayer = CALayer.finishLayer(width: 20)
        shaperLayer.origin(x: 12, y: 12)
        control.layer.addSublayer(shaperLayer)
        return control
    }
}
