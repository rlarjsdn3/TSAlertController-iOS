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
    struct Configuration {
        
        ///
        public var title: String?
        
        ///
        public var titleAttributes: [NSAttributedString.Key: Any]?
        
        ///
        public var titleAlignment: NSTextAlignment
        
        ///
        public var image: UIImage?
        
        ///
        public var imageSpacing: CGFloat
        
        ///
        public var preferredSymbolConfigurationForImage: UIImage.SymbolConfiguration?
        
        ///
        public var accessoryImage: UIImage?
        
        ///
        public var accessoryImageSpacing: CGFloat
        
        ///
        public var preferredSymbolConfigurationForAccessoryImage: UIImage.SymbolConfiguration?
        
        ///
        public var contentAlignment: ContentAlignment
        
        ///
        public var contentEdgeInset: NSDirectionalEdgeInsets
        
        ///
        public var backgroundColor: UIColor?
        
        ///
        public var cornerRadius: CGFloat
        
        ///
        public init(title: String? = nil,
                    titleAttributes: [NSAttributedString.Key: Any]? = [.font: UIFont.preferredFont(forTextStyle: .headline),
                                                                       .foregroundColor: UIColor.systemBackground],
                    titleAlignment: NSTextAlignment = .center,
                    
                    image: UIImage? = nil,
                    imageSpacing: CGFloat = 10,
                    preferredSymbolConfigurationForImage: UIImage.SymbolConfiguration? = nil,
                    
                    accessoryImage: UIImage? = nil,
                    accessoryImageSpacing: CGFloat = 10,
                    preferredSymbolConfigurationForAccessoryImage: UIImage.SymbolConfiguration? = nil,
                    
                    contentAlignment: ContentAlignment = .center,
                    contentEdgeInset: NSDirectionalEdgeInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10),
                    backgroundColor: UIColor? = .systemGray2,
                    cornerRadius: CGFloat = 12.5) {
            
            self.title = title
            self.titleAttributes = titleAttributes
            self.titleAlignment = titleAlignment
            
            self.image = image
            self.imageSpacing = imageSpacing
            self.preferredSymbolConfigurationForImage = preferredSymbolConfigurationForImage
            
            self.accessoryImage = accessoryImage
            self.accessoryImageSpacing = accessoryImageSpacing
            self.preferredSymbolConfigurationForAccessoryImage = preferredSymbolConfigurationForAccessoryImage
            
            self.contentAlignment = contentAlignment
            self.contentEdgeInset = contentEdgeInset
            self.backgroundColor = backgroundColor
            self.cornerRadius = cornerRadius
        }
    }
}

extension TSButton.Configuration {
    
    ///
    func configurationWithoutImageAndAccessoryImage() -> Self {
        var newConfig = self
        newConfig.image = nil
        newConfig.accessoryImage = nil
        return newConfig
    }
}



// MARK: - Content Alignment

public extension TSButton {
    
    ///
    enum ContentAlignment {
        
        ///
        case left
        
        ///
        case center
        
        ///
        case right
    }
}
