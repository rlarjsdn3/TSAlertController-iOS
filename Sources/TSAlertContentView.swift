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

class TSAlertContentView: UIStackView {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()

    
    // MARK: - Intializer
    
    init(title: String?,
         message: String? = nil,
         viewConfiguration: TSAlertController.ViewConfiguration) {
        super.init(frame: .zero)
        
        titleLabel.text = title
        titleLabel.textAlignment = viewConfiguration.titleTextAlignment
        titleLabel.numberOfLines = viewConfiguration.titleNumberOfLines
        if let titleTextAttributes = viewConfiguration.titleTextAttributes {
            let attrText = NSAttributedString(string: title ?? "",
                                              attributes: titleTextAttributes)
            titleLabel.attributedText = attrText
        }
        addArrangedSubview(titleLabel)
        
        if let message = message {
            messageLabel.text = message
            messageLabel.textAlignment = viewConfiguration.messageTextAlignment
            messageLabel.numberOfLines = viewConfiguration.messageNumberOfLines
            if let messageTextAttributes = viewConfiguration.messageTextAttributes {
                let attrText = NSAttributedString(string: message,
                                                  attributes: messageTextAttributes)
                messageLabel.attributedText = attrText
            }
            addArrangedSubview(messageLabel)
        }
        
        configure(with: viewConfiguration)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func configure(with configuration: TSAlertController.ViewConfiguration) {
        self.axis = .vertical
        self.spacing = 5
        self.alignment = .fill
        self.distribution = .fill
    }
    
}
