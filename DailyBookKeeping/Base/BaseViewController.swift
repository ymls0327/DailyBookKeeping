//
//  BaseViewController.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/15.
//

import UIKit

class BaseViewController: UIViewController {

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .backgroundColor
        // 设置状态栏
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        
        // 设置导航栏
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundImage = .imageWithColor(.mainColor)
            appearance.shadowColor = nil
            appearance.backgroundEffect = nil;
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.f_m_17];
            self.navigationController?.navigationBar.standardAppearance = appearance;
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearance;
            if #available(iOS 15.0, *) {
                self.navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
            }
        }
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.placeSubViews()
    }
    
    func placeSubViews() {
        
    }
}
