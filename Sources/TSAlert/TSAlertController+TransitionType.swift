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
    
    /// Defines the types of entering transitions for the alert.
    enum EnteringTransitionType {
        
        /// A fade-in effect combined with a scale-down animation.
        case fadeInAndScaleDown
        
        /// A slide-up animation effect.
        case slideUp
        
        /// A custom transition using a `UIViewControllerAnimatedTransitioning` instance.
        case custom(any UIViewControllerAnimatedTransitioning)
        
        /// Resolves the appropriate animator for the selected entering transition type.
        var resolvedAnimator: (any UIViewControllerAnimatedTransitioning)? {
            switch self {
            case .fadeInAndScaleDown:
                return FadeInAndScaleDownAnimator(presenting: true)
                
            case .slideUp:
                return SlideUpAnimator(presenting: true)
                
            case let .custom(transitioning):
                return transitioning
            }
        }
    }
    
    /// Defines the types of exiting transitions for the alert.
    enum ExitingTransitionType {
        
        /// A fade-out animation effect.
        case fadeOut
        
        /// A slide-down animation effect.
        case slideDown
        
        /// A custom transition using a `UIViewControllerAnimatedTransitioning` instance.
        case custom(any UIViewControllerAnimatedTransitioning)
        
        /// Resolves the appropriate animator for the selected exiting transition type.
        var resolvedAnimator: (any UIViewControllerAnimatedTransitioning)? {
            switch self {
            case .fadeOut:
                return FadeInAndScaleDownAnimator(presenting: false)
                
            case .slideDown:
                return SlideUpAnimator(presenting: false)
                
            case let .custom(transitioning):
                return transitioning
            }
        }
    }
}
