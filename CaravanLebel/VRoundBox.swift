//
//  VRoundBox.swift
//  CaravanLebel
//
//  Created by ChoiYongHo on 2020/09/01.
//  Copyright © 2020 Thinkup. All rights reserved.
//

import UIKit

class VRoundBox: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
                
        let lefttopx : CGFloat = 45.0                       // 좌측 상단, x축
        let lefttopy : CGFloat = rect.width / 2            // 좌측 상단, y축

        let toplinex : CGFloat = 45.0
        let topliney : CGFloat = rect.height - (rect.width / 2)

        let rightArcx : CGFloat = lefttopy
        let rightArcy : CGFloat = topliney

        let bottomlinex : CGFloat = 5.0
        let bottomliney : CGFloat = lefttopy

        let leftArcx : CGFloat = lefttopy
        let leftArcy : CGFloat = lefttopy
                
        
        path.lineWidth = 2
        path.move(to: CGPoint(x: lefttopx, y: lefttopy))
        path.addLine(to: CGPoint(x: toplinex, y: topliney))
        path.addArc(withCenter: CGPoint(x: rightArcx, y: rightArcy), radius: 20, startAngle: .pi * 2 , endAngle: .pi , clockwise: true)
        path.addLine(to: CGPoint(x: bottomlinex, y: bottomliney))
        path.addArc(withCenter: CGPoint(x: leftArcx, y: leftArcy), radius: 20, startAngle: .pi , endAngle: .pi * 2 , clockwise: true)
        UIColor.systemRed.set()
        path.stroke()
        
        let centerline = UIBezierPath()
        
        let leftcenterx : CGFloat = 5.0
        let leftcentery : CGFloat = (rect.height / 2) - 10
        
        let leftcenterlinex : CGFloat = 45.0
        let leftcenterliney : CGFloat = leftcentery
        
        let rightcenterx : CGFloat = 5.0
        let rightcentery : CGFloat = (rect.height / 2) + 10
        
        let rightcenterlinex : CGFloat = 45.0
        let rightcenterliney : CGFloat = rightcentery
        
        
        centerline.move(to: CGPoint(x: leftcenterx, y: leftcentery))
        centerline.addLine(to: CGPoint(x: leftcenterlinex, y: leftcenterliney))
        
        centerline.move(to: CGPoint(x: rightcenterx, y: rightcentery))
        centerline.addLine(to: CGPoint(x: rightcenterlinex, y: rightcenterliney))
        
        UIColor.systemGray.set()
        
        centerline.stroke()
    }

}
