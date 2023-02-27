//
//  CustomTextField.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/27.
//

import UIKit

class CustomTextField: UITextField {
    
    open var isCustom: Bool = true
    
    override var textInputMode: UITextInputMode? {
        if !isCustom {
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
        }
        return nil
    }
    
}
