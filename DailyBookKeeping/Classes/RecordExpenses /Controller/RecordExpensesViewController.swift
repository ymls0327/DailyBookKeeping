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
    
    override func placeSubViews() {
        title = model?.name
        
    }

    // MARK: - Lazy
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
