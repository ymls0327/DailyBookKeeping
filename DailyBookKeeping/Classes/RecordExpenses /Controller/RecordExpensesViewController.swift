//
//  RecordExpensesViewController.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/18.
//

import UIKit
import SnapKit
import SwifterSwift
import IQKeyboardManagerSwift

class RecordExpensesViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate {

    var model: HomeCategoryItemModel?
    var refreshBlock: (() -> Void)?
    
    private var currentString: String = ""
    private var dataSource: [String] = []
    private lazy var keyBoardCollectionView: UICollectionView = lazyKeyBoardCollectionView()
    private lazy var remarkLabel: UILabel = lazyRemarkLabel()
    private lazy var moneyLabel: UILabel = lazyMoneyLabel()
    private lazy var remarkPopView: UIView = lazyRemarkPopView()
    private lazy var remarkTF: UITextView = lazyRemarkTF()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared.enable = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowNotification), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideNotification), name: UIApplication.keyboardWillHideNotification, object: nil)
    }
    
    override func placeSubViews() {
        title = model?.name
        view.backgroundColor = .white
        
        dataSource = ["1", "2", "3", "删除", "4", "5", "6", "备注", "7", "8", "9", "", "", "0", ".", "确定"]
        view.addSubview(moneyLabel)
        view.addSubview(remarkLabel)
        view.addSubview(keyBoardCollectionView)
        view.addSubview(remarkPopView)
        
        moneyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(50)
            make.top.equalTo(view.snp.top).offset(80)
        }
        remarkLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(moneyLabel.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        keyBoardCollectionView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view)
            if (isIPhoneX()) {
                make.height.equalTo(252)
            }else {
                make.height.equalTo(238)
            }
        }
        
        // 格式化金钱
        formatterMoney()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! KeyBoardCollectionViewCell
        cell.content = dataSource[indexPath.item]
        cell.clickBlock = { [weak self] content in
            self?.clickKeyBoard(with: content)
        }
        return cell
    }
    
    private func clickKeyBoard(with content: String) {
        if !content.isEmpty {
            if content == "删除" {
                if !currentString.isEmpty {
                    currentString = (currentString as NSString).substring(with: NSMakeRange(0, currentString.count-1))
                    formatterMoney()
                }
            }
            else if content == "确定" {
                if let money = Double(currentString), money > 0 {
                    if let model = model {
                        if DBManager.share.insert_into_data_table_with(categoryId: model.categoryId, money: currentString, remark: "") {
                            refreshBlock?()
                            navigationController?.popViewController()
                        }
                    }
                }else {
                    DBProgressHUD.show(message: "金额输入有误")
                }
            }
            else if content == "备注" {
                remarkTF.text = remarkLabel.text ?? ""
                remarkTF.becomeFirstResponder()
            }
            else {
                if content == "." {
                    if !currentString.contains(".") {
                        if currentString.isEmpty {
                            currentString = "0."
                        }else {
                            currentString += "."
                        }
                        formatterMoney()
                    }
                }else {
                    // 金钱表达式
                    let newString = currentString + content
                    let regex = "(^[1-9]([0-9]+)?(\\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\\.[0-9]([0-9])?$)"
                    do {
                        let re = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
                        let matchs = re.matches(in: newString, options: .reportProgress, range: NSRange(location: 0, length: newString.count))
                        if matchs.count > 0 {
                            currentString = newString
                            formatterMoney()
                        }
                    }catch {
                        debugPrint(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    // 格式化
    private func formatterMoney() {
        let attributedString = NSMutableAttributedString.init(string: "￥")
        attributedString.addAttributes([.font: UIFont.f_m_(30)], range: NSMakeRange(0, 1))
        guard !currentString.isEmpty else {
            moneyLabel.attributedText = attributedString
            return
        }
        let array = currentString.components(separatedBy: ".")
        if array.count == 2 {
            attributedString.append(NSAttributedString.init(string: array[0], attributes: [.font: UIFont.f_m_(50)]))
            attributedString.append(NSAttributedString.init(string: "."+array[1], attributes: [.font: UIFont.f_m_(30)]))
        }else if array.count == 1 {
            attributedString.append(NSAttributedString.init(string: array[0], attributes: [.font: UIFont.f_m_(50)]))
        }
        moneyLabel.attributedText = attributedString
    }
    
    @objc func keyboardWillShowNotification(_ notification: Notification) {
        if let userInfo = notification.userInfo, let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] {
            if let rect = (frame as AnyObject).cgRectValue {
                if isIPhoneX() {
                    remarkPopView.y = kScreenHeight - rect.size.height - 80 - 91
                }else {
                    remarkPopView.y = kScreenHeight - rect.size.height - 80
                }
            }
        }
    }
    
    @objc func keyboardWillHideNotification(_ notification: Notification) {
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            self?.remarkPopView.y = kScreenHeight
        })
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.contains("\n") {
            remarkLabel.text = textView.text
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    // MARK: - Lazy
    private func lazyKeyBoardCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (kScreenWidth-34)/4, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.delaysContentTouches = false
        collectionView.register(KeyBoardCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }
    
    private func lazyRemarkLabel() -> UILabel {
        let label = UILabel()
        label.font = .f_r_(13)
        label.textColor = .sub_title_color
        return label
    }
    
    private func lazyMoneyLabel() -> UILabel {
        let label = UILabel()
        label.font = .f_m_(60)
        label.textColor = .title_color
        return label
    }
    
    private func lazyRemarkPopView() -> UIView {
        let view = UIView.init(frame: CGRect(x: 0, y: kScreenHeight, width: kScreenWidth, height: 80))
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = 0.2
        view.addSubview(remarkTF)
        remarkTF.snp.makeConstraints { make in
            make.top.equalTo(5)
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.bottom.equalTo(-5)
        }
        return view
    }
    
    private func lazyRemarkTF() -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .title_color
        textView.font = .f_r_(14)
        textView.returnKeyType = .done
        textView.delegate = self
        return textView
    }
}
