//
//  ViewController.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/13.
//

import UIKit
import WidgetKit
import SnapKit

class ViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var navBar: UIView?
    var leftButton: UIButton?
    var centerButton: UIButton?
    var rightButton: UIButton?
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .mainColor
        
        initializeUI()
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
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width-100)/4, height: (UIScreen.main.bounds.size.width-100)/4*1.5)
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
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }
}

