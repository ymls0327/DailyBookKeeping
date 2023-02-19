//
//  HomeViewController.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/17.
//

import UIKit
import WidgetKit
import SnapKit
import SQLite
import MJExtension

class HomeViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    lazy var navBar: UIView = lazyNavBar()
    lazy var leftButton: UIButton = lazyLeftButton()
    lazy var rightButton: UIButton = lazyRightButton()
    lazy var centerButton: UIButton = lazyCenterButton()
    lazy var collectionView: UICollectionView = lazyCollectionView()
    lazy var addCategoryButton: UIControl = lazyAddCategoryButton()
    lazy var navAddButton: UIControl = lazyNavAddButtonButton()
    lazy var dataList = Array<HomeCategoryItemModel>()
    
    private lazy var viewModel = HomeViewModel()
    
    // MARK: - page life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 获取数据，刷新列表
        self.requestNewDatas()
    }
    
    // MARK: - collectionView's delegate & dataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCollectionViewCell
        cell.refreshCellWithModel(dataList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recordExpenses = RecordExpensesViewController()
        recordExpenses.model = dataList[indexPath.item]
        recordExpenses.refreshBlock = {
            self.requestNewDatas()
        }
        self.present(recordExpenses, animated: true)
    }
    
    // MARK: - inner method
    override func placeSubViews() {
        
        self.view.backgroundColor = .mainColor
        self.navigationController?.navigationBar.isHidden = true
        
        self.view.addSubview(navBar)
        self.navBar.addSubview(leftButton)
        self.navBar.addSubview(centerButton)
        self.navBar.addSubview(rightButton)
        self.navBar.addSubview(navAddButton)
        self.view.addSubview(collectionView)
        self.view.addSubview(addCategoryButton)
        
        navBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.view)
            if isIPhoneX() {
                make.height.equalTo(88)
            }else {
                make.height.equalTo(64)
            }
        }
        centerButton.snp.makeConstraints { make in
            make.centerX.bottom.equalTo(navBar)
            make.height.equalTo(44)
        }
        leftButton.snp.makeConstraints { make in
            make.bottom.equalTo(navBar.snp.bottom)
            make.right.equalTo(centerButton.snp.left)
            make.width.equalTo(40)
            make.height.equalTo(44)
        }
        rightButton.snp.makeConstraints { make in
            make.bottom.equalTo(navBar.snp.bottom)
            make.left.equalTo(centerButton.snp.right)
            make.width.equalTo(40)
            make.height.equalTo(44)
        }
        navAddButton.snp.makeConstraints { make in
            make.right.bottom.equalTo(navBar)
            make.height.equalTo(44)
            make.width.equalTo(50)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom).offset(5)
            make.left.right.bottom.equalTo(self.view)
        }
        addCategoryButton.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(self.view)
        }
    }
    
    private func requestNewDatas() {
        dataList = viewModel.requestDatas()
        addCategoryButton.isHidden = dataList.count > 0
        navAddButton.isHidden = !addCategoryButton.isHidden
        let userDefault = UserDefaults.init(suiteName: "group.com.dailybook")
        userDefault?.setValue(viewModel.totalMoney ?? "", forKey: "totalMoney")
        userDefault?.setValue(viewModel.widgetList ?? [], forKey: "items")
        userDefault?.synchronize()
        WidgetCenter.shared.reloadAllTimelines()
        collectionView.reloadData()
    }
    
    @objc private func addCategoryButtonTap(_ sender: UIButton) {
        let addCategory = AddCategoryViewController()
        addCategory.refreshBlock = {
            self.requestNewDatas()
        }
        self.present(addCategory, animated: true)
    }

    // MARK: - Lazy
    private func lazyNavBar() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        return UIView()
    }
    
    private func lazyLeftButton() -> UIButton {
        let button = UIButton.init(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(named: "arrow_left_img"), for: .normal)
        return button
    }
    
    private func lazyCenterButton() -> UIButton {
        let button = UIButton.init(type: .system)
        button.titleLabel?.font = .f_m_17
        button.setTitleColor(.white, for: .normal)
        button.setTitle("今年", for: .normal)
        return button
    }
    
    private func lazyRightButton() -> UIButton {
        let button = UIButton.init(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(named: "arrow_right_img"), for: .normal)
        return button
    }
    
    private func lazyAddCategoryButton() -> UIControl {
        let button = UIButton.init(type: .system)
        button.addTarget(self, action: #selector(addCategoryButtonTap), for: .touchUpInside)
        
        let imageView = UIImageView(image: UIImage(named: "no_data_img"))
        button.addSubview(imageView)
    
        let label = UILabel()
        label.text = "点击添加一个分类"
        label.font = .f_m_12
        label.textColor = .white
        button.addSubview(label)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(button.snp.centerX)
            make.centerY.equalTo(button.snp.centerY).offset(-50)
            make.width.height.equalTo(80)
        }
        label.snp.makeConstraints { make in
            make.centerX.equalTo(button.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.height.equalTo(20)
        }
        return button
    }
    
    private func lazyNavAddButtonButton() -> UIButton {
        let button = UIButton.init(type: .system)
        button.setImage(UIImage.init(named: "nav_add_btn_img"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addCategoryButtonTap), for: .touchUpInside)
        return button
    }
    
    private func lazyCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (kScreenWidth-100)/4, height: (kScreenWidth-100)/4*1.5)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.bounces = true
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        }
        return collectionView
    }
}
