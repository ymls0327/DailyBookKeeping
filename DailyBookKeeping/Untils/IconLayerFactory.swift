//
//  IconLayerFactory.swift
//  DailyBookKeeping
//
//  Created by ext.jiayaning1 on 2023/2/23.
//

import UIKit

extension CALayer {
    
    func origin(x: CGFloat, y: CGFloat) {
        var rect = frame
        rect.origin = CGPoint(x: x, y: y)
        frame = rect
    }
    
}

extension CALayer {
    
    // 箭头
    static func arrowLayer(width: CGFloat, lineWidth: CGFloat = 2, color: UIColor = .title_color, isLeft: Bool = true) -> CALayer {
        let shaperLayer = _get_common_shaplayer(width: width, lineWidth: lineWidth, lineColor: color)
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
    
    // 表
    static func lockLayer(width: CGFloat, lineWidth: CGFloat = 1.5, needleWidth: CGFloat = 2, circleColor: UIColor = .title_color, needleColor: UIColor = .red_color) -> CALayer {
        
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: width, height: width)
        // 圆环
        let circleLayer = _get_common_shaplayer(width: width, lineWidth: lineWidth, lineColor: circleColor)
        let circlePath = UIBezierPath()
        circlePath.addArc(withCenter: CGPoint(x: width*0.5, y: width*0.5), radius: (width-lineWidth*2)*0.5, startAngle: 0, endAngle: .pi*2, clockwise: true)
        circleLayer.path = circlePath.cgPath
        // 指针
        let needleLayer = _get_common_shaplayer(width: width, lineWidth: needleWidth, lineColor: needleColor)
        let needlePath = UIBezierPath()
        let radio = width*0.5-lineWidth
        needlePath.move(to: CGPoint(x: width*0.5, y: radio*0.45+lineWidth))
        needlePath.addLine(to: CGPoint(x: width*0.5, y: width*0.5))
        needlePath.addLine(to: CGPoint(x: width-radio*0.6-lineWidth, y: width*0.5+radio*0.1))
        needleLayer.path = needlePath.cgPath
        
        layer.addSublayer(circleLayer)
        layer.addSublayer(needleLayer)
        return layer
    }
    
    // 完成
    static func finishLayer(width: CGFloat, lineWidth: CGFloat = 1.5, tickWidth: CGFloat = 2, circleColor: UIColor = .title_color, tickColor: UIColor = .red_color) -> CALayer {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: width, height: width)
        // 圆环
        let circleLayer = _get_common_shaplayer(width: width, lineWidth: lineWidth, lineColor: circleColor)
        let circlePath = UIBezierPath()
        circlePath.addArc(withCenter: CGPoint(x: width*0.5, y: width*0.5), radius: (width-lineWidth*2)*0.5, startAngle: 0, endAngle: .pi*2, clockwise: true)
        circleLayer.path = circlePath.cgPath
        
        // 对勾
        let tickLayer = _get_common_shaplayer(width: width, lineWidth: tickWidth, lineColor: tickColor)
        let tickPath = UIBezierPath()
        tickPath.move(to: CGPoint(x: 6, y: 8))
        tickPath.addLine(to: CGPoint(x: 9, y: 12))
        tickPath.addQuadCurve(to: CGPoint(x: 11, y: 12), controlPoint: CGPoint(x: 10, y: 13))
        tickPath.addLine(to: CGPoint(x: 20, y: 0))
        tickLayer.path = tickPath.cgPath
        
        layer.addSublayer(circleLayer)
        layer.addSublayer(tickLayer)
        return layer
    }
    
    static func editLayer(width: CGFloat, lineWidth: CGFloat = 1.5, pencilWidth: CGFloat = 2, bookColor: UIColor = .title_color, pencilColor: UIColor = .red_color) -> CALayer {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: width, height: width)
        // 本本
        let bookWidth = width - lineWidth*2;
        let bookLayer = _get_common_shaplayer(width: bookWidth, lineWidth: lineWidth, lineColor: bookColor)
        bookLayer.origin(x: lineWidth, y: lineWidth)

        let bookPath = UIBezierPath()
        bookPath.move(to: CGPoint(x: bookWidth*0.5, y: 0))
        bookPath.addLine(to: CGPoint(x: bookWidth*0.2, y: 0))
        bookPath.addQuadCurve(to: CGPoint(x: 0, y: bookWidth*0.2), controlPoint: CGPoint(x: 0, y: 0))
        bookPath.addLine(to: CGPoint(x: 0, y: bookWidth*0.8))
        bookPath.addQuadCurve(to: CGPoint(x: bookWidth*0.2, y: bookWidth), controlPoint: CGPoint(x: 0, y: bookWidth))
        bookPath.addLine(to: CGPoint(x: bookWidth*0.8, y: bookWidth))
        bookPath.addQuadCurve(to: CGPoint(x: bookWidth, y: bookWidth*0.8), controlPoint: CGPoint(x: bookWidth, y: bookWidth))
        bookPath.addLine(to: CGPoint(x: bookWidth, y: bookWidth*0.5))
        bookLayer.path = bookPath.cgPath
        layer.addSublayer(bookLayer)
        
        // 笔
        let pwidth = width - pencilWidth*2;
        let pencilLayer = _get_common_shaplayer(width: pwidth, lineWidth: pencilWidth, lineColor: pencilColor)
        pencilLayer.origin(x: pencilWidth, y: pencilWidth)
        let pencilPath = UIBezierPath()
        pencilPath.move(to: CGPoint(x: pwidth*0.95, y: pwidth*0.05))
        pencilPath.addLine(to: CGPoint(x: pwidth*0.35, y: pwidth*0.65))
        pencilLayer.path = pencilPath.cgPath
        layer.addSublayer(pencilLayer)
        
        return layer
    }
    
    
     static func _get_common_shaplayer(width: CGFloat, lineWidth: CGFloat, lineColor: UIColor) -> CAShapeLayer {
        let shapLayer = CAShapeLayer()
        shapLayer.frame = CGRect(x: 0, y: 0, width: width, height: width)
        shapLayer.strokeColor = lineColor.cgColor
        shapLayer.fillColor = UIColor.clear.cgColor
        shapLayer.lineWidth = lineWidth
        shapLayer.lineCap = .round
        shapLayer.lineJoin = .miter
        shapLayer.miterLimit = 2
        return shapLayer
    }
}
