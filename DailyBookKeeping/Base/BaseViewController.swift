//
//  BaseViewController.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/15.
//

import UIKit

class BaseViewController: UIViewController {

    private var backButton: UIControl?
    
    deinit {
        debugPrint("🌈🌈🌈🌈\(type(of: self)) 销毁了")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .backgroundColor
        // 设置状态栏
        UIApplication.shared.setStatusBarHidden(false, with: .none)
        
        // 设置导航栏
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundImage = .imageWithColor(.white)
            appearance.shadowColor = nil
            appearance.backgroundEffect = nil;
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.title_color, NSAttributedString.Key.font: UIFont.f_sb_(18)];
            navigationController?.navigationBar.standardAppearance = appearance;
            navigationController?.navigationBar.scrollEdgeAppearance = appearance;
            if #available(iOS 15.0, *) {
                navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
            }
        }else {
            navigationController?.navigationBar.setBackgroundImage(.imageWithColor(.white), for: .default)
            navigationController?.navigationBar.shadowImage = nil
        }
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .title_color
        
        placeSubViews()
    }
    
    func placeSubViews() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 自定义返回按钮
        customNavigationBarBackItem()
    }
    
    private func customNavigationBarBackItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: UIView())
        if let controller = navigationController?.viewControllers.first, controller != self {
            if let backButton = backButton {
                backButton.removeFromSuperview()
            }
            backButton = customBackButton()
            navigationController?.navigationBar.addSubview(backButton!)
        }
    }
    
    @objc func back() {
        navigationController?.popViewController()
    }
    
    // MARK: - Lazy
    private func customBackButton() -> UIControl {
        let control = UIControl.init(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        control.addTarget(self, action: #selector(back), for: .touchUpInside)
        let shaperLayer = CALayer.arrowLayer(width: 18, lineWidth: 2)
        shaperLayer.origin(x: 13, y: 13)
        control.layer.addSublayer(shaperLayer)
        return control
    }
}
