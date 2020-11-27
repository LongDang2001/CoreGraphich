//
//  CoreGraphichs.swift
//  CoreGraphichs
//
//  Created by admin on 10/24/20.
//  Copyright © 2020 Long. All rights reserved.
//

import UIKit
import CoreGraphics

@IBDesignable
class CoreGraphichs: UIButton {
    // tao mot core graphich
    @IBInspectable var fillColor: UIColor = .green
    @IBInspectable var isAddButton: Bool = true
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        fillColor.setFill()
        path.fill()
        
        // ve dau gach ngang ben trong button
        let plusPath = UIBezierPath()
        let plusWidth = min(bounds.width, bounds.height)*0.6
        let halfPlusWidth = plusWidth/2
        plusPath.lineWidth = 3
        
        
        
        if isAddButton {
            plusPath.move(to: CGPoint(x: halfWidth, y: halfHeight - halfPlusWidth))
            plusPath.addLine(to: CGPoint(x: halfWidth, y: halfHeight + halfPlusWidth))
            //
            plusPath.move(to: CGPoint(x: halfWidth - halfPlusWidth, y: halfHeight))
            plusPath.addLine(to: CGPoint(x: halfWidth + halfPlusWidth, y: halfWidth))
        } else {
            plusPath.move(to: CGPoint(x: halfWidth - halfPlusWidth, y: halfHeight))
            plusPath.addLine(to: CGPoint(x: halfWidth + halfPlusWidth, y: halfWidth))
        }
        
        UIColor.white.setStroke()
        plusPath.stroke()
        
    }
    
    // khai bao trung tam cua button
    private var halfWidth: CGFloat {
        return bounds.width/2
    }
    private var halfHeight: CGFloat {
        return bounds.height/2
    }
    
    private struct Container  {
        static var plusLineWidth = 3
        static var plusButtonScale =  0.6
        static var halfPoint = 0.5
    }
    
}
