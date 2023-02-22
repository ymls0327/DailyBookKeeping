//
//  NSObject+Extension.swift
//  DailyBookKeeping
//
//  Created by 贾亚宁 on 2023/2/15.
//

import UIKit

extension String {
    func formatterMoneyStyle() -> NSAttributedString {
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
        attributeString.append(NSAttributedString.init(string: "￥", attributes: [.font: UIFont.jdBoldFont(size: 8)]))
        let attri = NSMutableAttributedString.init(string: newString)
        attri.addAttributes([.font: UIFont.jdBoldFont(size: 13)], range: NSMakeRange(0, first.count))
        attri.addAttributes([.font: UIFont.jdBoldFont(size: 9)], range: NSMakeRange(first.count, last.count))
        attributeString.append(attri)
        return attributeString
    }
}

extension CALayer {
    
    // 箭头公共的layer
    static func arrowLayer(width: CGFloat, lineWidth: CGFloat, isLeft: Bool = true) -> CALayer {
        let shaperLayer = CAShapeLayer()
        shaperLayer.frame = CGRect(x: 0, y: 0, width: width, height: width)
        shaperLayer.strokeColor = UIColor.title_color.cgColor
        shaperLayer.fillColor = UIColor.clear.cgColor
        shaperLayer.lineWidth = lineWidth
        shaperLayer.lineCap = .round
        let bezierPath = UIBezierPath()
        if isLeft {
            bezierPath.move(to: CGPoint(x: width*0.6, y: 0))
            bezierPath.addLine(to: CGPoint(x: width*0.38, y: width*0.4))
            bezierPath.addQuadCurve(to: CGPoint(x: width*0.38, y: width*0.6), controlPoint: CGPoint(x: width*0.32, y: width*0.5))
            bezierPath.addLine(to: CGPoint(x: width*0.6, y: width))
        }else {
            bezierPath.move(to: CGPoint(x: width*0.4, y: 0))
            bezierPath.addLine(to: CGPoint(x: width*0.62, y: width*0.4))
            bezierPath.addQuadCurve(to: CGPoint(x: width*0.62, y: width*0.6), controlPoint: CGPoint(x: width*0.68, y: width*0.5))
            bezierPath.addLine(to: CGPoint(x: width*0.4, y: width))
        }
        shaperLayer.path = bezierPath.cgPath
        return shaperLayer
    }
    
    func origin(x: CGFloat, y: CGFloat) {
        var rect = frame
        rect.origin = CGPoint(x: x, y: y)
        frame = rect
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

extension UIColor {
    
    // 标题颜色
    static let title_color = color(fromHex: 0x3D3F60)
    // 副标题颜色
    static let sub_title_color = color(fromHex: 0x797B9C)
    // 分割线颜色
    static let separator_color = color(fromHex: 0xDCDCDC)
    
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
    func hex() -> String {
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
            return NSString.init(format: "#%x", rgb) as String
        } else {
            return ""
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
