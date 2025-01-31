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
    
    /// This property is applied only when the `preferredStyle` of `TSAlertController` is set to `.actionSheet`.
    public var image: UIImage?
    
    ///
    public var configuration: TSAlertAction.StyleConfiguration
    
    ///
    public var handler: TSAlertActionHandler?
    
    ///
    public var isEnabled: Bool = true {
        didSet { updateButtonEnabled() }
    }
    
    ///
    private var button = TSButton()
    
    
    // MARK: - Intializer
    
    ///
    public init(title: String?,
                image: UIImage? = nil,
                configuration: TSAlertAction.StyleConfiguration = .default(),
                handler: TSAlertActionHandler?) {
        
        self.title = title
        self.image = image
        self.configuration = configuration
        self.handler = handler
    }
    
    // MARK: - Make
    
    ///
    func instantiateButton(preferredStyle style: TSAlertController.Style) -> TSButton {
        applyConfiguration(to: button)
        button.addAction(createButtonAction(), for: .touchUpInside)
        return button
    }
    
    
    // MARK: - Private
    
    ///
    private func applyConfiguration(to button: TSButton) {
        if let title = title {
            let titleString = NSAttributedString(string: title,
                                                 attributes: configuration.titleAttributes)
            button.setAttributedTitle(titleString, for: .normal)
        }

        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.imagePlacement = configuration.imagePlacement
        buttonConfig.imageReservation = configuration.imageReservation
        buttonConfig.contentInsets = configuration.contentEdgeInset
        buttonConfig.background.backgroundColor = configuration.backgroundColor
        buttonConfig.background.cornerRadius = configuration.cornerRadius
        button.configuration = buttonConfig

        button.contentVerticalAlignment = configuration.contentVerticalAlignment
        button.contentHorizontalAlignment = configuration.contentHorizontalAlignment
        button.highlightType = configuration.highlightType
        button.isEnabled = isEnabled
    }
    
    ///
    private func createButtonAction() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self = self else { return }
            self.handler?(self)
            Helper.topController()?.dismiss(animated: true)
        }
    }
    
    ///
    private func updateButtonEnabled() {
        button.isEnabled = isEnabled
    }
    
}
