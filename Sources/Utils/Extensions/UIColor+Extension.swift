//
//  UIColor+Extension.swift
//  TSAlertController
//
//  Created by 김건우 on 2/13/25.
//

import Foundation

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1) {
        self.init(red: r / 255.0,
                  green: g / 255.0,
                  blue: b / 255.0,
                  alpha: alpha)
    }
    
    convenience init(light: UIColor, dark: UIColor) {
        self.init { traitCollection in
            traitCollection.userInterfaceStyle == .light
            ? light
            : dark
        }
    }
}
