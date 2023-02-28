//
//  AppDelegate.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/13.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIFont.printFonts()
        
        // 启动IQKeyboardManager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .black
        let nav = RootNavigationController(rootViewController: HomeViewController())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        // 连接数据库
        DBManager.share.prepare()
        
        return true
    }

}

