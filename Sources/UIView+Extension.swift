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
    
    ///
    func applyConstraint(size: LayoutSize,
                         in baseView: UIView? = Helper.keyWindow()) {
        guard let baseView else { return }
        
        // Apply width constraint
        switch size.width {
        case let .fixed(value):
            NSLayoutConstraint.activate([
                self.widthAnchor.constraint(equalToConstant: value)
            ])
        case let .flexible(minimum, maximum):
            NSLayoutConstraint.activate([
                self.widthAnchor.constraint(greaterThanOrEqualToConstant: minimum),
                self.widthAnchor.constraint(lessThanOrEqualToConstant: maximum)
            ])
        case let .proportional(minimumRatio, maximumRatio):
            let baseWidth = baseView.frame.width
            NSLayoutConstraint.activate([
                self.widthAnchor.constraint(greaterThanOrEqualToConstant: baseWidth * minimumRatio),
                self.widthAnchor.constraint(lessThanOrEqualToConstant: baseWidth * maximumRatio)
            ])
        }
        
        // Apply height constraint
        switch size.height {
        case let .fixed(value):
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: value)
            ])
        case let .flexible(minimum, maximu):
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(greaterThanOrEqualToConstant: minimum),
                self.heightAnchor.constraint(lessThanOrEqualToConstant: maximu),
            ])
        case let .proportional(minimumRatio, maximumRatio):
            let baseHeight = baseView.frame.height
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(greaterThanOrEqualToConstant: baseHeight * minimumRatio),
                self.heightAnchor.constraint(lessThanOrEqualToConstant: baseHeight * maximumRatio)
            ])
        }
    }
}
