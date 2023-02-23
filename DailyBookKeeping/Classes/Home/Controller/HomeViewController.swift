//
//  HomeViewController.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/17.
//

import UIKit
import SnapKit
import WidgetKit

class HomeViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, HomeTopControlViewDelegate {
    
    private lazy var navBar: UIView = lazyNavBar()
    private lazy var controlView: HomeTopControlView = lazyControlView()
    private lazy var editView: HomeTopEditControlView = lazyEditControlView()
    private lazy var collectionView: UICollectionView = lazyCollectionView()
    
    private var dataList = [HomeCategoryItemModel]()
    
    // MARK: - page life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 获取数据，刷新列表
        self.requestNewDatas()
    }
    
    override func placeSubViews() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(navBar)
        navBar.addSubview(controlView)
        navBar.addSubview(editView)
        view.addSubview(collectionView)
        
        navBar.snp.makeConstraints { make in
            make.top.left.right.equalTo(view)
            if isIPhoneX() {
                make.height.equalTo(114)
            }else {
                make.height.equalTo(90)
            }
        }
        controlView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(navBar)
            make.height.equalTo(50)
        }
        editView.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(navBar)
            make.height.equalTo(50)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    private func requestNewDatas() {
        if let dictionary = DBManager.share.request_home_datas() {
            let totalMoney = dictionary["totalMoney"] as! String
            let list = dictionary["list"] as! [[String: String]]
            dataList = []
            for dictionary in list {
                if let model = HomeCategoryItemModel.deserialize(from: dictionary) {
                    dataList.append(model)
                }
            }
//            addCategoryButton.isHidden = !dataList.isEmpty
//            navAddButton.isHidden = dataList.isEmpty
            
            if let userdefault = UserDefaults.init(suiteName: "group.com.rileytestut.AltStore.6664853H9Q") {
                
                userdefault.set(list, forKey: "items")
                userdefault.set(totalMoney, forKey: "totalMoney")
                userdefault.synchronize()
                
                WidgetCenter.shared.reloadAllTimelines()
            }
            
            
            collectionView.reloadData()
        }
    }
    
    // MARK: - delegate
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
        navigationController?.pushViewController(recordExpenses, animated: true)
    }
    
    // MARK: - view delegate
    func controlViewDidClickTimeAt(date: Date?) {
        debugPrint(date!)
    }
    
    func controlViewDidClickHistory() {
        
    }
    
    func controlViewDidClickEdit() {
        controlView.isHidden = true
        editView.isHidden = false
    }
    
    // MARK: - Lazy
    private func lazyNavBar() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.separator_color.cgColor
        view.layer.borderWidth = 0.3
        return view
    }
    
    private func lazyControlView() -> HomeTopControlView {
        let view = HomeTopControlView()
        view.delegate = self
        return view
    }
    
    private func lazyEditControlView() -> HomeTopEditControlView {
        let view = HomeTopEditControlView()
        view.isHidden = true
        return view
    }
    
    private func lazyCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (kScreenWidth-100)/4, height: (kScreenWidth-100)/4*1.5)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 20, bottom: 20, right: 20)
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

