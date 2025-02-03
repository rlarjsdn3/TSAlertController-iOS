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
    public var image: UIImage?
    
    ///
    public var style: TSAlertAction.Style
    
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
                style: TSAlertAction.Style = .default,
                handler: TSAlertActionHandler?) {
        
        self.title = title
        self.image = image
        self.style = style
        self.handler = handler
    }
    
    // MARK: - Make
    
    ///
    func instantiateButton(_ style: TSAlertController.Style) -> TSButton {
        applyConfiguration(to: button)
        button.addAction(createButtonAction(), for: .touchUpInside)
        return button
    }
    
    
    // MARK: - Private
    
    ///
    private func applyConfiguration(to button: TSButton) {
        if let title = title {
            let titleString = NSAttributedString(string: title,
                                                 attributes: style.titleAttributes)
            button.setAttributedTitle(titleString, for: .normal)
        }

        var config = UIButton.Configuration.filled()
        config.imagePlacement = style.imagePlacement
        config.imageReservation = style.imageReservation
        config.contentInsets = style.contentEdgeInset
        config.background.backgroundColor = style.backgroundColor
        config.background.cornerRadius = style.cornerRadius
        button.configuration = config

        button.contentVerticalAlignment = style.contentVerticalAlignment
        button.contentHorizontalAlignment = style.contentHorizontalAlignment
        button.highlightType = style.highlightType
        button.isEnabled = isEnabled
    }
    
    ///
    private func createButtonAction() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self = self else { return }
            self.handler?(self)
            self.dismissAlert()
        }
    }
    
    private func dismissAlert() {
        Helper.topController()?.dismiss(animated: true)
    }
    
    ///
    private func updateButtonEnabled() {
        button.isEnabled = isEnabled
    }
    
}
