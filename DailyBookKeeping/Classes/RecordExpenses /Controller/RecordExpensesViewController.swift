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
    lazy var moneyTF: UITextField = lazyMoneyTextField()
    
    override func placeSubViews() {
        self.view.backgroundColor = .mainColor
        
        self.view.addSubview(titleBar)
        self.view.addSubview(moneyTF)
        titleBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(50)
        }
        moneyTF.snp.makeConstraints { make in
            make.top.equalTo(titleBar.snp.bottom).offset(10)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
        }
    }
    
    func save() {
        let result = DataTable.share.insert(imoney: moneyTF.text!, icategory: (model?.categoryId)!)
        if result && refreshBlock != nil {
            refreshBlock!()
        }
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

    private func lazyMoneyTextField() -> UITextField {
        let textField = UITextField()
        textField.font = .f_m_14
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString.init(string: "请输入金额", attributes: [.font: UIFont.f_l_14, .foregroundColor: UIColor.main2Color])
        return textField
    }
}
