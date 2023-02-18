//
//  CommonNavBarView.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/18.
//

import UIKit
import SnapKit

class CommonNavBarView: UIView {

    var closeBlock: (() -> Void)?
    var saveBlock: (() -> Void)?
    
    lazy var titleLabel: UILabel = lazyTitleLabel()
    lazy var saveButton: UIButton = lazySaveButton()
    lazy var closeButton: UIButton = lazyCloseButton()
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        titleLabel.text = title
        self.placeSubViews()
    }
    
    private func placeSubViews() {
        self.addSubview(titleLabel)
        self.addSubview(saveButton)
        self.addSubview(closeButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.centerX.equalTo(self)
        }
        saveButton.snp.makeConstraints { make in
            make.top.right.bottom.equalTo(self)
            make.width.equalTo(closeButton.snp.height).multipliedBy(1)
        }
        closeButton.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(self)
            make.width.equalTo(closeButton.snp.height).multipliedBy(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func saveButtonTap(_ sender: UIButton) {
        if let block = saveBlock {
            block()
        }
    }
    
    @objc func closeButtonTap(_ sender: UIButton) {
        if let block = closeBlock {
            block()
        }
    }
    
    // MARK: - Lazy
    private func lazyTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .f_m_17
        label.textColor = .white
        return label
    }
    
    private func lazySaveButton() -> UIButton {
        let button = UIButton.init(type: .system)
        button.tintColor = .white
        button.setImage(UIImage.init(named: "save_btn_img"), for: .normal)
        button.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
        return button
    }
    
    private func lazyCloseButton() -> UIButton {
        let button = UIButton.init(type: .system)
        button.tintColor = .white
        button.setImage(UIImage.init(named: "close_btn_img"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTap), for: .touchUpInside)
        return button
    }
}
