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

/// A type alias for the action handler used in `TSAlertAction`.
public typealias TSAlertActionHandler = (TSAlertAction) -> Void

/// Represents an action that can be added to `TSAlertController`, defining its title, style, and behavior.
public class TSAlertAction {
    
    // MARK: - Properties
    
    /// The title of the action, displayed on the button.
    public var title: String?
    
    /// The style of the action, determining its appearance and position.
    public var style: TSAlertAction.Style
    
    /// The handler that is executed when the action is triggered.
    public var handler: TSAlertActionHandler?
    
    /// The highlight effect applied to the action button when tapped.
    public var highlightType: TSButton.HighlightType = .fadeInAndScaleDown
    
    /// The button configuration, defining the appearance and interaction of the button.
    public var configuration: TSButton.Configuration = .init()
    
    /// The button instance associated with this action.
    private var button: TSButton?
    
    /// A Boolean value indicating whether the action is enabled.
    ///
    /// If set to `false`, the associated button is disabled.
    public var isEnabled: Bool = true {
        didSet { updateButtonState() }
    }
    
    /// Determines whether the alert should automatically dismiss when a button is tapped.
    ///
    /// If set to `false`, you must manually call the `dismiss(completion:)` method inside the handler closure.
    public var automaticallyDismissOnTap: Bool = true

    
    // MARK: - Initializer
    
    /// Initializes a new action with a title, style, and an optional handler.
    ///
    /// - Parameters:
    ///   - title: The title of the action.
    ///   - style: The style of the action, defining its appearance. Default is `.default`.
    ///   - handler: The closure executed when the action is triggered. Default is `nil`.
    public init(title: String?,
                style: TSAlertAction.Style = .default,
                handler: TSAlertActionHandler? = nil) {
        
        self.title = title
        self.style = style
        self.handler = handler
    }
    
    // MARK: - Helper
    
    /// Creates and returns a configured button for the alert action.
    ///
    /// - Parameter preferredStyle: The preferred style of the alert controller.
    /// - Returns: A `TSButton` instance configured for the action.
    func instantiateButton(for preferredStyle: TSAlertController.Style) -> TSButton? {
        adjustConfiguration(for: preferredStyle)
        
        let button = TSButton(configuration: configuration)
        button.highlightType = highlightType
        button.isEnabled = isEnabled
        button.addAction(createButtonAction(), for: .touchUpInside)
        
        self.button = button
        return button
    }
    
    /// Programmatically triggers the action as if the button was tapped.
    public func sendAction() {
        button?.sendActions(for: .touchUpInside)
    }
    
    /// Dismisses the alert containing this action.
    public func dismiss(animated: Bool,
                        completion: (() -> Void)? = nil) {
        Helper.topController()?.dismiss(animated: true, completion: completion)
    }

    // MARK: - Private
    
    /// Adjusts the button configuration based on the alert's preferred style.
    private func adjustConfiguration(for preferredStyle: TSAlertController.Style) {
        configureTitle()
        configureImage(for: preferredStyle)
        adjustConfigurationBasedOnStyle()
    }
    
    /// Creates and returns a UIAction to be executed when the button is tapped.
    ///
    /// - Returns: A `UIAction` that triggers the action’s handler and dismisses the alert.
    private func createButtonAction() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self else { return }
            self.handler?(self)
            
            if self.automaticallyDismissOnTap {
                self.dismiss(animated: true)
            }
        }
    }
    
    /// Updates the button’s enabled state to match the action’s `isEnabled` property.
    private func updateButtonState() {
        button?.isEnabled = isEnabled
    }
}

// MARK: - Configuration Extensions

private extension TSAlertAction {
    
    /// Configures the title for the action button.
    func configureTitle() {
        configuration.title = title
    }
    
    /// Adjusts the button configuration by removing images if the alert style is `.alert`.
    ///
    /// - Parameter preferredStyle: The preferred style of the alert controller.
    func configureImage(for preferredStyle: TSAlertController.Style) {
        if preferredStyle == .alert {
            configuration = configuration.configurationWithoutImageAndAccessoryImage()
        }
    }
    
    /// Modifies the button appearance based on the action style.
    func adjustConfigurationBasedOnStyle() {
        if style == .destructive {
            configuration.backgroundColor = .systemRed
        }
    }
}
