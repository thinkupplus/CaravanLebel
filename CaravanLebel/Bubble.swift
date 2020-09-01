//
//  Bubble.swift
//  CaravanLebel
//
//  Created by ChoiYongHo on 2020/09/01.
//  Copyright © 2020 Thinkup. All rights reserved.
//

import UIKit

class Bubble: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        
        context.setLineWidth(2.0)
        context.setStrokeColor(UIColor.red.cgColor)
        context.setFillColor(UIColor.red.cgColor)
                
        print(" bubble x:\(rect.origin.x) Y:\(rect.origin.y)")
        print(" bubble width:\(rect.width) height:\(rect.height)")
    
        context.addArc(center: CGPoint(x: rect.width / 2, y: rect.height / 2    ), radius: 10, startAngle: 0.0, endAngle: .pi * 2.0, clockwise: true)
//        context.strokePath()
        context.fillPath()
    }
}
