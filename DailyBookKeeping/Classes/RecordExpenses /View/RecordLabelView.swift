//
//  RecordLabelView.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/3/1.
//

import UIKit
import SnapKit

class RecordLabelCCell: UICollectionViewCell {
    
    open var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .f_r_(14)
        label.textAlignment = .center
        label.textColor = .sub_title_color
        label.backgroundColor = .backgroundColor
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 14
        label.layer.borderColor = UIColor.sub_title_color.cgColor
        label.layer.borderWidth = 0.2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.centerY.equalTo(contentView)
            make.height.equalTo(28)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RecordLabelView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    open var handler: ((_ label: String) -> Void)?
    
    private lazy var collectionView: UICollectionView = lazyCollectionView()
    
    var dataList: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecordLabelCCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! RecordLabelCCell
        cell.title = dataList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let string = dataList[indexPath.item]
        handler?(string)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let string = dataList[indexPath.item]
        if !string.isEmpty {
            let width = (string as NSString).boundingRect(with: CGSize(width: CGFLOAT_MAX, height: 50), attributes: [.font: UIFont.f_r_(14)], context: nil).size.width
            return CGSize(width: width+25, height: 50)
        }
        return .zero
    }
    
    private func lazyCollectionView() -> UICollectionView {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RecordLabelCCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }
    
}
