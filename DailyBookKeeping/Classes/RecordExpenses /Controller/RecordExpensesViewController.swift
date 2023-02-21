//
//  RecordExpensesViewController.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/18.
//

import UIKit
import SnapKit

class RecordExpensesViewController: BaseViewController {

    var model: HomeCategoryItemModel?
    var refreshBlock: (() -> Void)?
    
    lazy var titleBar: CommonNavBarView = lazyTitleBar()
    lazy var moneyLabel: UILabel = lazyMoneyLabel()
    lazy var moneyTF: UITextField = lazyMoneyTextField()
    
    override func placeSubViews() {
        self.view.backgroundColor = .mainColor
        
        self.view.addSubview(titleBar)
        self.view.addSubview(moneyTF)
        self.view.addSubview(moneyLabel)
        titleBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(50)
        }
        moneyTF.snp.makeConstraints { make in
            make.top.equalTo(titleBar.snp.bottom).offset(30)
            make.left.equalTo(moneyLabel.snp.right)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
        moneyLabel.snp.makeConstraints { make in
            make.bottom.equalTo(moneyTF.snp.bottom).offset(-6)
            make.left.equalTo(20)
            make.width.height.equalTo(30)
        }
    }
    
    func save() {
        self.dismiss(animated: true)
    }
    
    func close() {
        self.dismiss(animated: true)
    }

    // MARK: - Lazy
    private func lazyTitleBar() -> CommonNavBarView {
        let view = CommonNavBarView(frame: .zero, title: "记账")
        view.saveBlock = {
            self.save()
        }
        view.closeBlock = {
            self.close()
        }
        return view
    }
    
    private func lazyMoneyLabel() -> UILabel {
        let label = UILabel()
        label.text = "￥"
        label.font = .f_m_22
        label.textColor = .main2Color
        return label
    }

    private func lazyMoneyTextField() -> UITextField {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 30, weight: .semibold)
        textField.textColor = .white
        textField.keyboardType = .decimalPad
        textField.tintColor = .white
        textField.attributedPlaceholder = NSAttributedString.init(string: "请输入金额", attributes: [.font: UIFont.systemFont(ofSize: 30), .foregroundColor: UIColor.main2Color])
        return textField
    }
}
