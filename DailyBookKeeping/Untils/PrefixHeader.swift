//
//  PrefixHeader.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/17.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.size.width

let kScreenHeight = UIScreen.main.bounds.size.height

let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height

public func isIPhoneX() -> Bool {
    var isIPhoneX = false
    if #available(iOS 11.0, *) {
        isIPhoneX = (UIApplication.shared.delegate?.window!!.safeAreaInsets.bottom)! > 0
    }
    return isIPhoneX
}
