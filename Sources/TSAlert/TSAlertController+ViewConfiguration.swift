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
        public var titleAttributes: [NSAttributedString.Key: Any]?
        
        /// The text alignment of the title.
        public var titleAlignment: NSTextAlignment
        
        /// The number of lines for the title. If `0`, the title expands dynamically.
        public var titleNumberOfLines: Int
        
        /// Text attributes for styling the message.
        public var messageAttributes: [NSAttributedString.Key: Any]?
        
        /// The text alignment of the message.
        public var messageAlignment: NSTextAlignment
        
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
        public var cornerRadius: CornerRadius
        
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
        
        ///
        public struct CornerRadius: ExpressibleByFloatLiteral {
            
            ///
            public var topLeft: CGFloat
            
            ///
            public var topRight: CGFloat
            
            ///
            public var bottomLeft: CGFloat
            
            ///
            public var bottomRight: CGFloat
            
            ///
            public init(allCorners: CGFloat = 20) {
                self.init(topLeft: allCorners,
                          topRight: allCorners,
                          bottomLeft: allCorners,
                          bottomRight: allCorners)
            }
            
            ///
            public init(topLeft: CGFloat = 20,
                        topRight: CGFloat = 20,
                        bottomLeft: CGFloat = 20,
                        bottomRight: CGFloat = 20) {
                self.topLeft = topLeft
                self.topRight = topRight
                self.bottomLeft = bottomLeft
                self.bottomRight = bottomRight
            }
        
            ///
            public init(floatLiteral value: FloatLiteralType) {
                self.init(allCorners: value)
            }
        }
        
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
        ///   - buttonHeight: The height of each button in the button group. Default is `45`.
        ///   - grabberColor: The color of the grabber (handle). Default is `.grabber`.
        ///   - titleTextAttributes: The text attributes for the title. Defaults to a headline font with `.alertLabel` color.
        ///   - titleTextAlignment: The alignment of the title text. Defaults to `.left`.
        ///   - titleNumberOfLines: The maximum number of lines for the title. Default is `0` (dynamic height).
        ///   - messageTextAttributes: The text attributes for the message. Defaults to a subheadline font with `.alertSecondaryLabel` color.
        ///   - messageTextAlignment: The alignment of the message text. Defaults to `.left`.
        ///   - messageNumberOfLines: The maximum number of lines for the message. Default is `0` (dynamic height).
        ///   - textFieldContainerBorderColor: The border color of the text field container. Default is `.alertGray`.
        ///   - textFieldContainerBorderWidth: The border width of the text field container. Default is `0.75`.
        ///   - backgroundColor: The background style of the alert. Default is `.alertBackground`.
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
                    buttonHeight: CGFloat = 45,
                    grabberColor: UIColor? = .grabber,
                    titleTextAttributes: [NSAttributedString.Key : Any]? = [.font: UIFont.preferredFont(forTextStyle: .headline),
                                                                            .foregroundColor: UIColor.alertLabel],
                    titleTextAlignment: NSTextAlignment = .left,
                    titleNumberOfLines: Int = 0,
                    messageTextAttributes: [NSAttributedString.Key : Any]? = [.font: UIFont.preferredFont(forTextStyle: .subheadline),
                                                                              .foregroundColor: UIColor.alertSecondaryLabel],
                    messageTextAlignment: NSTextAlignment = .left,
                    messageNumberOfLines: Int = 0,
                    textFieldContainerBorderColor: CGColor? = UIColor.alertGray.cgColor,
                    textFieldContainerBorderWidth: CGFloat = 0.75,
                    backgroundColor: Background = .color(.alertBackground),
                    backgroundBorderColor: CGColor? = nil,
                    backgroundBorderWidth: CGFloat = 0,
                    shadow: Shadow? = nil,
                    cornerRadius: CornerRadius = .init(allCorners: 20),
                    dimmedBackgroundViewColor: Background? = .color(.black.withAlphaComponent(0.75)),
                    margin: LayoutMargin = .init(),
                    spacing: LayoutSpacing = .init(),
                    size: LayoutSize = .init(width: .proportional(minimumRatio: 0.75, maximumRatio: 0.75)),
                    buttonGroupAxis: ButtonGroupAxis = .automatic) {
            
            self.titleHeight = titleHeight
            self.messageHeight = messageHeight
            self.buttonHeight = buttonHeight
            self.grabberColor = grabberColor
            self.titleAttributes = titleTextAttributes
            self.titleAlignment = titleTextAlignment
            self.titleNumberOfLines = titleNumberOfLines
            self.messageAttributes = messageTextAttributes
            self.messageAlignment = messageTextAlignment
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
        case color(UIColor)
        
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



// MARK: - UIColor

public extension UIColor {
    
    /// A dynamic white color used for alert components.
    /// - Light mode: `RGB(255, 255, 255)` (Pure White)
    /// - Dark mode: `RGB(255, 255, 255)` (Pure White)
    static var alertWhite: UIColor {
        .init(light: .init(r: 255, g: 255, b: 255),
              dark: .init(r: 255, g: 255, b: 255))
    }
    
    /// A dynamic gray color for alert elements such as separators and subtle backgrounds.
    /// - Light mode: `RGB(78, 87, 100)` (Dark Gray)
    /// - Dark mode: `RGB(195, 195, 198)` (Light Gray)
    static var alertGray: UIColor {
        .init(light: .init(r: 78, g: 87, b: 100),
              dark: .init(r: 195, g: 195, b: 198))
    }
    
    /// A dynamic black color for alert content, such as text and icons.
    /// - Light mode: `RGB(26, 31, 39)` (Deep Black)
    /// - Dark mode: `RGB(255, 255, 255)` (Pure White)
    static var alertBlack: UIColor {
        .init(light: .init(r: 26, g: 31, b: 39),
              dark: .init(r: 255, g: 255, b: 255))
    }
    
    /// A dynamic color used for alert titles.
    /// - Light mode: `RGB(53, 61, 75)` (Dark Navy Gray)
    /// - Dark mode: `RGB(228, 228, 229)` (Light Gray)
    static var alertLabel: UIColor {
        .init(light: .init(r: 53, g: 61, b: 75),
              dark: .init(r: 228, g: 228, b: 229))
    }
    
    /// A dynamic color used for alert messages, providing a subtle contrast to the title.
    /// - Light mode: `RGB(75, 85, 98)` (Muted Gray)
    /// - Dark mode: `RGB(196, 196, 199)` (Soft Gray)
    static var alertSecondaryLabel: UIColor {
        .init(light: .init(r: 75, g: 85, b: 98),
              dark: .init(r: 196, g: 196, b: 199))
    }
    
    /// A dynamic color for the alert background, ensuring readability in both modes.
    /// - Light mode: `RGB(255, 255, 255)` (Pure White)
    /// - Dark mode: `RGB(44, 44, 52)` (Dark Grayish Blue)
    static var alertBackground: UIColor {
        .init(light: .init(r: 255, g: 255, b: 255),
              dark: .init(r: 31, g: 32, b: 39))
    }
    
    /// A secondary background color, often used for buttons or additional alert sections.
    /// - Light mode: `RGB(242, 245, 246)` (Soft Light Gray)
    /// - Dark mode: `RGB(63, 63, 74)` (Muted Dark Gray)
    static var alertSecondaryBackground: UIColor {
        .init(light: .init(r: 242, g: 245, b: 246),
              dark: .init(r: 63, g: 63, b: 74))
    }
    
    /// A dynamic color for the grabber (handle) used in action sheets or draggable alerts.
    /// - Light mode: `RGB(229, 232, 235)` (Soft Light Gray)
    /// - Dark mode: `RGB(59, 60, 70)` (Muted Dark Gray)
    static var grabber: UIColor {
        .init(light: .init(r: 229, g: 232, b: 235),
               dark: .init(r: 59, g: 60, b: 70))
    }
}
