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

public extension TSAlertAction {
    
    /// 
    struct StyleConfiguration {
        
        ///
        public var titleAttributes: [NSAttributedString.Key: Any]?
        
        ///
        public var backgroundColor: UIColor?
        
        ///
        public var cornerRadius: CGFloat

        ///
        public var imageToTitleSpacing: CGFloat
        
        ///
        public init(titleAttributes: [NSAttributedString.Key : Any]? = [.font: UIFont.preferredFont(forTextStyle: .headline),
                                                                        .foregroundColor: UIColor.systemBackground],
                    backgroundColor: UIColor? = .lightGray,
                    cornerRadius: CGFloat = 12.5,
                    imageToTitleSpacing: CGFloat = 10) {
            
            self.titleAttributes = titleAttributes
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
            self.imageToTitleSpacing = imageToTitleSpacing
        }
    }
}

public extension TSAlertAction.StyleConfiguration {
    
    ///
    static func cancel() -> TSAlertAction.StyleConfiguration {
        .init(backgroundColor: .systemBlue)
    }
    
    ///
    static func `default`() -> TSAlertAction.StyleConfiguration {
        .init()
    }
    
    ///
    static func destructive() -> TSAlertAction.StyleConfiguration {
        .init(backgroundColor: .systemRed)
    }
}
