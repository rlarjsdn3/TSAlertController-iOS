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
    struct ViewConfiguration {
        
        // MARK: - Properties
        
        ///
        public var titleTextAttributes: [NSAttributedString.Key: Any]?
        
        ///
        public var titleTextAlignment: NSTextAlignment
        
        ///
        public var titleNumberOfLines: Int
        
        ///
        public var messageTextAttributes: [NSAttributedString.Key: Any]?
        
        ///
        public var messageTextAlignment: NSTextAlignment
        
        ///
        public var messageNumberOfLines: Int
        
        ///
        public var backgroundColor: Background?
        
        ///
        public var backgroundBorderColor: UIColor?
        
        ///
        public var backgroundBorderWidth: CGFloat
        
        ///
        public var alertCornerRadius: CGFloat
        
        ///
        public var dimmedBackgroundViewColor: Background?
        
        ///
        public var margin: LayoutMargin
        
        ///
        public var size: LayoutSize
        
        
        // MARK: - Initalizer
        
        public init(titleTextAttributes: [NSAttributedString.Key : Any]? = nil,
                    titleTextAlignment: NSTextAlignment = .left,
                    titleNumberOfLines: Int = 1,
                    messageTextAttributes: [NSAttributedString.Key : Any]? = nil,
                    messageTextAligngn: NSTextAlignment = .left,
                    messageNumberOfLines: Int = 3,
                    backgroundColor: Background? = .color(),
                    backgroundBorderColor: UIColor? = nil,
                    backgroundBorderWidth: CGFloat = 0,
                    alertCornerRadius: CGFloat = 10,
                    dimmedBackgroundViewColor: Background? = .color(alpha: 0.5),
                    magin: LayoutMargin = .init(),
                    size: LayoutSize = .init()) {
            self.titleTextAttributes = titleTextAttributes
            self.titleTextAlignment = titleTextAlignment
            self.titleNumberOfLines = titleNumberOfLines
            self.messageTextAttributes = messageTextAttributes
            self.messageTextAlignment = messageTextAligngn
            self.messageNumberOfLines = messageNumberOfLines
            self.backgroundColor = backgroundColor
            self.backgroundBorderColor = backgroundBorderColor
            self.backgroundBorderWidth = backgroundBorderWidth
            self.alertCornerRadius = alertCornerRadius
            self.dimmedBackgroundViewColor = dimmedBackgroundViewColor
            self.margin = magin
            self.size = size
        }
        
        
    }
}


public extension TSAlertController.ViewConfiguration {
    
    ///
    enum Background {
        
        ///
        case effect(UIVisualEffect)
        
        ///
        case color(UIColor = .systemBackground,
                   alpha: CGFloat = 1.0)
    }
}


public extension TSAlertController.ViewConfiguration {
    
    ///
    struct LayoutMargin {
        
        // MARK: - Properties
        
        ///
        public var contentTop: CGFloat
        
        ///
        public var contentBottom: CGFloat
        
        ///
        public var contentLeft: CGFloat
        
        ///
        public var contentRight: CGFloat
        
        
        // MARK: - Intializer
        
        ///
        public init(contentTop: CGFloat = 15,
                    contentBottom: CGFloat = 15,
                    contentLeft: CGFloat = 15,
                    contentRight: CGFloat = 15) {
            self.contentTop = contentTop
            self.contentBottom = contentBottom
            self.contentLeft = contentLeft
            self.contentRight = contentRight
        }
        
    }
    
}



///
public struct LayoutSize {
    
    // MARK: - Properties
    
    ///
    public var width: LayoutSize.Constraint
    
    ///
    public var height: LayoutSize.Constraint
    
    
    // MARK: - Intializer
    
    ///
    public init(width: LayoutSize.Constraint = .proportional(),
                height: LayoutSize.Constraint = .proportional()) {
        self.width = width
        self.height = height
    }
    
}

public extension LayoutSize {
    
    ///
    enum Constraint {
        
        ///
        case fixed(CGFloat)
        
        ///
        case flexible(minimum: CGFloat = 10, maximum: CGFloat)
        
        ///
        case proportional(minimumRatio: CGFloat = 0.1, maximumRatio: CGFloat = 0.8)
    }
}
