
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
    
    struct Options: OptionSet {
        
        /// Adds an interactive scaling and dragging effect to the alert. Cannot be applied to `actionSheet`.
        public static let interactiveScaleAndDrag = Options(rawValue: 1 << 0)

        /// Dismisses the action sheet when dragged downward beyond a certain threshold.
        public static let dismissOnSwipeDown = Options(rawValue: 1 << 1)

        /// Dismisses the alert by tapping the outside area.
        public static let dismissOnTapOutside = Options(rawValue: 1 << 2)

        /// Dismisses the alert by tapping the inside area.
        public static let dismissOnTapInside = Options(rawValue: 1 << 3)

        /// Applies a stretching effect to the alert when dragged. Can only be applied to `actionSheet`.
        public static let stretchyDragging = Options(rawValue: 1 << 4)
        
        public var rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}
