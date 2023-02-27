//
//  HomeViewController.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/17.
//

import UIKit
import SnapKit
import WidgetKit

class HomeViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, HomeTopControlViewDelegate, HomeTopEditControlViewDelegate {
    
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
        
        
//        let width = 100.0
//        let needleWidth = 0.0
//        let layer = CALayer()
//        layer.frame = CGRect(x: 100, y: 100, width: width, height: width)
//        // 盖子
//        let bookWidth = width - needleWidth*2;
//        let bookLayer = CALayer._get_common_shaplayer(width: bookWidth, lineWidth: 5, lineColor: .red)
//        bookLayer.origin(x: needleWidth, y: needleWidth)
//        
//        let bookPath = UIBezierPath()
//        bookPath.move(to: CGPoint(x: bookWidth*0.4, y: bookWidth*0.1))
//        bookPath.addLine(to: CGPoint(x: bookWidth*0.6, y: bookWidth*0.1))
//        bookPath.move(to: CGPoint(x: bookWidth*0.15, y: bookWidth*0.25))
//        bookPath.addLine(to: CGPoint(x: bookWidth*0.85, y: bookWidth*0.25))
//        
//        
//        
//        
//        bookPath.move(to: CGPoint(x: 24, y: 40))
//        bookPath.addLine(to: CGPoint(x: 28, y: 80))
//        bookPath.addQuadCurve(to: CGPoint(x: 38, y: 90), controlPoint: CGPoint(x: 29, y: 90))
//        bookPath.addLine(to: CGPoint(x: 62, y: 90))
//        bookPath.addQuadCurve(to: CGPoint(x: 72, y: 80), controlPoint: CGPoint(x: 71, y: 90))
//        bookPath.addLine(to: CGPoint(x: 76, y: 40))
//        
//        
//        bookLayer.path = bookPath.cgPath
//        
//        layer.addSublayer(bookLayer)
//        
//        view.layer.addSublayer(layer)
        
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
            if isEditing {
                dataList.append(addModel())
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
    
    private func deleteCategory(with id: Int64, name: String) {
        AlertController.alert(with: self, title: "确定要删除“\(name)”分类吗？", message: "删除分类将会删除该分类所有记录，不可恢复", confirmBlock: { [weak self] in
            if DBManager.share.delete_category_with(id: id) {
                DBProgressHUD.show(message: "删除成功")
                self?.requestNewDatas()
            }
        })
    }
    
    // MARK: - delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCollectionViewCell
        cell.model = dataList[indexPath.item]
        cell.isEditing = isEditing
        cell.deleteCategoryBlockToRefresh = { [weak self] id, name in
            self?.deleteCategory(with: id, name: name)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataList[indexPath.item]
        if isEditing {
            // 进入编辑
            let add = AddEditCategoryViewController()
            add.categoryModel = model
            add.refreshBlock = { [weak self] in
                self?.requestNewDatas()
            }
            navigationController?.pushViewController(add, animated: true)
        }else {
            // 添加记录
            let recordExpenses = RecordExpensesViewController()
            recordExpenses.model = model
            navigationController?.pushViewController(recordExpenses, animated: true)
        }
    }
    
    // MARK: - view delegate
    func controlViewDidClickTimeAt(date: Date?) {
        debugPrint(date!)
    }
    
    func controlViewDidClickHistory() {
        
    }
    
    func controlViewDidClickEdit() {
        dataList.append(addModel())
        collectionView.reloadData()
        controlView.isHidden = true
        editView.isHidden = false
        isEditing = true
    }
    
    func controlViewDidClickFinish() {
        dataList.remove(at: dataList.count-1)
        collectionView.reloadData()
        controlView.isHidden = false
        editView.isHidden = true
        isEditing = false
    }
    
    private func addModel() -> HomeCategoryItemModel {
        let addModel = HomeCategoryItemModel()
        addModel.isAdd = true
        return addModel
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
        view.delegate = self
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

