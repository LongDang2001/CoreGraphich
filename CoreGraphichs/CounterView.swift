//
//  CounterView.swift
//  CoreGraphichs
//
//  Created by admin on 10/25/20.
//  Copyright © 2020 Long. All rights reserved.
//

import UIKit

@IBDesignable
class CounterView: UIView {
    
    @IBInspectable var outlineColor: UIColor = UIColor.yellow
    @IBInspectable var counterColor: UIColor = UIColor.orange
    
    var counter: Int = 2 {
        didSet {
//            if counter <= 8 {
                // cap nhat couter khi da dc thay doi, can goi ham layout lai truoc khi hien thi
                setNeedsDisplay()
//            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        let startAngle: CGFloat = 3 * .pi / 4
        let endAngle: CGFloat = .pi / 4
        let center: CGPoint = CGPoint(x: bounds.width/2, y: bounds.height/2)
        
        
        let path = UIBezierPath(arcCenter: center, radius: max(bounds.width/3, bounds.height/3), startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.lineWidth = 70
            UIColor.blue.setStroke()
            path.stroke()
        
        // vong cung
        let angleDifference: CGFloat = 2 * .pi - startAngle + endAngle
        
         // sau đó tính cung cho từng ly đơn
        let arcLengthPerGlass: CGFloat = angleDifference / 8
        let outlineEndAngle: CGFloat = arcLengthPerGlass * CGFloat(counter) + startAngle
        
        //2 draw the outer arc, ve vong cung ben ngoai
        let outerArcRadius = max(bounds.width/2, bounds.height/2) - 2
        let outlinePath = UIBezierPath(arcCenter: center, radius: outerArcRadius, startAngle: startAngle, endAngle: outlineEndAngle, clockwise: true)
        
        //3 - draw the inner arc, ve vong cung ben trong
        let innerArcRadius = bounds.width/3 - ContainerCustom.arcWidth/2
        // ????
        outlinePath.addArc(withCenter: center, radius: innerArcRadius, startAngle: outlineEndAngle, endAngle: startAngle, clockwise: false)
        
        //4 - close the path
        outlinePath.close() // de noi diem cuoi toi diem da bat dau
        outlinePath.lineWidth = 4
        outlineColor.setStroke()
        outlinePath.stroke()
        
    }
    
    private struct ContainerCustom {
        static let lineWidth: CGFloat = 5
        static let arcWidth: CGFloat  = 70
        static let numberOfGlasses = 8
        static var halfLineWidth: CGFloat {
            return lineWidth/2
        }
    }
    
}
