
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

extension UITextField {
    
    /// Defines the padding position for a UI element.
    enum PaddingPosition {
        
        /// Adds padding to the left side of the element.
        ///
        /// - Parameter width: The width of the left padding.
        case left(CGFloat)
        
        /// Adds padding to the right side of the element.
        ///
        /// - Parameter width: The width of the right padding.
        case right(CGFloat)
        
        /// Adds padding to both the left and right sides of the element.
        ///
        /// - Parameter width: The width of the padding applied to both edges.
        case edge(CGFloat)
    }
    
    /// Sets padding insets for the left, right, or both edges of the view.
    ///
    /// This method creates `UIView` instances to serve as padding views and assigns them
    /// to the corresponding `leftView` or `rightView` properties of the view.
    ///
    /// - Parameter paddings: A variadic list of `PaddingPosition` values specifying the padding configuration.
    func setPaddingInsets(_ paddings: PaddingPosition...) {
        
        for padding in paddings {
            
            switch padding {
            case let .left(width):
                let view = UIView(frame: CGRect(x: 0, y: 0,
                                                width: width, height: self.frame.height))
                self.leftView = view
                self.leftViewMode = .always
                
            case let .right(width):
                let view = UIView(frame: CGRect(x: 0, y: 0,
                                                width: width, height: self.frame.height))
                self.rightView = view
                self.rightViewMode = .always
                
            case let .edge(width):
                let view = UIView(frame: CGRect(x: 0, y: 0,
                                                width: width, height: self.frame.height))
                self.leftView = view
                self.leftViewMode = .always
                self.rightView = view
                self.rightViewMode = .always
            }
        }
    }
}
