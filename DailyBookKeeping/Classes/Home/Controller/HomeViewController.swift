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
        
        
        
        let layer = CALayer()
        
        let width = 100.0
        
        layer.frame = CGRect(x: 100, y: 100, width: width, height: width)
        // 圆环
        let circleLayer = CALayer._get_common_shaplayer(width: width, lineWidth: 2, lineColor: .title_color)
        let circlePath = UIBezierPath()
        circlePath.addArc(withCenter: CGPoint(x: width*0.5, y: width*0.5), radius: (width-2*2)*0.5, startAngle: 0, endAngle: .pi*2, clockwise: true)
        circleLayer.path = circlePath.cgPath
        
        // 对勾
        let tickLayer = CALayer._get_common_shaplayer(width: width, lineWidth: 2, lineColor: .red_color)
        let tickPath = UIBezierPath()
        tickPath.move(to: CGPoint(x: 30, y: 50))
        tickPath.addLine(to: CGPoint(x: 45, y: 65))
//        tickPath.addLine(to: CGPoint(x: 55, y: 64))
        tickPath.addQuadCurve(to: CGPoint(x: 55, y: 64), controlPoint: CGPoint(x: 51, y: 66))
        tickPath.addLine(to: CGPoint(x: 80, y: 30))
        tickLayer.path = tickPath.cgPath
        
        layer.addSublayer(circleLayer)
        layer.addSublayer(tickLayer)
        
        view.layer.addSublayer(layer)
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

