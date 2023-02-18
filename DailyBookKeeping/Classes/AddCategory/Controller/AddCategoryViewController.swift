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
    var refreshBlock: (() -> Void)?
    
    lazy var titleBar: CommonNavBarView = lazyTitleBar()
    lazy var nameBox: UIView = lazyNameBox()
    lazy var iconBox: UIView = lazyIconBox()
    lazy var colorBox: UIView = lazyColorBox()
    
    var categoryNameTF: UITextField!
    var categoryIconTF: UITextField!
    var categoryColorButton: UIColorWell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .mainColor
    }
    
    override func placeSubViews() {
        self.view.addSubview(titleBar)
        self.view.addSubview(nameBox)
        self.view.addSubview(iconBox)
        self.view.addSubview(colorBox)
        
        titleBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(50)
        }
        nameBox.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(titleBar.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        iconBox.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(nameBox.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
        colorBox.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            make.top.equalTo(iconBox.snp.bottom).offset(10)
            make.height.equalTo(50)
        }
    }
    
    func save() {
        guard categoryNameTF.text!.count > 0 else {
            debugPrint("名称必须填写")
            return
        }
        guard categoryIconTF.text!.count > 0 else {
            debugPrint("请选择一个图标")
            return
        }
        let result = CategoryTable.share.add(name: categoryNameTF.text!, icon: categoryIconTF.text!, color: (categoryColorButton.selectedColor?.hex())!)
        if (result && refreshBlock != nil) {
            refreshBlock!()
        }
        self.dismiss(animated: true)
    }
    
    func close() {
        self.dismiss(animated: true)
    }
    
    // MARK: - Lazy
    private func lazyTitleBar() -> CommonNavBarView {
        let view = CommonNavBarView(frame: .zero, title: "分类")
        view.saveBlock = {
            self.save()
        }
        view.closeBlock = {
            self.close()
        }
        return view
    }
    
    private func lazyNameBox() -> UIView {
        let view = UIView()
        
        let label = UILabel()
        label.text = "名称"
        label.textColor = .white
        label.font = .f_l_14
        view.addSubview(label)
        
        let textField = UITextField()
        textField.textColor = .white
        textField.font = .f_l_14
        textField.textAlignment = .right
        textField.delegate = self
        view.addSubview(textField)
        categoryNameTF = textField
        
        let attributePlaceHodler = NSAttributedString.init(string: "请输入分类名称", attributes: [.font: UIFont.f_l_14, .foregroundColor: UIColor.main2Color])
        textField.attributedPlaceholder = attributePlaceHodler
        
        let line = UIView()
        line.backgroundColor = .main2Color
        view.addSubview(line)
        
        label.snp.makeConstraints { make in
            make.top.bottom.equalTo(view)
            make.left.equalTo(18)
            make.width.equalTo(80)
        }
        textField.snp.makeConstraints { make in
            make.top.bottom.equalTo(view)
            make.right.equalTo(-20)
            make.left.equalTo(label.snp.right)
        }
        line.snp.makeConstraints { make in
            make.left.equalTo(18)
            make.right.equalTo(-20)
            make.bottom.equalTo(0)
            make.height.equalTo(0.5)
        }
        return view
    }
    
    private func lazyIconBox() -> UIView {
        let view = UIView()
        
        let label = UILabel()
        label.text = "图标"
        label.textColor = .white
        label.font = .f_l_14
        view.addSubview(label)
        
        let textField = UITextField()
        textField.font = .f_l_14
        textField.textAlignment = .right
        view.addSubview(textField)
        
        categoryIconTF = textField
        
        let attributePlaceHodler = NSAttributedString.init(string: "请输入emoji图标", attributes: [.font: UIFont.f_l_14, .foregroundColor: UIColor.main2Color])
        textField.attributedPlaceholder = attributePlaceHodler
        
        let line = UIView()
        line.backgroundColor = .main2Color
        view.addSubview(line)
        
        label.snp.makeConstraints { make in
            make.top.bottom.equalTo(view)
            make.left.equalTo(18)
            make.width.equalTo(80)
        }
        categoryIconTF.snp.makeConstraints { make in
            make.top.bottom.equalTo(view)
            make.right.equalTo(-20)
            make.left.equalTo(label.snp.right)
        }
        line.snp.makeConstraints { make in
            make.left.equalTo(18)
            make.right.equalTo(-20)
            make.bottom.equalTo(0)
            make.height.equalTo(0.5)
        }
        return view
    }

    private func lazyColorBox() -> UIView {
        let view = UIView()
        
        let label = UILabel()
        label.text = "颜色"
        label.textColor = .white
        label.font = .f_l_14
        view.addSubview(label)
        
        let button = UIColorWell()
        button.backgroundColor = .clear
        button.supportsAlpha = false
        button.selectedColor = .main1Color
        view.addSubview(button)
        
        categoryColorButton = button
        
        let line = UIView()
        line.backgroundColor = .main2Color
        view.addSubview(line)
        
        label.snp.makeConstraints { make in
            make.top.bottom.equalTo(view)
            make.left.equalTo(18)
            make.width.equalTo(80)
        }
        button.snp.makeConstraints { make in
            make.centerY.equalTo(view.snp.centerY)
            make.right.equalTo(-20)
            make.width.height.equalTo(40)
        }
        line.snp.makeConstraints { make in
            make.left.equalTo(18)
            make.right.equalTo(-20)
            make.bottom.equalTo(0)
            make.height.equalTo(0.5)
        }
        return view
    }
}
