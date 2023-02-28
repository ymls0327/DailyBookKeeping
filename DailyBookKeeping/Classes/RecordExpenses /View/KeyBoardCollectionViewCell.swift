//
//  KeyBoardCollectionViewCell.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/28.
//

import UIKit
import SnapKit

class KeyBoardCollectionViewCell: UICollectionViewCell {
    
    open var clickBlock: ((_ content: String) -> Void)?
    
    var content: String = "" {
        didSet {
            titleButton.setTitle(content, for: .normal)
        }
    }
    
    private lazy var titleButton: UIButton = lazyTitleButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        placeSubViews()
    }
    
    private func placeSubViews() {
        contentView.addSubview(titleButton)
        titleButton.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTap(_ sender: UIButton) {
                
        clickBlock?(content)
    }
    
    private func lazyTitleButton() -> UIButton {
        let button = UIButton()
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        button.titleLabel?.font = .f_sb_(18)
        button.setTitleColor(.title_color, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.setBackgroundImage(.imageWithColor(.backgroundColor), for: .normal)
        button.setBackgroundImage(.imageWithColor(.title_color), for: .highlighted)
        button.roundCorners(.allCorners, rect: bounds, radius: 5)
        return button
    }
}
