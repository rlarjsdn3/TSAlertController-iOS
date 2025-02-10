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
    
    /// Defines the configuration properties for a `TSButton`, including text, images, and layout attributes.
    struct Configuration {
        
        /// The title of the button.
        public var title: String?
        
        /// The text attributes applied to the button title.
        public var titleAttributes: [NSAttributedString.Key: Any]?
        
        /// The alignment of the title text within the button.
        public var titleAlignment: NSTextAlignment
        
        /// The primary image displayed inside the button.
        public var image: UIImage?
        
        /// The spacing between the title and the image.
        public var imageSpacing: CGFloat
        
        /// The preferred symbol configuration for the primary image.
        public var preferredSymbolConfigurationForImage: UIImage.SymbolConfiguration?
        
        /// An additional accessory image displayed inside the button.
        public var accessoryImage: UIImage?
        
        /// The spacing between the title and the accessory image.
        public var accessoryImageSpacing: CGFloat
        
        /// The preferred symbol configuration for the accessory image.
        public var preferredSymbolConfigurationForAccessoryImage: UIImage.SymbolConfiguration?
        
        /// The alignment of the content (title, image) within the button.
        public var contentAlignment: ContentAlignment
        
        /// The edge insets for the button’s content.
        public var contentEdgeInset: NSDirectionalEdgeInsets
        
        /// The background color of the button.
        public var backgroundColor: UIColor?
        
        /// The corner radius of the button.
        public var cornerRadius: CGFloat
        
        /// Initializes a `Configuration` object for a `TSButton` with customizable properties.
        ///
        /// - Parameters:
        ///   - title: The text displayed inside the button. Default is `nil`.
        ///   - titleAttributes: The attributes for styling the title. Default uses the system headline font with a white color.
        ///   - titleAlignment: The alignment of the title within the button. Default is `.center`.
        ///   - image: The primary image displayed inside the button. Default is `nil`.
        ///   - imageSpacing: The spacing between the title and the image. Default is `10`.
        ///   - preferredSymbolConfigurationForImage: The preferred symbol configuration for the primary image. Default is `nil`.
        ///   - accessoryImage: An optional accessory image displayed inside the button. Default is `nil`.
        ///   - accessoryImageSpacing: The spacing between the title and the accessory image. Default is `10`.
        ///   - preferredSymbolConfigurationForAccessoryImage: The preferred symbol configuration for the accessory image. Default is `nil`.
        ///   - contentAlignment: The alignment of the button content (title, image, accessory image). Default is `.center`.
        ///   - contentEdgeInset: The insets for the button’s content. Default is `(top: 0, leading: 10, bottom: 0, trailing: 10)`.
        ///   - backgroundColor: The background color of the button. Default is `.systemGray4`.
        ///   - cornerRadius: The corner radius of the button. Default is `12.5`.
        public init(title: String? = nil,
                    titleAttributes: [NSAttributedString.Key: Any]? = [.font: UIFont.preferredFont(forTextStyle: .headline),
                                                                       .foregroundColor: UIColor.white],
                    titleAlignment: NSTextAlignment = .center,
                    
                    image: UIImage? = nil,
                    imageSpacing: CGFloat = 10,
                    preferredSymbolConfigurationForImage: UIImage.SymbolConfiguration? = nil,
                    
                    accessoryImage: UIImage? = nil,
                    accessoryImageSpacing: CGFloat = 10,
                    preferredSymbolConfigurationForAccessoryImage: UIImage.SymbolConfiguration? = nil,
                    
                    contentAlignment: ContentAlignment = .center,
                    contentEdgeInset: NSDirectionalEdgeInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10),
                    backgroundColor: UIColor? = .systemGray4,
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
    
    /// Returns a new configuration without any images or accessory images.
    ///
    /// - Returns: A modified `Configuration` object with `image` and `accessoryImage` set to `nil`.
    func configurationWithoutImageAndAccessoryImage() -> Self {
        var newConfiguration = self
        newConfiguration.image = nil
        newConfiguration.accessoryImage = nil
        return newConfiguration
    }
}

// MARK: - Content Alignment

public extension TSButton {
    
    /// Defines the alignment of the content inside the button.
    enum ContentAlignment {
        
        /// Aligns the content to the left.
        case left
        
        /// Centers the content within the button.
        case center
        
        /// Aligns the content to the right.
        case right
    }
}
