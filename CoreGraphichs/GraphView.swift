//
//  GraphView.swift
//  CoreGraphichs
//
//  Created by admin on 10/26/20.
//  Copyright © 2020 Long. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {
    @IBInspectable var starColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .cyan
    @IBInspectable var betweenColor: UIColor = .green
    // data weekly
    var graphPoints = [4, 2, 6, 4, 5, 8, 3]
    
    override func draw(_ rect: CGRect) {
        // rect.width là lấy chiêu rộng từ x = 0 đến điểm trên biểu đồ.
        let width = rect.width
        // rect.height là lấy chiều cao của đến điểm trên biểu đồ.
        let height = rect.height
        
        
        // draw gradient
        /*
         roundedRect: tao ra một đường thẳng, đường cong, với hệ toạ độ mặc định. Rect: hình chữ nhật xd hình dạng cơ bản hcn của đường thẳng.
         
         corners: xác định các góc muốn lam tròn, làm tròn các tập góc của hcn
         cornerRadii: bán kính của mỗi góc hình chữ
         
         */
        // bo tròn góc của hình vuông
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: constants.conerRadiusSize)
        /*
         addClip: sửa đổi vùng vẽ hiên thị hiện hành
         */
        path.addClip()
        
        
        // set bối cảnh đồ họa, trươc khi gọi drew thì set cái đối tượng view, set context hiện hanh.
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        //
        let color = [starColor.cgColor,betweenColor.cgColor, endColor.cgColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //
        let colorLocation: [CGFloat] = [0.0, 0.5, 1]
        /* định nghĩa cho sự chuyển đôi mau sắc.
         - colorsSpace là khoang giao nhau giữa hai màu sắc.
         - colors sử dụng mảng màu cgcolor nằm trong không gian màu xác, nêú khác nil thì
         - location xác định vị trí cho mỗi màu đc cug cấp, nằm trong pv
         0 -> 1
        */
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: color as CFArray, locations: colorLocation)
            else { return }
        
        let starPoint =  CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: 0, y: bounds.height)
        /*
         drawLinearGradient: vẽ một bối cảnh lấp đầy các diểm màu sắc từ star dến end
         options: kiểm soát việc lấp đầy, các điểm star và end
         
         */
        context.drawLinearGradient(gradient, start: starPoint, end: endPoint, options: [])
        
        
        // Node: Draw
        // tính điểm chiều rộng trừ lề, tính chiều rộng của mỗi đường thẳng nối các điểm
        let graphWidth = width - constants.margin * 2 - 4
        
        /* tinh số cột của X
         columnPoint tính nhận cột làm tham số và trả về giá trị mà điểm nằm trên trục x.
         */
        
        let columnXPoint = { (column: Int) -> CGFloat in
            let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
            return CGFloat(column) * spacing + constants.margin + 2
        }
        
        
        /*
         tinh so cot cua y:
         maxValue: trả về phần tử lớn nhất trong mảng
         ypoint: là giá trị trung binh của y.
         */
        let graphHeight = height - constants.topBorder - constants.bottomBorder
        guard let maxValue = graphPoints.max() else { return }
        //
        let columnYPoint = { (graphPoint: Int) -> CGFloat in
            let yPoint = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
            return graphHeight + constants.topBorder - yPoint
            
        }
        
        // draw graph line
        let graphPath = UIBezierPath()
        // điểm bắt dâu để vẽ đường thẳng, bắt đầu từ x=0, và y=0 :
        graphPath.move(to: CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
        
        // thêm điểm trong từng mục
        for i in 1..<graphPoints.count {
            let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            // vẽ từng phần của mỗi điểm.
            graphPath.addLine(to: nextPoint)
            
        }
        UIColor.white.setStroke()
        // node: bối cảnh đò hoạ đc thêm vào, và lưu trạng thái đồ hoạ
        context.saveGState()

        // creat line cho đồ thị gradient
        // tạo copy graphPath
        guard let clippingPath = graphPath.copy() as? UIBezierPath else { return }
        // add line,
        clippingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count - 1), y: height))
        clippingPath.addLine(to: CGPoint(x: columnXPoint(0), y: height))
        clippingPath.close() // nôi hai điểm cuối lại
        clippingPath.addClip() // sửa đổi vùng vẽ
        
        let heightsYPoint = columnYPoint(maxValue)
        let graphStarPoint = CGPoint(x: constants.margin, y: heightsYPoint)
        let graphEndPoint = CGPoint(x: constants.margin, y: bounds.height)
        context.drawLinearGradient(gradient, start: graphStarPoint, end: graphEndPoint, options: CGGradientDrawingOptions(rawValue: 0))
        
        context.restoreGState() // node
        graphPath.lineWidth = 2 // mặc định sẽ là 1:
        graphPath.stroke()
        
        
        // draw cicle to point
        for i in 0..<graphPoints.count {
            var point = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
            point.x -= constants.circleDiameter / 2
            point.y -= constants.circleDiameter / 2
            /*
             ovalIn: đc dùng đê vẽ hình bầu dục, nếu hình đó là hình vuông thì fill thành hình tròn.
             */
            let cicle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: constants.circleDiameter, height: constants.circleDiameter)))
            UIColor.white.setFill()
            cicle.fill()
        }
        // draw 3 ddường ngang trên biểu đồ, tạo một path ms
        let linePath = UIBezierPath()
        // line top
        linePath.move(to: CGPoint(x: constants.margin, y: constants.topBorder))
        linePath.addLine(to: CGPoint(x: width - constants.margin, y: constants.topBorder))
        
        // line between
        linePath.move(to: CGPoint(x: constants.margin, y: (height - constants.bottomBorder + constants.topBorder) / 2))
        linePath.addLine(to: CGPoint(x: width - constants.margin, y: (height - constants.bottomBorder + constants.topBorder) / 2))
        
        // line bottom
        linePath.move(to: CGPoint(x: constants.margin, y: height - constants.bottomBorder))
        linePath.addLine(to: CGPoint(x: width - constants.margin, y: height - constants.bottomBorder))
//        UIColor.white.cgColor
        linePath.stroke()
        
        
        
    }
    
    private enum constants {
        static let conerRadiusSize = CGSize(width: 8, height: 8)
        static let margin: CGFloat = 20
        static let topBorder: CGFloat = 80
        static let bottomBorder: CGFloat = 30
        static let circleDiameter: CGFloat = 8
    }
    
    
}
