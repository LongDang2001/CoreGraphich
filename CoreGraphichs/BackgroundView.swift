//
//  BackgroundView.swift
//  CoreGraphichs
//
//  Created by admin on 11/1/20.
//  Copyright © 2020 Long. All rights reserved.
//

import UIKit

@IBDesignable
class BackgroundView: UIView {
    @IBInspectable var lightColor: UIColor = .orange
    @IBInspectable var darkColor: UIColor = .yellow
    @IBInspectable var patternSize: Int = 200
    
    override func draw(_ rect: CGRect) {
        /*
         UIGraphicsGetCurrentContext: lấy bối cảnh đồ thị giao diện ng dùng. được gọi trước khi gọi draw, nó đc thực hiên load các color lên để hiển thị trước.
         */
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
//         context.setFillColor(lightColor.cgColor)
//         context.fill(rect)
        let drawSize = CGSize(width: patternSize, height: patternSize)
            
        /*
         tạo một context mới để đặt nó là bối cảnh hiện tại
         node: Trong hầu hết các khía cạnh khác, ngữ cảnh đồ họa được tạo bởi hàm này hoạt động giống như bất kỳ bối cảnh đồ họa nào khác. Bạn có thể thay đổi bối cảnh bằng cách đẩy và bật các bối cảnh đồ họa khác.
         
         drawingContext: lấy bối cảnh bitmap băng cách gọi hàm UIGraphicsGetCurrentContext
         */
        UIGraphicsBeginImageContextWithOptions(drawSize, true, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()!
        // set color
        darkColor.setFill()
        //set the fill color for the new context, set toàn bộ bối cảnh mới đc thêm vào
        drawingContext.fill(CGRect(x: 0, y: 0, width: drawSize.width, height: drawSize.height))
                
        let trianglePath = UIBezierPath()
        //1
        trianglePath.move(to: CGPoint(x: drawSize.width/2, y: 0))
        //2
        trianglePath.addLine(to: CGPoint(x: 0, y: drawSize.height/2))
        //3
        trianglePath.addLine(to: CGPoint(x: drawSize.width, y: drawSize.height/2))
            
        //4
        trianglePath.move(to: CGPoint(x: 0,y: drawSize.height/2))
        //5
        trianglePath.addLine(to: CGPoint(x: drawSize.width/2, y: drawSize.height))
        //6
        trianglePath.addLine(to: CGPoint(x: 0, y: drawSize.height))
            
        //7
        trianglePath.move(to: CGPoint(x: drawSize.width, y: drawSize.height/2))
        //8
        trianglePath.addLine(to: CGPoint(x: drawSize.width/2, y: drawSize.height))
        //9
        trianglePath.addLine(to: CGPoint(x: drawSize.width, y: drawSize.height))
            
        lightColor.setFill()
        trianglePath.fill()
        
        /*
         UIGraphicsGetImageFromCurrentImageContext: Điều này trích xuất một hình ảnh UIImage từ ngữ cảnh hiện tại.
         Khi bạn kết thúc ngữ cảnh hiện tại bằng UIGraphicsEndImageContext(), ngữ cảnh bản vẽ sẽ hoàn nguyên về ngữ cảnh của chế độ xem, do đó, mọi bản vẽ tiếp theo trong bản vẽ (_ rect :) sẽ xảy ra trong chế độ xem.
         
         UIColor(patternImage: image).setFill(): tạo một đôi tượng UIcolor bằng một mẫu hình ảnh đã đc chỉ định.
         context.fill(rect): vẽ fill tất cả context các rect
         */
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        UIColor(patternImage: image).setFill()
        context.fill(rect)
    }

}
