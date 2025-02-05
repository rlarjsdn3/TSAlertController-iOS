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

///
public typealias TSAlertActionHandler = (TSAlertAction) -> Void

///
public class TSAlertAction {
    
    // MARK: - Properties
    
    ///
    public var title: String?
    
    ///
    public var style: TSAlertAction.Style
    
    ///
    public var handler: TSAlertActionHandler?
    
    
    ///
    public var highlightType: TSButton.HighlightType = .fadeInAndScaleDown()
    
    ///
    public var configuration: TSButton.Configuration = .init()
    
    ///
    private var button: TSButton?
    
    ///
    public var isEnabled: Bool = true {
        didSet { updateButtonState() }
    }

    
    // MARK: - Intializer
    
    ///
    public init(title: String?,
                style: TSAlertAction.Style = .default,
                handler: TSAlertActionHandler? = nil) {
        
        self.title = title
        self.style = style
        self.handler = handler
    }
    
    // MARK: - Instantiate
    
    ///
    func instantiateButton(for preferredStyle: TSAlertController.Style) -> TSButton? {
        adjustConfiguration(for: preferredStyle)
        
        let button = TSButton(config: configuration)
        button.highlightType = highlightType
        button.isEnabled = isEnabled
        button.addAction(createButtonAction(), for: .touchUpInside)
        
        self.button = button
        
        return button
    }
    
    
    // MARK: - Private
    
    private func adjustConfiguration(for preferredStyle: TSAlertController.Style) {
        configureTitle()
        configureImage(for: preferredStyle)
        adjustConfigurationBasedOnStyle()
    }
    
    private func createButtonAction() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self else { return }
            self.handler?(self)
            self.dismissAlert()
        }
    }
    
    private func dismissAlert() {
        Helper.topController()?.dismiss(animated: true)
    }
    
    private func updateButtonState() {
        button?.isEnabled = isEnabled
    }
    
}


// MARK: - Extension

private extension TSAlertAction {
    
    ///
    private func configureTitle() {
        configuration.title = title
    }
    
    ///
    func configureImage(for preferredStyle: TSAlertController.Style) {
        if preferredStyle == .alert {
            configuration = configuration.configurationWithoutImageAndAccessoryImage()
        }
    }
    
    ///
    func adjustConfigurationBasedOnStyle() {
        if style == .destructive {
            configuration.backgroundColor = .systemRed
        }
    }
}
