//
//  CircleView.swift
//  CaravanLebel
//
//  Created by ChoiYongHo on 2020/08/31.
//  Copyright © 2020 Thinkup. All rights reserved.
//

import UIKit

class CircleView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func draw(_ rect: CGRect) {
        let contextSize : CGSize = rect.size

        let center = CGPoint(x: contextSize.width / 2, y: contextSize.height / 2)
        let radius = (contextSize.width - 10) / 2
    
        let context = UIGraphicsGetCurrentContext()!
    
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)
    
        context.addArc(center: center, radius: radius, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
        context.strokePath()
    
        let middle :CGFloat = 12.0
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)
    
        context.addArc(center: center, radius: middle, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
        context.strokePath()
    
    
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.gray.cgColor)
        context.move(to: CGPoint(x: center.x, y: 5))
        context.addLine(to: CGPoint(x: center.x, y: contextSize.height - 5))
        context.strokePath()
        
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.gray.cgColor)
        context.move(to: CGPoint(x: 5, y: center.y))
        context.addLine(to: CGPoint(x: contextSize.width - 5, y: center.y))
        context.strokePath()
    }

}
