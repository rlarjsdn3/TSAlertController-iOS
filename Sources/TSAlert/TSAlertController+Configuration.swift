
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
    
    /// A configuration struct that defines various behaviors of the alert.
    struct Configuration {
        
        /// The transition animation type when the alert appears.
        public var enteringTransition: TSAlertController.EnteringTransitionType?
        
        /// The transition animation type when the alert disappears.
        public var exitingTransition: TSAlertController.ExitingTransitionType?
        
        /// The animation type for the alert's header when presented.
        public var headerAnimation: TSAlertController.AnimationType?
        
        /// The animation type for the button group when presented.
        public var buttonGroupAnimation: TSAlertController.AnimationType?
        
        /// A Boolean value indicating whether a grabber (handle) should be visible.
        public var prefersGrabberVisible: Bool
        
        /// Initializes a `Configuration` with optional transition and animation settings.
        ///
        /// - Parameters:
        ///   - enteringTransition: The transition animation for presenting the alert. Defaults to `nil`.
        ///   - exitingTransition: The transition animation for dismissing the alert. Defaults to `nil`.
        ///   - headerAnimation: The animation type for the alert’s header. Defaults to `nil`.
        ///   - buttonGroupAnimation: The animation type for the button group. Defaults to `nil`.
        ///   - prefersGrabberVisible: A Boolean flag indicating whether the grabber is visible. Defaults to `true`.
        public init(enteringTransition: TSAlertController.EnteringTransitionType? = nil,
                    exitingTransition: TSAlertController.ExitingTransitionType? = nil,
                    headerAnimation: TSAlertController.AnimationType? = nil,
                    buttonGroupAnimation: TSAlertController.AnimationType? = nil,
                    prefersGrabberVisible: Bool = true) {
            
            self.enteringTransition = enteringTransition
            self.exitingTransition = exitingTransition
            self.headerAnimation = headerAnimation
            self.buttonGroupAnimation = buttonGroupAnimation
            self.prefersGrabberVisible = prefersGrabberVisible
        }
    }
}
