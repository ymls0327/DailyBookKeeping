//
//  ViewController.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/13.
//

import UIKit
import WidgetKit
import SnapKit
import SQLite

class ViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var navBar: UIView?
    var leftButton: UIButton?
    var centerButton: UIButton?
    var rightButton: UIButton?
    var collectionView: UICollectionView?
    var addButton: UIButton!
    lazy var list: Array<Any> = {
        let list = Array<Any>()
        return list
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .mainColor
        
        initializeUI()
        
        initData()
        
    }
    
    func initData() {
        if list.count == 0 {
            addButton.isHidden = false
        }
    }
    
    func initializeUI() {
        
        navBar = UIView()
        navBar?.backgroundColor = .clear
        self.view.addSubview(navBar!)
        navBar?.snp.makeConstraints({ make in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(90)
        })
        
        centerButton = UIButton.init(type: .system)
        centerButton?.titleLabel?.font = .f_m_16
        centerButton?.setTitleColor(.white, for: .normal)
        centerButton?.setTitle("今年", for: .normal)
        navBar?.addSubview(centerButton!)
        centerButton?.snp.makeConstraints({ make in
            make.centerX.bottom.equalTo(navBar!)
            make.height.equalTo(44)
        })
        
        leftButton = UIButton.init(type: .system)
        leftButton?.setImage(UIImage(named: "arrow_left_img"), for: .normal)
        leftButton?.tintColor = .white
        navBar?.addSubview(leftButton!)
        leftButton?.snp.makeConstraints({ make in
            make.bottom.equalTo(navBar!.snp.bottom)
            make.right.equalTo(centerButton!.snp.left)
            make.width.equalTo(40)
            make.height.equalTo(44)
        })
        
        rightButton = UIButton.init(type: .system)
        rightButton?.setImage(UIImage(named: "arrow_right_img"), for: .normal)
        rightButton?.tintColor = .white
        navBar?.addSubview(rightButton!)
        rightButton?.snp.makeConstraints({ make in
            make.bottom.equalTo(navBar!.snp.bottom)
            make.left.equalTo(centerButton!.snp.right)
            make.width.equalTo(40)
            make.height.equalTo(44)
        })
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (kScreenWidth-100)/4, height: (kScreenWidth-100)/4*1.5)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .clear
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView?.bounces = true
        self.view.addSubview(collectionView!)
        collectionView?.snp.makeConstraints({ make in
            make.top.equalTo(navBar!.snp.bottom).offset(25)
            make.left.right.equalTo(self.view)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaInsets.bottom)
            }else {
                make.bottom.equalTo(self.view.snp.bottom)
            }
        })
        
        addButton = UIButton()
        addButton.layer.cornerRadius = 30
        addButton.layer.masksToBounds = true
        addButton.setTitle("+", for: .normal)
        addButton.backgroundColor = .white
        addButton.isHidden = true
        addButton.addTarget(self, action: #selector(addButtonTap(_ :)), for: .touchUpInside)
        self.view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.right.equalTo(self.view.snp.right).offset(-20)
            make.width.height.equalTo(60)
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaInsets.bottom).offset(-50)
            }else {
                make.bottom.equalTo(self.view.snp.bottom).offset(-20)
            }
        }
    }
    
    @objc func addButtonTap(_ sender: UIButton) {
        let addvc = AddCategoryViewController()
        
        self.present(addvc, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

