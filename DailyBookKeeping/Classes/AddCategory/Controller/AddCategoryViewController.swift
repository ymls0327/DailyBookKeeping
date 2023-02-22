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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func placeSubViews() {
       
    }
    
    // MARK: - Lazy
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
