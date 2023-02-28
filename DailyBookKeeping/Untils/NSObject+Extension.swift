//
//  NSObject+Extension.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/15.
//

import UIKit

extension String {
    func formatterMoneyStyle(small: CGFloat = 10, large: CGFloat = 14) -> NSAttributedString {
        var string = self
        if self.count <= 0 {
            string = "0.00"
        }
        let array = string.components(separatedBy: ".")
        var first = "", last = ""
        if array.count == 2 {
            first = array[0]
            last = "." + array[1]
        }else if array.count == 1 {
            first = array[0]
            last = ".00"
        }
        let newString = first+last
        let attributeString = NSMutableAttributedString()
        attributeString.append(NSAttributedString.init(string: "￥", attributes: [.font: UIFont.jdBoldFont(size: small-1)]))
        let attri = NSMutableAttributedString.init(string: newString)
        attri.addAttributes([.font: UIFont.jdBoldFont(size: large)], range: NSMakeRange(0, first.count))
        attri.addAttributes([.font: UIFont.jdBoldFont(size: small)], range: NSMakeRange(first.count, last.count))
        attributeString.append(attri)
        return attributeString
    }
}

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

extension UIView {
    func roundCorners(_ corners: UIRectCorner, rect: CGRect, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: rect.size.width, height: rect.size.height),
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}

extension UIColor {
    
    // 标题颜色
    static let title_color = color(fromHex: 0x3D3F60)
    // 副标题颜色
    static let sub_title_color = color(fromHex: 0x797B9C)
    // 分割线颜色
    static let separator_color = color(fromHex: 0xDCDCDC)
    
    // 主红
    static let red_color = color(fromHex: 0xF22A2A)
    
    // 主题色
    static let mainColor = UIColor.rgbColor(r: 61, g: 63, b: 96)
    // 主题色+1
    static let main1Color = UIColor.rgbColor(r: 51, g: 53, b: 86)
    // 主题色-10
    static let main2Color = UIColor.rgbColor(r: 101, g: 103, b: 136)
    // 默认背景色
    static let backgroundColor = UIColor.rgbColor(r: 243, g: 245, b: 247)
    // 自定义RGB
    static func rgbColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    // 自定义16进制
    static func color(fromHex hex: UInt) -> UIColor {
        self.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255, green: CGFloat((hex & 0x00FF00) >> 8) / 255, blue: CGFloat(hex & 0x0000FF) / 255, alpha: 1.0)
    }
    // 自定义16进制
    static func color(fromHexString hex: NSString?) -> UIColor {
        guard var cString = hex else { return .clear }
        guard cString.length >= 6 else { return .clear }
        cString = cString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased() as NSString
        if cString.hasPrefix("0X") {
            cString = cString.substring(from: 2) as NSString
        }
        if cString.hasPrefix("#") {
            cString = cString.substring(from: 1) as NSString
        }
        guard cString.length == 6 else { return .clear }
        var range = NSRange()
        range.location = 0
        range.length = 2
        let rString = cString.substring(with: range)
        range.location = 2
        let gString = cString.substring(with: range)
        range.location = 4
        let bString = cString.substring(with: range)
        let r, g, b : UInt
        r = strtoul(rString, nil, 16)
        g = strtoul(gString, nil, 16)
        b = strtoul(bString, nil, 16)
        return UIColor.rgbColor(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }
    // 获取16进制
    func hex() -> String? {
        var r : CGFloat = 0
        var g : CGFloat = 0
        var b : CGFloat = 0
        var a : CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            if r > 1 { r = 1 }
            if r < 0 { r = 0 }
            if g > 1 { g = 1 }
            if g < 0 { g = 0 }
            if b > 1 { b = 1 }
            if b < 0 { b = 0 }
            let rgb = (Int(r * 255.0) << 16) + (Int(g * 255.0) << 8) + Int(b * 255.0)
            return NSString(format: "#%6.x", rgb).replacingOccurrences(of: " ", with: "0") as String
        } else {
            return nil
        }
    }
}
 
extension UIFont {
    
    static func f_l_(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }
    static func f_r_(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    static func f_m_(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    static func f_b_(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    static func f_sb_(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    static func jdRegularFont(size: CGFloat) -> UIFont {
        return self.init(name:"JDZhengHT-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func jdBoldFont(size: CGFloat) -> UIFont {
        return self.init(name:"JDLANGZHENGTI-SB--GBK1-0", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func chineseFont(size: CGFloat) -> UIFont {
        return self.init(name:"SourceHanSerifSC-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    static func printFonts() {
        for name in UIFont.familyNames {
            debugPrint(name)
            for font in UIFont.fontNames(forFamilyName: name) {
                debugPrint("--\(font)")
            }
        }
    }
}
