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

class Helper {
    
    /// Returns the top-most view controller in the current window hierarchy.
    ///
    /// This method starts from the root view controller and traverses through presented view controllers
    /// until it finds the top-most visible view controller.
    ///
    /// - Returns: The top-most `UIViewController` in the application, or `nil` if no view controller is found.
    static func topController() -> UIViewController? {
        var topController = keyWindow()?.rootViewController
        
        while let presented = topController?.presentedViewController {
            topController = presented
        }
        return topController
    }
    
    /// Retrieves the current key window of the application.
    ///
    /// This method iterates through all connected scenes and returns the first available key window.
    ///
    /// - Returns: The `UIWindow` instance that is currently active, or `nil` if no key window is found.
    static func keyWindow() -> UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else {
                continue
            }
            
            if windowScene.windows.isEmpty {
                continue
            }
            
            guard let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
                continue
            }
            return window
        }
        return nil
    }
}
