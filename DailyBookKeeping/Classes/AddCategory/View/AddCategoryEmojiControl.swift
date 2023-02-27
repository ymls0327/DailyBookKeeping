//
//  AddCategoryEmojiControl.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/27.
//

import UIKit
import SnapKit
import SwifterSwift

class AddCategoryEmojiControl: UIControl, UIKeyInput {
    
    private lazy var titleLabel: UILabel = lazyTitleLabel()
    
    var content: String? {
        set {
            if let text = newValue, !text.isEmpty {
                titleLabel.text = text
            }
        }
        get {
            titleLabel.text
        }
    }
    
    var hasText: Bool {
        if let text = titleLabel.text, !text.isEmpty {
            return true
        }
        return false
    }
    
    func insertText(_ text: String) {
        if text.containEmoji {
            titleLabel.text = text
        }
    }
    
    func deleteBackward() {
        reset()
    }
    
    override var canResignFirstResponder: Bool { true }
    
    override var canBecomeFirstResponder: Bool { true }
    
    override var textInputContextIdentifier: String? { "" }
    
    override var textInputMode: UITextInputMode? {
        var emojiMode: UITextInputMode?
        var extensionMode: UITextInputMode?
        
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                emojiMode = mode
            }
            if mode.isKind(of: NSClassFromString("UIKeyboardExtensionInputMode")!) {
                extensionMode = mode
            }
        }
        
        if let mode = emojiMode {
            return mode
        }
        else if let mode = extensionMode {
            return mode
        }
        else if UITextInputMode.activeInputModes.count > 0 {
            return UITextInputMode.activeInputModes.first
        }
        return nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func reset() {
        titleLabel.text = "😄"
    }
    
    private func lazyTitleLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .title_color
        label.font = .f_m_(35)
        label.text = "😄"
        label.textAlignment = .center
        return label
    }
}
