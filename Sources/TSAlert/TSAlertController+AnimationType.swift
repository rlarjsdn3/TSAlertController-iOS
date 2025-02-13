
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

public extension TSAlertController {
    
    /// Defines different types of animations that can be applied to the alert's internal view.
    enum AnimationType {
        
        /// A fade-in animation, where the alert smoothly appears by increasing its opacity.
        case fadeIn
        
        /// A slide-up animation, where the alert enters the screen by moving up from the bottom.
        case slideUp
        
        /// A custom animation using a specified transform and alpha value.
        ///
        /// - Parameters:
        ///   - transform: A `CGAffineTransform` defining the transformation to be applied.
        ///   - alpha: The initial alpha value before the animation starts.
        case custom(transform: CGAffineTransform, alpha: CGFloat)
        
        /// Applies the selected animation type to a given view.
        ///
        /// - Parameter view: The `UIView` to which the animation will be applied.
        func apply(to view: UIView) {
            switch self {
            case .fadeIn:
                view.alpha = 0
                
            case .slideUp:
                view.alpha = 0
                view.transform = CGAffineTransform(translationX: 0, y: 25)
                
            case let .custom(transform, alpha):
                view.alpha = alpha
                view.transform = transform
            }
        }
        
        /// Resets the animation effects and restores the view to its original state.
        ///
        /// - Parameter view: The `UIView` whose animation should be undone.
        func undo(for view: UIView) {
            switch self {
            case .fadeIn, .slideUp, .custom:
                view.alpha = 1
                view.transform = .identity
            }
        }
    }
}
