//
//  RecordExpensesViewController.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/18.
//

import UIKit
import SnapKit
import SwifterSwift

class RecordExpensesViewController: BaseViewController {

    var model: HomeCategoryItemModel?
    var refreshBlock: (() -> Void)?
    
    private lazy var keyBoardCollectionView: UICollectionView = lazyKeyBoardCollectionView()
    
    override func placeSubViews() {
        title = model?.name
        view.backgroundColor = .white
        
        view.addSubview(keyBoardCollectionView)
        
        keyBoardCollectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            if (isIPhoneX()) {
                make.height.equalTo(252)
            }else {
                make.height.equalTo(238)
            }
        }
    }

    // MARK: - Lazy
    private func lazyKeyBoardCollectionView() -> UICollectionView {
        let view = UICollectionView()
        view.backgroundColor = .white
        view.addShadow(ofColor: .gray, radius: 3, offset: .zero, opacity: 0.1)
        return view
    }
    
    
    private func lazyMoneyLabel() -> UILabel {
        let label = UILabel()
        label.text = "￥"
        label.font = .f_m_(22)
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
