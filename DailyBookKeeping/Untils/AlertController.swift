//
//  AlertController.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/27.
//

import UIKit

struct AlertController {
    
    static func alert(with controller: UIViewController, title: String?, message: String?, cancleTitle: String = "取消", confirmTitle: String = "确定", confirmBlock: (() -> Void)? = nil, cancleBlock: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancleTitle, style: .cancel, handler: { action in
            cancleBlock?()
        }))
        alert.addAction(UIAlertAction.init(title: confirmTitle, style: .default, handler: { action in
            confirmBlock?()
        }))
        controller.present(alert, animated: true)
    }
}
