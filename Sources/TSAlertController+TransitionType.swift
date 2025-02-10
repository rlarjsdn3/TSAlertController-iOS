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
    
    ///
    enum EnteringTransitionType {
       
        ///
        case fadeInAndScaleDown(duration: TimeInterval = 0.5)
        
        ///
        case slideUp(duration: TimeInterval = 0.5)
        
        ///
        case custom(any UIViewControllerAnimatedTransitioning)
        
        
        ///
        var resolvedAnimator: (any UIViewControllerAnimatedTransitioning)? {
            switch self {
            case let .fadeInAndScaleDown(duration):
                return FadeInAndScaleDownAnimator(duration: duration, presenting: true)
                
            case let .slideUp(duration):
                return SlideUpAnimator(duration: duration, presenting: true)
                
            case let .custom(transitioning):
                return transitioning
            }
        }
    }
    
    ///
    enum ExitingTransitionType {
        
        ///
        case fadeOut(duration: TimeInterval = 0.5)
        
        ///
        case slideDown(duration: TimeInterval = 0.5)
        
        ///
        case custom(any UIViewControllerAnimatedTransitioning)
        
        
        ///
        var resolvedAnimator: (any UIViewControllerAnimatedTransitioning)? {
            switch self {
            case let .fadeOut(duration):
                return FadeInAndScaleDownAnimator(duration: duration, presenting: false)
                
            case let .slideDown(duration):
                return SlideUpAnimator(duration: duration, presenting: false)
                
            case let .custom(transitioning):
                return transitioning
            }
        }
    }
}
