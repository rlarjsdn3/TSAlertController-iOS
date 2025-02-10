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


// MARK: - ViewConfiguration

public extension TSAlertController {
    
    /// Defines the visual and layout configurations of the alert.
    struct ViewConfiguration {
        
        /// The fixed height of the title area. If `nil`, the height is dynamically adjusted.
        public var titleHeight: CGFloat?
        
        /// The fixed height of the message area. If `nil`, the height is dynamically adjusted.
        public var messageHeight: CGFloat?
        
        /// The height of each button in the button group.
        public var buttonHeight: CGFloat
        
        /// The color of the grabber (handle) used for dragging.
        public var grabberColor: UIColor?
        
        /// Text attributes for styling the title.
        public var titleTextAttributes: [NSAttributedString.Key: Any]?
        
        /// The text alignment of the title.
        public var titleTextAlignment: NSTextAlignment
        
        /// The number of lines for the title. If `0`, the title expands dynamically.
        public var titleNumberOfLines: Int
        
        /// Text attributes for styling the message.
        public var messageTextAttributes: [NSAttributedString.Key: Any]?
        
        /// The text alignment of the message.
        public var messageTextAlignment: NSTextAlignment
        
        /// The number of lines for the message. If `0`, the message expands dynamically.
        public var messageNumberOfLines: Int
        
        /// The border color of the container wrapping the text field.
        public var textFieldContainerBorderColor: CGColor?
        
        /// The border width of the container wrapping the text field.
        public var textFieldContainerBorderWidth: CGFloat
        
        /// The background style of the alert.
        public var backgroundColor: Background
        
        /// The border color of the alert’s background.
        public var backgroundBorderColor: CGColor?
        
        /// The border width of the alert’s background.
        public var backgroundBorderWidth: CGFloat
        
        /// The shadow configuration for the alert view.
        public var shadow: Shadow?
        
        /// The corner radius of the alert view.
        public var cornerRadius: CGFloat
        
        /// The background color of the dimmed overlay behind the alert.
        public var dimmedBackgroundViewColor: Background?
        
        /// The margins applied around the alert view.
        public var margin: LayoutMargin
        
        /// The spacing settings applied within the alert layout.
        public var spacing: LayoutSpacing
        
        /// The size configuration of the alert.
        public var size: LayoutSize
        
        /// The axis layout of the button group (horizontal or vertical).
        public var buttonGroupAxis: ButtonGroupAxis
        
        /// Defines the shadow properties of the alert.
        public struct Shadow {
            
            /// The color of the shadow.
            public var color: CGColor?
            
            /// The opacity of the shadow.
            public var opacity: Float
            
            /// The offset of the shadow relative to the alert.
            public var offset: CGSize
            
            /// The blur radius of the shadow.
            public var radius: CGFloat
            
            /// Initializes a shadow configuration with default or custom values.
            ///
            /// - Parameters:
            ///   - color: The shadow color. Defaults to a subtle black shadow with 10% opacity.
            ///   - opacity: The shadow opacity, ranging from `0` (invisible) to `1` (fully visible).
            ///   - offset: The shadow’s position offset. Defaults to `(0, 3)`, creating a subtle bottom shadow.
            ///   - radius: The blur radius of the shadow. Defaults to `3`, providing a soft shadow effect.
            public init(color: CGColor? = UIColor.black.withAlphaComponent(0.1).cgColor,
                        opacity: Float = 1,
                        offset: CGSize = CGSize(width: 0, height: 3),
                        radius: CGFloat = 3) {
                
                self.color = color
                self.opacity = opacity
                self.offset = offset
                self.radius = radius
            }
        }
        
        /// Initializes a `ViewConfiguration` with customizable layout and style properties.
        ///
        /// - Parameters:
        ///   - titleHeight: The fixed height of the title. If `nil`, it adjusts dynamically.
        ///   - messageHeight: The fixed height of the message. If `nil`, it adjusts dynamically.
        ///   - buttonHeight: The height of each button in the button group. Default is `42.5`.
        ///   - grabberColor: The color of the grabber (handle). Default is `.systemGray5`.
        ///   - titleTextAttributes: The text attributes for the title. Defaults to a headline font with default color.
        ///   - titleTextAlignment: The alignment of the title text. Defaults to `.left`.
        ///   - titleNumberOfLines: The maximum number of lines for the title. Default is `0` (dynamic height).
        ///   - messageTextAttributes: The text attributes for the message. Defaults to a subheadline font.
        ///   - messageTextAlignment: The alignment of the message text. Defaults to `.left`.
        ///   - messageNumberOfLines: The maximum number of lines for the message. Default is `0` (dynamic height).
        ///   - textFieldContainerBorderColor: The border color of the text field container. Default is `.lightGray`.
        ///   - textFieldContainerBorderWidth: The border width of the text field container. Default is `0.75`.
        ///   - backgroundColor: The background style of the alert. Default is `.systemBackground`.
        ///   - backgroundBorderColor: The border color of the alert’s background. Default is `nil`.
        ///   - backgroundBorderWidth: The border width of the alert’s background. Default is `0`.
        ///   - shadow: The shadow configuration for the alert. Default is `nil`.
        ///   - cornerRadius: The corner radius of the alert. Default is `20`.
        ///   - dimmedBackgroundViewColor: The background color of the dimmed overlay. Default is `.black` with `0.75` opacity.
        ///   - margin: The margin settings around the alert. Default is `.init()`.
        ///   - spacing: The spacing settings within the alert layout. Default is `.init()`.
        ///   - size: The size configuration of the alert. Default is `.init(width: .proportional(minimumRatio: 0.75, maximumRatio: 0.75))`.
        ///   - buttonGroupAxis: The layout axis of the button group (horizontal or vertical). Default is `.automatic`.
        public init(titleHeight: CGFloat? = nil,
                    messageHeight: CGFloat? = nil,
                    buttonHeight: CGFloat = 42.5,
                    grabberColor: UIColor? = .systemGray5,
                    titleTextAttributes: [NSAttributedString.Key : Any]? = [.font: UIFont.preferredFont(forTextStyle: .headline),
                                                                            .foregroundColor: UIColor.label],
                    titleTextAlignment: NSTextAlignment = .left,
                    titleNumberOfLines: Int = 0,
                    messageTextAttributes: [NSAttributedString.Key : Any]? = [.font: UIFont.preferredFont(forTextStyle: .subheadline),
                                                                              .foregroundColor: UIColor.label],
                    messageTextAlignment: NSTextAlignment = .left,
                    messageNumberOfLines: Int = 0,
                    textFieldContainerBorderColor: CGColor? = UIColor.lightGray.cgColor,
                    textFieldContainerBorderWidth: CGFloat = 0.75,
                    backgroundColor: Background = .color(.systemBackground, alpha: 1),
                    backgroundBorderColor: CGColor? = nil,
                    backgroundBorderWidth: CGFloat = 0,
                    shadow: Shadow? = nil,
                    cornerRadius: CGFloat = 20,
                    dimmedBackgroundViewColor: Background? = .color(.black, alpha: 0.75),
                    margin: LayoutMargin = .init(),
                    spacing: LayoutSpacing = .init(),
                    size: LayoutSize = .init(width: .proportional(minimumRatio: 0.75, maximumRatio: 0.75)),
                    buttonGroupAxis: ButtonGroupAxis = .automatic) {
            
            self.titleHeight = titleHeight
            self.messageHeight = messageHeight
            self.buttonHeight = buttonHeight
            self.grabberColor = grabberColor
            self.titleTextAttributes = titleTextAttributes
            self.titleTextAlignment = titleTextAlignment
            self.titleNumberOfLines = titleNumberOfLines
            self.messageTextAttributes = messageTextAttributes
            self.messageTextAlignment = messageTextAlignment
            self.messageNumberOfLines = messageNumberOfLines
            self.textFieldContainerBorderColor = textFieldContainerBorderColor
            self.textFieldContainerBorderWidth = textFieldContainerBorderWidth
            self.backgroundColor = backgroundColor
            self.backgroundBorderColor = backgroundBorderColor
            self.backgroundBorderWidth = backgroundBorderWidth
            self.shadow = shadow
            self.cornerRadius = cornerRadius
            self.dimmedBackgroundViewColor = dimmedBackgroundViewColor
            self.margin = margin
            self.spacing = spacing
            self.size = size
            self.buttonGroupAxis = buttonGroupAxis
        }
    }
}


// MARK: - Background

public extension TSAlertController.ViewConfiguration {
    
    /// Defines the background style of the alert.
    enum Background {
        
        /// A blurred background using a specified `UIBlurEffect.Style`.
        case blur(UIBlurEffect.Style)
        
        /// A solid color background with an optional alpha value.
        ///
        /// - Parameters:
        ///   - color: The background color.
        ///   - alpha: The opacity of the background color, ranging from `0.0` (fully transparent) to `1.0` (fully opaque). Defaults to `1.0`.
        case color(UIColor, alpha: CGFloat = 1.0)
        
        /// A gradient background with customizable colors, direction, and location stops.
        ///
        /// - Parameters:
        ///   - colors: An array of `CGColor` defining the gradient colors.
        ///   - startPoint: The starting point of the gradient, where `(0,0)` represents the top-left and `(1,1)` represents the bottom-right. Default is `.zero`.
        ///   - endPoint: The ending point of the gradient. Default is `(1.0, 1.0)`, creating a diagonal gradient.
        ///   - locations: An optional array of `NSNumber` values defining the color stop positions in the gradient.
        case grdient([CGColor],
                     startPoint: CGPoint = .zero,
                     endPoint: CGPoint = .init(x: 1.0, y: 1.0),
                     locations: [NSNumber]? = nil)
    }
}

// MARK: - LayoutMargin

public extension TSAlertController.ViewConfiguration {
    
    /// Defines the margin values used for content and button layout.
    struct LayoutMargin {
        
        /// The top margin of the content area.
        public var contentTop: CGFloat
        
        /// The left margin of the content area.
        public var contentLeft: CGFloat
        
        /// The right margin of the content area.
        public var contentRight: CGFloat
        
        /// The left margin of the button area.
        public var buttonLeft: CGFloat
        
        /// The right margin of the button area.
        public var buttonRight: CGFloat
        
        /// The bottom margin of the button area.
        public var buttonBottom: CGFloat
        
        /// Initializes a `LayoutMargin` configuration with default or custom values.
        ///
        /// - Parameters:
        ///   - contentTop: The top margin for the content area. Default is `22.5`.
        ///   - contentLeft: The left margin for the content area. Default is `17.5`.
        ///   - contentRight: The right margin for the content area. Default is `17.5`.
        ///   - buttonLeft: The left margin for the button area. Default is `17.5`.
        ///   - buttonRight: The right margin for the button area. Default is `17.5`.
        ///   - buttonBottom: The bottom margin for the button area. Default is `17.5`.
        public init(contentTop: CGFloat = 22.5,
                    contentLeft: CGFloat = 17.5,
                    contentRight: CGFloat = 17.5,
                    buttonLeft: CGFloat = 17.5,
                    buttonRight: CGFloat = 17.5,
                    buttonBottom: CGFloat = 17.5) {
            
            self.contentTop = contentTop
            self.contentLeft = contentLeft
            self.contentRight = contentRight
            self.buttonLeft = buttonLeft
            self.buttonRight = buttonRight
            self.buttonBottom = buttonBottom
        }
    }
}


// MARK: - LayoutSpacing

public extension TSAlertController.ViewConfiguration {
    
    /// Defines spacing values between various elements inside the alert.
    struct LayoutSpacing {
        
        /// The spacing between the title and the message.
        public var titleMessageSpacing: CGFloat
        
        /// The spacing between the message and the text field.
        public var messageTextfieldSpacing: CGFloat
        
        /// The spacing between the text field and the button.
        public var textfieldButtonSpacing: CGFloat
        
        /// The spacing between buttons in the button group.
        public var buttonSpacing: CGFloat
        
        /// The spacing between the bottom of the alert view and the top of the keyboard when the keyboard appears.
        public var keyboardSpacing: CGFloat
        
        /// Initializes a `LayoutSpacing` configuration with default or custom values.
        ///
        /// - Parameters:
        ///   - titleMessageSpacing: The spacing between the title and message. Default is `12.5`.
        ///   - messageTextfieldSpacing: The spacing between the message and text field. Default is `12.5`.
        ///   - textfieldButtonSpacing: The spacing between the text field and the button. Default is `16.5`.
        ///   - buttonSpacing: The spacing between buttons in the button group. Default is `7.5`.
        ///   - keyboardSpacing: The spacing between the alert bottom and the keyboard top. Default is `100`.
        public init(titleMessageSpacing: CGFloat = 12.5,
                    messageTextfieldSpacing: CGFloat = 12.5,
                    textfieldButtonSpacing: CGFloat = 16.5,
                    buttonSpacing: CGFloat = 7.5,
                    keyboardSpacing: CGFloat = 100) {
            
            self.titleMessageSpacing = titleMessageSpacing
            self.messageTextfieldSpacing = messageTextfieldSpacing
            self.textfieldButtonSpacing = textfieldButtonSpacing
            self.buttonSpacing = buttonSpacing
            self.keyboardSpacing = keyboardSpacing
        }
    }
}

// MARK: - LayoutSize

public extension TSAlertController.ViewConfiguration {
    
    /// Defines size constraints for the alert view.
    struct LayoutSize {
        
        /// The width constraint for the alert.
        public var width: LayoutSize.Constraint
        
        /// The height constraint for the alert.
        public var height: LayoutSize.Constraint
        
        /// Initializes a `LayoutSize` configuration with width and height constraints.
        ///
        /// - Parameters:
        ///   - width: The width constraint for the alert. Default is `.proportional()`.
        ///   - height: The height constraint for the alert. Default is `.proportional()`.
        public init(width: LayoutSize.Constraint = .proportional(),
                    height: LayoutSize.Constraint = .proportional()) {
            
            self.width = width
            self.height = height
        }
    }
}

// MARK: - LayoutSize.Constraint

public extension TSAlertController.ViewConfiguration.LayoutSize {
    
    /// Defines the constraints for the alert’s width and height.
    enum Constraint {
        
        /// A fixed size constraint with an exact value.
        ///
        /// - Parameter value: The fixed size in points.
        case fixed(CGFloat)
        
        /// A flexible size constraint with a minimum and maximum limit.
        ///
        /// - Parameters:
        ///   - minimum: The minimum allowable size. Default is `10`.
        ///   - maximum: The maximum allowable size.
        case flexible(minimum: CGFloat = 10, maximum: CGFloat)
        
        /// A proportional size constraint relative to the screen size.
        ///
        /// - Parameters:
        ///   - minimumRatio: The minimum ratio of the screen size. Default is `0.1` (10% of the screen size).
        ///   - maximumRatio: The maximum ratio of the screen size. Default is `0.8` (80% of the screen size).
        case proportional(minimumRatio: CGFloat = 0.1, maximumRatio: CGFloat = 0.8)
    }
}

extension TSAlertController.ViewConfiguration.LayoutSize.Constraint: Comparable {
    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.fixed(lValue), .fixed(rValue)):
            return lValue < rValue
            
        case let (.flexible(lMin, lMax), .flexible(rMin, rMax)):
            return lMin < rMin && lMax < rMax
            
        case let (.proportional(lMinRatio, lMaxRatio), .proportional(rMinRatio, rMaxRatio)):
            return lMinRatio < rMinRatio && lMaxRatio < rMaxRatio
            
            //
        default:
            return true
        }
    }
    
    public static func > (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.fixed(lValue), .fixed(rValue)):
            return lValue > rValue
            
        case let (.flexible(lMin, lMax), .flexible(rMin, rMax)):
            return lMin > rMin && lMax > rMax
            
        case let (.proportional(lMinRatio, lMaxRatio), .proportional(rMinRatio, rMaxRatio)):
            return lMinRatio > rMinRatio && lMaxRatio > rMaxRatio
            
            //
        default:
            return true
        }
    }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.fixed(lValue), .fixed(rValue)):
            return lValue == rValue
            
        case let (.flexible(lMin, lMax), .flexible(rMin, rMax)):
            return lMin == rMin && lMax == rMax
            
        case let (.proportional(lMinRatio, lMaxRatio), .proportional(rMinRatio, rMaxRatio)):
            return lMinRatio == rMinRatio && lMaxRatio == rMaxRatio
            
            //
        default:
            return true
        }
    }
}


// MARK: - Button LayoutAxis

public extension TSAlertController.ViewConfiguration {
    
    /// Defines the axis layout for the button group in the alert.
    enum ButtonGroupAxis {
        
        /// Automatically determines the axis based on the number of buttons.
        ///
        /// - Uses a horizontal layout if there are two or fewer buttons.
        /// - Uses a vertical layout if there are more than two buttons.
        case automatic
        
        /// Arranges buttons in a vertical layout.
        case vertical
        
        /// Arranges buttons in a horizontal layout.
        case horizontal
        
        /// Resolves the actual axis based on the number of buttons when `automatic` is selected.
        ///
        /// - Parameter buttonCount: The number of buttons in the button group.
        /// - Returns: `.horizontal` if there are two or fewer buttons, otherwise `.vertical`.
        func resolvedAxis(for buttonCount: Int) -> ButtonGroupAxis {
            switch self {
            case .automatic:
                return buttonCount <= 2 ? .horizontal : .vertical
            default:
                return self
            }
        }
        
        /// Converts `ButtonGroupAxis` to the corresponding `NSLayoutConstraint.Axis` value.
        ///
        /// - Returns: `.horizontal` for `.horizontal` and `.automatic` (default to horizontal),
        ///            `.vertical` for `.vertical`.
        func toNSLayoutConstraintAxis() -> NSLayoutConstraint.Axis {
            switch self {
            case .horizontal, .automatic:
                return .horizontal
            case .vertical:
                return .vertical
            }
        }
    }
}
