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
        public var titleMinHeight: CGFloat
        
        ///
        public var messageMinHeight: CGFloat
        
        ///
        public var buttonMinHeight: CGFloat
        
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
        public var backgroundColor: Background
        
        ///
        public var backgroundBorderColor: CGColor?
        
        ///
        public var backgroundBorderWidth: CGFloat
        
        ///
        public var shadow: Shadow?
        
        ///
        public var cornerRadius: CGFloat
        
        ///
        public var dimmedBackgroundViewColor: Background?
        
        ///
        public var margin: LayoutMargin
        
        ///
        public var spacing: LayoutSpacing
                
        ///
        public var size: LayoutSize
        
        ///
        public var buttonLayoutAxis: ButtonLayoutAxis
        
        
        
        // MARK: - Shadow Properties
        
        ///
        public struct Shadow {
            
            ///
            public var color: CGColor?
            
            ///
            public var opacity: CGFloat
            
            ///
            public var offset: CGSize
            
            ///
            public var radius: CGFloat

            ///
            public init(color: CGColor? = UIColor.black.withAlphaComponent(0.1).cgColor,
                        opacity: CGFloat = 1,
                        offset: CGSize = CGSize(width: 0, height: 3),
                        radius: CGFloat = 3) {
                
                self.color = color
                self.opacity = opacity
                self.offset = offset
                self.radius = radius
            }
        }
        
        
        
        // MARK: - Initalizer
        
        public init(titleMinHeight: CGFloat = 0,
                    messageMinHeight: CGFloat = 0,
                    buttonMinHeight: CGFloat = 42.5,
                    titleTextAttributes: [NSAttributedString.Key : Any]? = [.font: UIFont.preferredFont(forTextStyle: .headline),
                                                                            .foregroundColor: UIColor.label],
                    titleTextAlignment: NSTextAlignment = .left,
                    titleNumberOfLines: Int = 1,
                    messageTextAttributes: [NSAttributedString.Key : Any]? = [.font: UIFont.preferredFont(forTextStyle: .subheadline),
                                                                              .foregroundColor: UIColor.label],
                    messageTextAligngn: NSTextAlignment = .left,
                    messageNumberOfLines: Int = 3,
                    backgroundColor: Background = .color(.systemBackground, alpha: 1),
                    backgroundBorderColor: CGColor? = nil,
                    backgroundBorderWidth: CGFloat = 0,
                    shadow: Shadow? = nil,
                    cornerRadius: CGFloat = 20,
                    dimmedBackgroundViewColor: Background? = .effect(.systemChromeMaterialDark),
                    magin: LayoutMargin = .init(),
                    spacing: LayoutSpacing = .init(),
                    size: LayoutSize = .init(width: .proportional(minimumRatio: 0.75, maximumRatio: 0.75)),
                    buttonLayoutAxis: ButtonLayoutAxis = .automatic) {
            
            self.titleMinHeight = titleMinHeight
            self.messageMinHeight = messageMinHeight
            self.buttonMinHeight = buttonMinHeight
            self.titleTextAttributes = titleTextAttributes
            self.titleTextAlignment = titleTextAlignment
            self.titleNumberOfLines = titleNumberOfLines
            self.messageTextAttributes = messageTextAttributes
            self.messageTextAlignment = messageTextAligngn
            self.messageNumberOfLines = messageNumberOfLines
            self.backgroundColor = backgroundColor
            self.backgroundBorderColor = backgroundBorderColor
            self.backgroundBorderWidth = backgroundBorderWidth
            self.shadow = shadow
            self.cornerRadius = cornerRadius
            self.dimmedBackgroundViewColor = dimmedBackgroundViewColor
            self.margin = magin
            self.spacing = spacing
            self.size = size
            self.buttonLayoutAxis = buttonLayoutAxis
        }
        
        
    }
}


// MARK: - Background

public extension TSAlertController.ViewConfiguration {
    
    ///
    enum Background {
        
        ///
        case effect(UIBlurEffect.Style)
        
        ///
        case color(UIColor,
                   alpha: CGFloat = 1.0)
    }
}


// MARK: - LayoutMargin

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
        public init(contentTop: CGFloat = 22.5,
                    contentBottom: CGFloat = 17.5,
                    contentLeft: CGFloat = 17.5,
                    contentRight: CGFloat = 17.5) {
            
            self.contentTop = contentTop
            self.contentBottom = contentBottom
            self.contentLeft = contentLeft
            self.contentRight = contentRight
        }
        
    }
    
}


// MARK: - LayoutSpacing

public extension TSAlertController.ViewConfiguration {
    
    ///
    struct LayoutSpacing {
        
        // MARK: - Properties
        
        ///
        public var titleMessageSpacing: CGFloat
        
        /// The spacing between the message and the text field.
        ///
        /// This property defines the spacing between the message and the text field.
        /// The default value is 12.5. If no text field is added to the alert,
        /// this spacing will not be applied.
        public var messageTextfieldSpacing: CGFloat
        
        /// The spacing between the text field and the button.
        ///
        /// This defines the spacing between the text field and the button.
        /// The default value is 16.5. If no text field is added to the alert,
        /// this value will be used as the spacing between the message and the button instead.
        public var textfieldButtonSpacing: CGFloat
        
        ///
        public var buttonSpacing: CGFloat
        
        
        // MARK: - Intializer
        
        ///
        public init(titleMessageSpacing: CGFloat = 12.5,
                    messageTextfieldSpacing: CGFloat = 12.5,
                    textfieldButtonSpacing: CGFloat = 16.5,
                    buttonSpacing: CGFloat = 7.5) {
            
            self.titleMessageSpacing = titleMessageSpacing
            self.messageTextfieldSpacing = messageTextfieldSpacing
            self.textfieldButtonSpacing = textfieldButtonSpacing
            self.buttonSpacing = buttonSpacing
        }
    }
}



// MARK: - LayoutSize

public extension TSAlertController.ViewConfiguration {
    
    ///
    struct LayoutSize {
        
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
}

public extension TSAlertController.ViewConfiguration.LayoutSize {
    
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


// MARK: - Button LayoutAxis

public extension TSAlertController.ViewConfiguration {
    
    ///
    enum ButtonLayoutAxis {
        
        ///
        case automatic
        
        ///
        case vertical
        
        ///
        case horizontal
        
        
        // MARK: - Resolve
        
        ///
        func resolveLayoutAxis(for actions: [TSAlertAction]) -> ButtonLayoutAxis {
            if case .automatic = self {
                return determineAutomaticLayout(for: actions)
            }
            return self
        }
        
        
        // MARK: - Private Helper
        
        ///
        private func determineAutomaticLayout(for actions: [TSAlertAction]) -> ButtonLayoutAxis {
            //
            if actions.count > 2 {
                return .vertical
            //
            } else {
                return .horizontal
            }
        }
    }
}

extension TSAlertController.ViewConfiguration.ButtonLayoutAxis {
    
    func isHorizontal(for actions: [TSAlertAction]) -> Bool {
        if case .automatic = self {
            return determineAutomaticLayout(for: actions) == .horizontal
        }
        return self == .horizontal
    }
}



// MARK: - Extension

extension TSAlertController.ViewConfiguration {
    
    ///
    func isButtonLayoutAxisHorizontal(for actions: [TSAlertAction]) -> Bool {
        return self.buttonLayoutAxis.isHorizontal(for: actions)
    }
}
