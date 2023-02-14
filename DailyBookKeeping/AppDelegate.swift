//
//  AppDelegate.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let familyNames = UIFont.familyNames
        
        for name in familyNames {
            print(name)
            let array = UIFont.fontNames(forFamilyName: name)
            for son in array {
                print("--"+son)
            }
        }
        
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

}

