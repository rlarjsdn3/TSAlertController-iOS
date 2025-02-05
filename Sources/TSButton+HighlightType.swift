
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
    
    ///
    enum HighlightType {
        
        ///
        case fade(alpha: CGFloat = 0.75)
        
        ///
        case fadeAndScaleDown(scaleX: CGFloat = 0.95,
                              y: CGFloat = 0.95,
                              alpha: CGFloat = 0.75)
        
        /// 버튼의 백그라운드 색상이 .clear인 경우에만 제한적으로 사용해라
        case dimAndScaleDown(scaleX: CGFloat = 0.975,
                             y: CGFloat = 0.975,
                             color: UIColor = .lightGray,
                             alpha: CGFloat = 0.5)
        
        ///
        case custom(transform: CGAffineTransform,
                    alpha: CGFloat)
        
        
        ///
        func apply(to view: TSButton) {
            switch self {
            case let .fade(alpha):
                view.alpha = alpha
                
            case let .fadeAndScaleDown(scaleX, y, alpha):
                view.alpha = alpha
                view.transform = CGAffineTransform(scaleX: scaleX, y: y)
                
            case let .dimAndScaleDown(scaleX, y, color, alpha):
                view.transform = CGAffineTransform(scaleX: scaleX, y: y)
                view.container.transform = CGAffineTransform(scaleX: scaleX, y: y)
                view.backgroundColor = color.withAlphaComponent(alpha)
                
            case let .custom(transform, alpha):
                view.alpha = alpha
                view.transform = transform
            }
        }
        
        ///
        func undo(for view: TSButton) {
            switch self {
            case .fade, .fadeAndScaleDown, .custom:
                view.alpha = 1
                view.transform = .identity
                
            case .dimAndScaleDown:
                view.transform = .identity
                view.container.transform = .identity
                view.backgroundColor = .clear
            }
        }
    }
}

// MARK: - Equatable

extension TSButton.HighlightType: Equatable {
}
