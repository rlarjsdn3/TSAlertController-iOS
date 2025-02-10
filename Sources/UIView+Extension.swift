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
    
    // MARK: - Add Blur Effect
    
    /// Adds a blur effect to the view.
    ///
    /// - Parameters:
    ///   - style: The `UIBlurEffect.Style` to apply.
    ///   - configuration: An optional `TSAlertController.ViewConfiguration` for additional styling.
    func addBlurEffect(_ style: UIBlurEffect.Style,
                       with configuration: TSAlertController.ViewConfiguration? = nil) {
        self.layoutIfNeeded()
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        if let configuration = configuration {
            blurEffectView.layer.borderColor = configuration.backgroundBorderColor
            blurEffectView.layer.borderWidth = configuration.backgroundBorderWidth
            blurEffectView.layer.cornerRadius = configuration.cornerRadius
            blurEffectView.layer.masksToBounds = true
        }
        self.insertSubview(blurEffectView, at: 0)
        blurEffectView.fill(to: self)
    }
}

extension UIView {
    
    // MARK: - Apply Size Constraint
    
    /// Applies width and height constraints to the view based on the provided size configuration.
    ///
    /// - Parameters:
    ///   - size: The `LayoutSize` configuration containing width and height constraints.
    ///   - view: The reference view for size calculations, defaults to the key window.
    func applySizeConstraint(with size: TSAlertController.ViewConfiguration.LayoutSize,
                             in view: UIView? = Helper.keyWindow()) {
        guard let view else { return }
        
        let baseWidth = min(view.frame.width, view.frame.height)  // Width based on Portrait orientation
        let baseHeight = max(view.frame.width, view.frame.height) // Height based on Portrait orientation
        
        // Apply width constraint
        switch size.width {
        case let .fixed(constant):
            self.setWidth(equalTo: constant)
            
        case let .flexible(minimum, maximum):
            self.setWidth(greaterThanOrEqualTo: minimum)
            self.setWidth(lessThanOrEqualTo: maximum)
            
        case let .proportional(minimumRatio, maximumRatio):
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
            self.setHeight(greaterThanOrEqualTo: baseHeight * minimumRatio)
            self.setHeight(lessThanOrEqualTo: baseHeight * maximumRatio)
        }
    }
    
    // MARK: - Apply Center Constraint
    
    /// Centers the view within the specified parent view.
    ///
    /// - Parameter view: The parent view in which to center the view, defaults to the key window.
    func applyCenterConstraint(in view: UIView? = Helper.keyWindow()) {
        guard let view else { return }
        self.center(in: view)
    }
}

extension UIView {
    
    // MARK: - Anchor
    
    /// Anchors the view to the specified edges of a parent view with optional insets.
    ///
    /// - Parameters:
    ///   - top: The top anchor of the parent view.
    ///   - leading: The leading anchor of the parent view.
    ///   - trailing: The trailing anchor of the parent view.
    ///   - bottom: The bottom anchor of the parent view.
    ///   - topInset: The top inset value.
    ///   - leadingInset: The leading inset value.
    ///   - trailingInset: The trailing inset value.
    ///   - bottomInset: The bottom inset value.
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
    
    // MARK: - Set Width
    
    /// Sets a fixed width constraint for the view.
    func setWidth(equalTo constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    /// Sets a minimum width constraint for the view.
    func setWidth(greaterThanOrEqualTo constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
    }
    
    /// Sets a maximum width constraint for the view.
    func setWidth(lessThanOrEqualTo constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
    }
    
    // MARK: - Set Height
    
    /// Sets a fixed height constraint for the view.
    func setHeight(equalTo constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    /// Sets a minimum height constraint for the view.
    func setHeight(greaterThanOrEqualTo constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
    }
    
    /// Sets a maximum height constraint for the view.
    func setHeight(lessThanOrEqualTo constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
    }
    
    // MARK: - Center
    
    /// Centers the view within the specified parent view.
    func center(in view: UIView,
                xConstant: CGFloat = 0,
                yConstant: CGFloat = 0) {
        centerX(in: view, xConstant: xConstant)
        centerY(in: view, yConstant: yConstant)
    }
    
    /// Centers the view horizontally within the specified parent view.
    func centerX(in view: UIView,
                 xConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: xConstant).isActive = true
    }
    
    /// Centers the view vertically within the specified parent view.
    func centerY(in view: UIView,
                 yConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant).isActive = true
    }
    
    // MARK: - Fill
    
    /// Makes the view fill its parent view by setting constraints to all edges.
    ///
    /// - Parameter view: The parent view to be filled.
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
