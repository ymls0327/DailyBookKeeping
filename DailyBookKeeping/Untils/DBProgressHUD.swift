//
//  DBProgressHUD.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/22.
//

import UIKit
import MBProgressHUD

class DBProgressHUD: NSObject {

    static func show(message string: String, _ view: UIView? = UIApplication.shared.delegate?.window!!, _ duration: TimeInterval = 2) {
        
        let hud = MBProgressHUD.showAdded(to: view!, animated: true)
        hud.mode = .text
        hud.label.text = string
        hud.label.font = .f_m_14
        hud.minShowTime = duration
        hud.margin = 12
        if isIPhoneX() {
            hud.offset = .init(x: 0, y: kScreenHeight*0.5 - 64)
        }else {
            hud.offset = .init(x: 0, y: kScreenHeight*0.5 - 30)
        }
        hud.bezelView.cornerRadius = 20
        hud.hide(animated: true)
    }
}
