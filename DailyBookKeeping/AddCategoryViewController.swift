//
//  AddCategoryViewController.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/17.
//

import UIKit
import SnapKit

class AddCategoryViewController: BaseViewController {

    var closure: ((_ text1: String, _ text2: String) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .mainColor
        
        self.view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
        
        self.view.addSubview(textField1)
        textField1.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(15)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
        
        self.view.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(textField1.snp.bottom).offset(15)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
    }
    
    @objc func buttonTap(_ sender: UIButton) {
        if closure != nil {
            closure(textField.text!, textField1.text!)
        }
        self.dismiss(animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    // MARK: - getter
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .mainColor
        textField.font = .f_m_13
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var textField1: UITextField = {
        let textField = UITextField()
        textField.textColor = .mainColor
        textField.font = .f_m_13
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("添加", for: .normal)
        button.titleLabel?.font = .f_m_15
        button.setTitleColor(.mainColor, for: .normal)
        button.addTarget(self, action: #selector(buttonTap(_ :)), for: .touchUpInside)
        return button
    }()

}
