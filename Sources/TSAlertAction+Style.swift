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
    struct Style {
        
        ///
        public var titleAttributes: [NSAttributedString.Key: Any]?
        
        ///
        public var titleAlignment: UIButton.Configuration.TitleAlignment

        /// This property is applied only when the `preferredStyle` of `TSAlertController` is set to `.actionSheet`.
        public var imagePlacement: NSDirectionalRectEdge
        
        /// This property is applied only when the `preferredStyle` of `TSAlertController` is set to `.actionSheet`.
        public var imageReservation: CGFloat
        
        ///
        public var contentVerticalAlignment: UIControl.ContentVerticalAlignment
        
        ///
        public var contentHorizontalAlignment: UIControl.ContentHorizontalAlignment
        
        ///
        public var contentEdgeInset: NSDirectionalEdgeInsets
        
        ///
        public var backgroundColor: UIColor?
        
        ///
        public var cornerRadius: CGFloat
        
        /// This property is applied only when the `preferredStyle` of `TSAlertController` is set to `.actionSheet`.
        public var imageSpacing: CGFloat
        
        ///
        public var highlightType: TSButton.HighlightType

        ///
        public init(
               titleAttributes: [NSAttributedString.Key : Any]? = [.font: UIFont.preferredFont(forTextStyle: .headline),
                                                                   .foregroundColor: UIColor.systemBackground],
               titleAlignment: UIButton.Configuration.TitleAlignment = .leading,
               imagePlacement: NSDirectionalRectEdge = .leading,
               imageReservation: CGFloat = 0,
               contentVerticalAlignment: UIControl.ContentVerticalAlignment = .center,
               contentHorizontalAlignment: UIControl.ContentHorizontalAlignment = .center,
               contentEdgeInset: NSDirectionalEdgeInsets = .zero,
               backgroundColor: UIColor? = .lightGray,
               cornerRadius: CGFloat = 12.5,
               imageSpacing: CGFloat = 0,
               highlightType: TSButton.HighlightType = .fadeAndScaleDown()
           ) {
               self.titleAttributes = titleAttributes
               self.titleAlignment = titleAlignment
               self.imagePlacement = imagePlacement
               self.imageReservation = imageReservation
               self.contentVerticalAlignment = contentVerticalAlignment
               self.contentHorizontalAlignment = contentHorizontalAlignment
               self.contentEdgeInset = contentEdgeInset
               self.backgroundColor = backgroundColor
               self.cornerRadius = cornerRadius
               self.imageSpacing = imageSpacing
               self.highlightType = highlightType
           }
    }
}


// MARK: - Extension

public extension TSAlertAction.Style {
    
    ///
    static var cancel: TSAlertAction.Style {
        .init(backgroundColor: .systemBlue)
    }
    
    ///
    static var `default`: TSAlertAction.Style {
        .init()
    }
    
    ///
    static var destructive: TSAlertAction.Style {
        .init(backgroundColor: .systemRed)
    }
}


// MARK: - Equatable

extension TSAlertAction.Style: Equatable {
    
    ///
    public static func == (lhs: Self, rhs: Self) -> Bool {
        
        return lhs.titleAttributesEqual(to: rhs.titleAttributes) &&
        lhs.titleAlignment == rhs.titleAlignment &&
        lhs.imagePlacement == rhs.imagePlacement &&
        lhs.imageReservation == rhs.imageReservation &&
        lhs.contentVerticalAlignment == rhs.contentVerticalAlignment &&
        lhs.contentHorizontalAlignment == rhs.contentHorizontalAlignment &&
        lhs.contentEdgeInset == rhs.contentEdgeInset &&
        lhs.backgroundColor == rhs.backgroundColor &&
        lhs.cornerRadius == rhs.cornerRadius &&
        lhs.imageSpacing == rhs.imageSpacing &&
        lhs.highlightType == rhs.highlightType
    }
    
    ///
    private func titleAttributesEqual(to other: [NSAttributedString.Key: Any]?) -> Bool {
        guard let lhs = self.titleAttributes, let rhs = other else {
            return self.titleAttributes == nil && other == nil
        }
        return NSDictionary(dictionary: lhs).isEqual(to: rhs)
    }
}
