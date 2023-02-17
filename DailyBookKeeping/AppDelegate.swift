//
//  AppDelegate.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/13.
//

import UIKit
import RTRootNavigationController
import SQLite

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 连接数据库
        DBManager.share.prepare()
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let nav = RTRootNavigationController(rootViewController: ViewController())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }

}

