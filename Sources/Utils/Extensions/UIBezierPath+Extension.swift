//
//  UIBezierPath+Extension.swift
//  TSAlertController
//
//  Created by 김건우 on 3/21/25.
//

import UIKit

extension UIBezierPath {
    
    convenience init(roundedRect rect: CGRect,
                     topLeftRadius: CGFloat = .zero,
                     topRightRadius: CGFloat = .zero,
                     bottomLeftRadius: CGFloat = .zero,
                     bottomRightRadius: CGFloat = .zero) {
        self.init()
        
        let path = CGMutablePath()
        
        let topLeftPoint = CGPoint(x: rect.minX, y: rect.minY)
        let topRightPoint = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomLeftPoint = CGPoint(x: rect.minX, y: rect.maxY)
        let bottomRightPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        
        path.move(to: bottomLeftPoint)
        
        path.addArc(tangent1End: topLeftPoint,
                    tangent2End: topRightPoint,
                    radius: topLeftRadius)

        path.addArc(tangent1End: topRightPoint,
                    tangent2End: bottomRightPoint,
                    radius: topRightRadius)
        
        path.addArc(tangent1End: bottomRightPoint,
                    tangent2End: bottomLeftPoint,
                    radius: bottomRightRadius)

        path.addArc(tangent1End: bottomLeftPoint,
                    tangent2End: topLeftPoint,
                    radius: bottomLeftRadius)
        
        path.closeSubpath()
        cgPath = path
    }
}


extension CGMutablePath {
    
    func addLine(toX x: CGFloat, y: CGFloat) {
        addLine(to: CGPoint(x: x, y: y))
    }
    
    func move(toX x: CGFloat, y: CGFloat) {
        move(to: CGPoint(x: x, y: y))
    }
}
