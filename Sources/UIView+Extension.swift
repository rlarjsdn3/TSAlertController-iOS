// Copyright (c) 2025 rlarjsdn3 <rlarjsdn3@naver.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import UIKit

extension UIView {
    
    // MARK: - Add blur effect
    
    ///
    func addBlurEffect(_ style: UIBlurEffect.Style,
                       with viewConfig: TSAlertController.Configuration? = nil) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        if let viewConfig = viewConfig {
            blurEffectView.layer.borderColor = viewConfig.backgroundBorderColor
            blurEffectView.layer.borderWidth = viewConfig.backgroundBorderWidth
            blurEffectView.layer.cornerRadius = viewConfig.cornerRadius
            blurEffectView.layer.masksToBounds = true
            
            self.insertSubview(blurEffectView, at: 0)
        }
    }
}

extension UIView {
    
    // MARK: - Apply size constraint
    
    ///
    func applySizeConstraint(with size: TSAlertController.Configuration.LayoutSize,
                             in view: UIView? = Helper.keyWindow()) {
        guard let view else { return }
        
        // Apply width constraint
        switch size.width {
        case let .fixed(constant):
            self.setWidth(equalTo: constant)
            
        case let .flexible(minimum, maximum):
            self.setWidth(greaterThanOrEqualTo: minimum)
            self.setWidth(lessThanOrEqualTo: maximum)
            
        case let .proportional(minimumRatio, maximumRatio):
            let baseWidth = view.frame.width
            self.setWidth(greaterThanOrEqualTo: baseWidth * minimumRatio)
            self.setWidth(lessThanOrEqualTo: baseWidth * maximumRatio)
        }
        
        // Apply height constraint
        switch size.height {
        case let .fixed(constant):
            self.setHeight(equalTo: constant)
            
        case let .flexible(minimum, maximum):
            self.setHeight(greaterThanOrEqualTo: minimum)
            self.setHeight(lessThanOrEqualTo: maximum)
            
        case let .proportional(minimumRatio, maximumRatio):
            let baseHeight = view.frame.height
            self.setHeight(greaterThanOrEqualTo: baseHeight * minimumRatio)
            self.setHeight(lessThanOrEqualTo: baseHeight * maximumRatio)
        }
    }
    
    
    // MARK: - Apply center constraint
    
    ///
    func applyCenterConstraint(in view: UIView? = Helper.keyWindow()) {
        guard let view else { return }
        self.center(in: view)
    }
}


extension UIView {
    
    // MARK: - Anchor
    
    ///
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                topInset: CGFloat = 0,
                leadingInset: CGFloat = 0,
                trailingInset: CGFloat = 0,
                bottomInset: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topInset).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: leadingInset).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -trailingInset).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomInset).isActive = true
        }
    }
    
    
    // MARK: - Set width
    
    ///
    func setWidth(equalTo constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    ///
    func setWidth(greaterThanOrEqualTo constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
    }
    
    func setWidth(lessThanOrEqualTo constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
    }
    
    
    // MARK: - Set height
    
    ///
    func setHeight(equalTo constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    ///
    func setHeight(greaterThanOrEqualTo constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
    }
    
    func setHeight(lessThanOrEqualTo constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
    }
    
    
    // MARK: - Center
    
    ///
    func center(in view: UIView,
                xConstant: CGFloat = 0,
                yConstant: CGFloat = 0) {
        centerX(in: view, xConstant: xConstant)
        centerY(in: view, yConstant: yConstant)
    }
    
    func centerX(in view: UIView,
                xConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: xConstant).isActive = true
    }
    
    func centerY(in view: UIView,
                yConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant).isActive = true
    }
    
    
    // MARK: - Fill
    
    ///
    func fill(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: view.topAnchor,
               leading: view.leadingAnchor,
               trailing: view.trailingAnchor,
               bottom: view.bottomAnchor,
               topInset: 0,
               leadingInset: 0,
               trailingInset: 0,
               bottomInset: 0)
    }
    
    
}
