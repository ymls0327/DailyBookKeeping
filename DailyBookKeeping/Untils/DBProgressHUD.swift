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
        hud.bezelView.layer.cornerRadius = 20
        common_shadow_hud_config(hud: hud)
        hud.hide(animated: true)
    }
    
    private static func common_shadow_hud_config(hud: MBProgressHUD) {
        hud.label.textColor = .white
        hud.bezelView.style = .solidColor
        hud.bezelView.backgroundColor = .mainColor
        hud.bezelView.layer.masksToBounds = false
        hud.bezelView.layer.shadowColor = UIColor.black.cgColor
        hud.bezelView.layer.shadowOffset = .zero
        hud.bezelView.layer.shadowRadius = 1
        hud.bezelView.layer.shadowOpacity = 0.6
    }
}
