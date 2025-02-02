
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
    enum AnimationType {
        
        ///
        case fade(alpha: CGFloat = 0)
        
        ///
        case slide(translationX: CGFloat = 0,
                   y: CGFloat = 20,
                   alpha: CGFloat = 0)
        
        ///
        case custom(transform: CGAffineTransform,
                    alpha: CGFloat)
        
        ///
        func apply(to view: UIView) {
            switch self {
            case let .fade(alpha):
                view.alpha = alpha
                
            case let .slide(translationX, y, alpha):
                view.alpha = alpha
                view.transform = CGAffineTransform(translationX: translationX, y: y)
                
            case let .custom(transform, alpha):
                view.alpha = alpha
                view.transform = transform
            }
        }
        
        ///
        func undo(for view: UIView) {
            switch self {
            case .fade, .slide, .custom:
                view.alpha = 1
                view.transform = .identity
            }
        }
    }
}
