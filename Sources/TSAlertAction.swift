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
    public var leftImage: UIImage?
    
    ///
    public var rightImage: UIImage?
    
    ///
    public var highlightType: TSButton.HighlightType = .fadeAndScaleDown()
    
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
                handler: TSAlertActionHandler?) {
        
        self.title = title
        self.style = style
        self.handler = handler
    }
    
    // MARK: - Instantiate
    
    ///
    func instantiateButton(for style: TSAlertController.Style) -> TSButton? {
        adjustConfiguration()
        
        let button = (style == .alert) ? TSButton(title: title, config: configuration)
        : TSButton(leftImage: leftImage, title: title, rightImage: rightImage, config: configuration)
        button.highlightType = highlightType
        button.isEnabled = isEnabled
        button.addAction(createButtonAction(), for: .touchUpInside)
        
        self.button = button
        
        return button
    }
    
    
    // MARK: - Private
    
    private func adjustConfiguration() {
        adjustTitleAttributes(&configuration.titleAttributes)
        adjustSymbolConfiguration(&configuration.preferredSymbolConfigurationForLeftImage)
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


// MARK: - Adjust Configuration

private extension TSAlertAction {
    
    ///
    func adjustTitleAttributes(_ attributes: inout [NSAttributedString.Key: Any]?) {
        if style == .destructive {
            attributes?[.foregroundColor] = UIColor.systemRed
        }
    }
    
    ///
    func adjustSymbolConfiguration(_ config: inout UIImage.SymbolConfiguration?) {
        if style == .destructive {
            config = config?.applying(UIImage.SymbolConfiguration(paletteColors: [.systemRed])) ??
                     UIImage.SymbolConfiguration(paletteColors: [.systemRed])
        }
    }
}












public extension TSAlertAction {
    
    ///
    enum Style {
        
        ///
        case cancel
        
        ///
        case `default`
        
        ///
        case destructive
    }
}

extension TSAlertAction.Style: Equatable {
}
