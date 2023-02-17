//
//  NSObject+Extension.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/15.
//

import UIKit

extension UIImage {
    
    // 颜色转为图片
    class func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UIColor {
    // 主题色
    static let mainColor = UIColor.rgbColor(r: 61, g: 63, b: 96)
    // 主题色+1
    static let main1Color = UIColor.rgbColor(r: 53, g: 55, b: 83)
    // 默认背景色
    static let backgroundColor = UIColor.rgbColor(r: 243, g: 245, b: 247)
    // 自定义RGB
    static func rgbColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    // 自定义16进制
    static func hexColor(_ hex: UInt) -> UIColor {
        self.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255, green: CGFloat((hex & 0x00FF00) >> 8) / 255, blue: CGFloat(hex & 0x0000FF) / 255, alpha: 1.0)
    }
}
 
extension UIFont {
    
    static let f_r_9 = UIFont.systemFont(ofSize: 9)
    static let f_r_10 = UIFont.systemFont(ofSize: 10)
    static let f_r_11 = UIFont.systemFont(ofSize: 11)
    static let f_r_12 = UIFont.systemFont(ofSize: 12)
    static let f_r_13 = UIFont.systemFont(ofSize: 13)
    static let f_r_14 = UIFont.systemFont(ofSize: 14)
    static let f_r_15 = UIFont.systemFont(ofSize: 15)
    static let f_r_16 = UIFont.systemFont(ofSize: 16)
    static let f_r_17 = UIFont.systemFont(ofSize: 17)
    static let f_r_18 = UIFont.systemFont(ofSize: 18)
    static let f_r_19 = UIFont.systemFont(ofSize: 19)
    static let f_r_20 = UIFont.systemFont(ofSize: 20)
    static let f_r_21 = UIFont.systemFont(ofSize: 21)
    static let f_r_22 = UIFont.systemFont(ofSize: 22)
    static let f_r_23 = UIFont.systemFont(ofSize: 23)
    static let f_r_24 = UIFont.systemFont(ofSize: 24)
    static let f_r_25 = UIFont.systemFont(ofSize: 25)
    
    static let f_l_9 = UIFont.systemFont(ofSize: 9, weight: .light)
    static let f_l_10 = UIFont.systemFont(ofSize: 10, weight: .light)
    static let f_l_11 = UIFont.systemFont(ofSize: 11, weight: .light)
    static let f_l_12 = UIFont.systemFont(ofSize: 12, weight: .light)
    static let f_l_13 = UIFont.systemFont(ofSize: 13, weight: .light)
    static let f_l_14 = UIFont.systemFont(ofSize: 14, weight: .light)
    static let f_l_15 = UIFont.systemFont(ofSize: 15, weight: .light)
    static let f_l_16 = UIFont.systemFont(ofSize: 16, weight: .light)
    static let f_l_17 = UIFont.systemFont(ofSize: 17, weight: .light)
    static let f_l_18 = UIFont.systemFont(ofSize: 18, weight: .light)
    static let f_l_19 = UIFont.systemFont(ofSize: 19, weight: .light)
    static let f_l_20 = UIFont.systemFont(ofSize: 20, weight: .light)
    static let f_l_21 = UIFont.systemFont(ofSize: 21, weight: .light)
    static let f_l_22 = UIFont.systemFont(ofSize: 22, weight: .light)
    static let f_l_23 = UIFont.systemFont(ofSize: 23, weight: .light)
    static let f_l_24 = UIFont.systemFont(ofSize: 24, weight: .light)
    static let f_l_25 = UIFont.systemFont(ofSize: 25, weight: .light)
    
    static let f_m_9 = UIFont.systemFont(ofSize: 9, weight: .medium)
    static let f_m_10 = UIFont.systemFont(ofSize: 10, weight: .medium)
    static let f_m_11 = UIFont.systemFont(ofSize: 11, weight: .medium)
    static let f_m_12 = UIFont.systemFont(ofSize: 12, weight: .medium)
    static let f_m_13 = UIFont.systemFont(ofSize: 13, weight: .medium)
    static let f_m_14 = UIFont.systemFont(ofSize: 14, weight: .medium)
    static let f_m_15 = UIFont.systemFont(ofSize: 15, weight: .medium)
    static let f_m_16 = UIFont.systemFont(ofSize: 16, weight: .medium)
    static let f_m_17 = UIFont.systemFont(ofSize: 17, weight: .medium)
    static let f_m_18 = UIFont.systemFont(ofSize: 18, weight: .medium)
    static let f_m_19 = UIFont.systemFont(ofSize: 19, weight: .medium)
    static let f_m_20 = UIFont.systemFont(ofSize: 20, weight: .medium)
    static let f_m_21 = UIFont.systemFont(ofSize: 21, weight: .medium)
    static let f_m_22 = UIFont.systemFont(ofSize: 22, weight: .medium)
    static let f_m_23 = UIFont.systemFont(ofSize: 23, weight: .medium)
    static let f_m_24 = UIFont.systemFont(ofSize: 24, weight: .medium)
    static let f_m_25 = UIFont.systemFont(ofSize: 25, weight: .medium)
    
    static let f_b_9 = UIFont.systemFont(ofSize: 9, weight: .bold)
    static let f_b_10 = UIFont.systemFont(ofSize: 10, weight: .bold)
    static let f_b_11 = UIFont.systemFont(ofSize: 11, weight: .bold)
    static let f_b_12 = UIFont.systemFont(ofSize: 12, weight: .bold)
    static let f_b_13 = UIFont.systemFont(ofSize: 13, weight: .bold)
    static let f_b_14 = UIFont.systemFont(ofSize: 14, weight: .bold)
    static let f_b_15 = UIFont.systemFont(ofSize: 15, weight: .bold)
    static let f_b_16 = UIFont.systemFont(ofSize: 16, weight: .bold)
    static let f_b_17 = UIFont.systemFont(ofSize: 17, weight: .bold)
    static let f_b_18 = UIFont.systemFont(ofSize: 18, weight: .bold)
    static let f_b_19 = UIFont.systemFont(ofSize: 19, weight: .bold)
    static let f_b_20 = UIFont.systemFont(ofSize: 20, weight: .bold)
    static let f_b_21 = UIFont.systemFont(ofSize: 21, weight: .bold)
    static let f_b_22 = UIFont.systemFont(ofSize: 22, weight: .bold)
    static let f_b_23 = UIFont.systemFont(ofSize: 23, weight: .bold)
    static let f_b_24 = UIFont.systemFont(ofSize: 24, weight: .bold)
    static let f_b_25 = UIFont.systemFont(ofSize: 25, weight: .bold)
    
    static func jdRegularFont(size: CGFloat) -> UIFont {
        return self.init(name:"JDZhengHT-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func jdBoldFont(size: CGFloat) -> UIFont {
        return self.init(name:"JDLANGZHENGTI-SB--GBK1-0", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func chineseFont(size: CGFloat) -> UIFont {
        return self.init(name:"AppleTsukuBRdGothic-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
