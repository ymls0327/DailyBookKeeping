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
    
    // + 号
    static func addLayer(width: CGFloat, lineWidth: CGFloat = 1.5, lineColor: UIColor = .title_color) -> CALayer {
        let addLayer = _get_common_shaplayer(width: width, lineWidth: lineWidth, lineColor: lineColor)
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: width*0.5, y: 0))
        bezierPath.addLine(to: CGPoint(x: width*0.5, y: width))
        bezierPath.move(to: CGPoint(x: 0, y: width*0.5))
        bezierPath.addLine(to: CGPoint(x: width, y: width*0.5))
        addLayer.path = bezierPath.cgPath
        return addLayer
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
        tickPath.move(to: CGPoint(x: width*17/60, y: width*31/60))
        tickPath.addLine(to: CGPoint(x: width*22/60, y: width*36/60))
        tickPath.addQuadCurve(to: CGPoint(x: width*32/60, y: width*36/60), controlPoint: CGPoint(x: width*27/60, y: width*41/60))
        tickPath.addLine(to: CGPoint(x: width*42/60, y: width*22/60))
        tickLayer.path = tickPath.cgPath
        
        layer.addSublayer(circleLayer)
        layer.addSublayer(tickLayer)
        return layer
    }
    
    // 编辑
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
    
    // 删除
    static func deleteLayer(width: CGFloat, lineWidth: CGFloat = 1.5, needleWidth: CGFloat = 2, rectColor: UIColor = .title_color, needleColor: UIColor = .red_color) -> CALayer {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: width, height: width)
        // 盖子
        let bookWidth = width - needleWidth*2;
        let bookLayer = _get_common_shaplayer(width: bookWidth, lineWidth: needleWidth, lineColor: needleColor)
        bookLayer.origin(x: needleWidth, y: needleWidth)
        
        let bookPath = UIBezierPath()
        bookPath.move(to: CGPoint(x: bookWidth*0.4, y: bookWidth*0.1))
        bookPath.addLine(to: CGPoint(x: bookWidth*0.6, y: bookWidth*0.1))
        bookPath.move(to: CGPoint(x: bookWidth*0.15, y: bookWidth*0.25))
        bookPath.addLine(to: CGPoint(x: bookWidth*0.85, y: bookWidth*0.25))
        bookLayer.path = bookPath.cgPath
        
        // Kuang
        // 盖子
        let kuangWidth = width - lineWidth*2;
        let kaungLayer = _get_common_shaplayer(width: kuangWidth, lineWidth: lineWidth, lineColor: rectColor)
        kaungLayer.origin(x: lineWidth, y: lineWidth)
        
        let kuangPath = UIBezierPath()
        kuangPath.move(to: CGPoint(x: kuangWidth*0.24, y: kuangWidth*0.4))
        kuangPath.addLine(to: CGPoint(x: kuangWidth*0.28, y: kuangWidth*0.8))
        kuangPath.addQuadCurve(to: CGPoint(x: kuangWidth*0.38, y: kuangWidth*0.9), controlPoint: CGPoint(x: kuangWidth*0.29, y: kuangWidth*0.9))
        kuangPath.addLine(to: CGPoint(x: kuangWidth*0.62, y: kuangWidth*0.9))
        kuangPath.addQuadCurve(to: CGPoint(x: kuangWidth*0.72, y: kuangWidth*0.8), controlPoint: CGPoint(x: kuangWidth*0.71, y: kuangWidth*0.9))
        kuangPath.addLine(to: CGPoint(x: kuangWidth*0.76, y: kuangWidth*0.4))
        kaungLayer.path = kuangPath.cgPath
        
        layer.addSublayer(bookLayer)
        layer.addSublayer(kaungLayer)
        return layer
    }
    
    // 退出
    static func exitLayer(width: CGFloat, lineWidth: CGFloat = 1.5, needleWidth: CGFloat = 2, rectColor: UIColor = .title_color, needleColor: UIColor = .red_color) -> CALayer {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: width, height: width)
        
        let realWidth = width - lineWidth*2;
        let rectLayer = _get_common_shaplayer(width: realWidth, lineWidth: lineWidth, lineColor: rectColor)
        rectLayer.origin(x: lineWidth, y: lineWidth)
        
        let rectPatch = UIBezierPath()
        rectPatch.move(to: CGPoint(x: realWidth*0.9, y: realWidth*0.2))
        rectPatch.addQuadCurve(to: CGPoint(x: realWidth*0.7, y: 0), controlPoint: CGPoint(x: realWidth*0.9, y: 0))
        rectPatch.addLine(to: CGPoint(x: realWidth*0.2, y: 0))
        rectPatch.addQuadCurve(to: CGPoint(x: 0, y: realWidth*0.2), controlPoint: CGPoint(x: 0, y: 0))
        rectPatch.addLine(to: CGPoint(x: 0, y: realWidth*0.8))
        rectPatch.addQuadCurve(to: CGPoint(x: realWidth*0.2, y: realWidth), controlPoint: CGPoint(x: 0, y: realWidth))
        rectPatch.addLine(to: CGPoint(x: realWidth*0.7, y: realWidth))
        rectPatch.addQuadCurve(to: CGPoint(x: realWidth*0.9, y: realWidth*0.8), controlPoint: CGPoint(x: realWidth*0.9, y: realWidth))
        rectLayer.path = rectPatch.cgPath
        
        
        let arrowWidth = width - needleWidth*2;
        let arrowLayer = _get_common_shaplayer(width: arrowWidth, lineWidth: needleWidth, lineColor: needleColor)
        arrowLayer.origin(x: needleWidth, y: needleWidth)
        
        let arrowPath = UIBezierPath()
        arrowPath.move(to: CGPoint(x: arrowWidth*0.3, y: arrowWidth*0.5))
        arrowPath.addLine(to: CGPoint(x: arrowWidth*0.9, y: arrowWidth*0.5))
        arrowPath.move(to: CGPoint(x: arrowWidth*0.9, y: arrowWidth*0.4))
        arrowPath.addLine(to: CGPoint(x: arrowWidth, y: arrowWidth*0.5))
        arrowPath.addLine(to: CGPoint(x: arrowWidth*0.9, y: arrowWidth*0.6))
        arrowLayer.path = arrowPath.cgPath
        
        layer.addSublayer(rectLayer)
        layer.addSublayer(arrowLayer)
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
