
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

public extension TSButton {
    
    /// Defines different highlight effects for the button.
    enum HighlightType {
        
        /// A fade-in effect that decreases the button’s opacity when pressed and restores it when released.
        case fadeIn

        /// A fade-in effect combined with a slight scaling down of the button.
        case fadeInAndScaleDown

        /// Tints the button with a specified color and scales it down slightly.
        ///
        /// - Parameters:
        ///   - color: The tint color applied to the button. Default is `.lightGray`.
        case tintAndScaleDown(color: UIColor = .lightGray)

        /// Applies a custom transformation and alpha adjustment, allowing for fully customizable highlight effects.
        ///
        /// - Parameters:
        ///   - transform: The transformation applied to the button, such as scaling or rotation.
        ///   - alpha: The target alpha value when the button is highlighted.
        case custom(transform: CGAffineTransform, alpha: CGFloat)
        
        /// Applies the highlight effect to the specified button.
        ///
        /// - Parameter view: The `TSButton` to which the highlight effect is applied.
        func apply(to view: TSButton) {
            switch self {
            case .fadeIn:
                view.alpha = 0.75
                
            case .fadeInAndScaleDown:
                view.alpha = 0.75
                view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                
            case let .tintAndScaleDown(color):
                view.backgroundColor = color.withAlphaComponent(0.5)
                view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                view.previousBackgroundColor = view.tsConfiguration?.backgroundColor
                
            case let .custom(transform, alpha):
                view.alpha = alpha
                view.transform = transform
            }
        }
        
        /// Reverts the highlight effect, restoring the button's original appearance.
        ///
        /// - Parameter view: The `TSButton` to which the effect should be undone.
        mutating func undo(for view: TSButton) {
            switch self {
            case .fadeIn, .fadeInAndScaleDown, .custom:
                view.alpha = 1
                view.transform = .identity
                
            case .tintAndScaleDown:
                view.backgroundColor = view.previousBackgroundColor
                view.transform = .identity
            }
        }
    }
}

// MARK: - Equatable

extension TSButton.HighlightType: Equatable {
}
