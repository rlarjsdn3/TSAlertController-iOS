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

class DefaultContentsView: UIStackView {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    
    private let labelStack = UIStackView()
    private let textfieldStack = UIStackView()
    
    // MARK: - Intializer
    
    init(_ alert: TSAlertController,
         configuration: TSAlertController.Configuration) {
        super.init(frame: .zero)
        
        labelStack.axis = .vertical
        labelStack.spacing = configuration.spacing.titleMessageSpacing
        labelStack.alignment = .fill
        labelStack.distribution = .fillProportionally
        
        let title = alert.title
        titleLabel.text = title
        titleLabel.textAlignment = configuration.titleTextAlignment
        titleLabel.numberOfLines = configuration.titleNumberOfLines
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: configuration.titleMinHeight).isActive = true
        if let titleTextAttributes = configuration.titleTextAttributes {
            let attrText = NSAttributedString(string: title ?? "",
                                              attributes: titleTextAttributes)
            titleLabel.attributedText = attrText
        }
        labelStack.addArrangedSubview(titleLabel)
        
        if let message = alert.message {
            messageLabel.text = message
            messageLabel.textAlignment = configuration.messageTextAlignment
            messageLabel.numberOfLines = configuration.messageNumberOfLines
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: configuration.messageMinHeight).isActive = true
            if let messageTextAttributes = configuration.messageTextAttributes {
                let attrText = NSAttributedString(string: message,
                                                  attributes: messageTextAttributes)
                messageLabel.attributedText = attrText
            }
            labelStack.addArrangedSubview(messageLabel)
        }
        addArrangedSubview(labelStack)
        
        if alert.textfields.isEmpty == false {
            let textfields = alert.textfields
            let borderColor = configuration.textFieldContainerBorderColor
            let borderWidth = configuration.textFieldContainerBorderWidth
            
            textfieldStack.axis = .vertical
            textfieldStack.spacing = 5
            textfieldStack.alignment = .fill
            textfieldStack.distribution = .fillProportionally
            
            textfieldStack.isLayoutMarginsRelativeArrangement = true
            textfieldStack.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
            
            textfieldStack.layer.borderColor = borderColor
            textfieldStack.layer.borderWidth = borderWidth
            textfieldStack.layer.cornerRadius = 10
            textfieldStack.layer.cornerCurve = .continuous
            
            let textfieldHeight: CGFloat = 22.5
            let textfieldCount = CGFloat(textfields.count)
            let margin: CGFloat = 5 * 2  // Outer margin for elements (5 * 2)
            let spacing: CGFloat = 5 * 2 // Spacing between elements (5 * 2)
            
            // Calculate the total height (margin + two spacings + text field heights)
            let totalHeight = margin + (spacing * (textfieldCount - 1)) + (textfieldHeight * textfieldCount)
            textfieldStack.translatesAutoresizingMaskIntoConstraints = false
            textfieldStack.heightAnchor.constraint(equalToConstant: totalHeight).isActive = true
            
            for (index, textfield) in textfields.enumerated() {
                textfield.setPaddingInsets(.edge(10))
                textfieldStack.addArrangedSubview(textfield)
                if index < textfields.count - 1 {
                    textfieldStack.addArrangedSubview(createSeparatorView((borderColor != nil) ? UIColor(cgColor: borderColor!) : nil, height: borderWidth))
                }
            }
            addArrangedSubview(textfieldStack)
        }
        
        configure(with: configuration)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func configure(with viewConfig: TSAlertController.Configuration) {
        self.axis = .vertical
        self.spacing = viewConfig.spacing.messageTextfieldSpacing
        self.alignment = .fill
        self.distribution = .fillProportionally
    }
}


// MARK: - Extension

private extension DefaultContentsView {
    
    func createSeparatorView(_ color: UIColor?, height: CGFloat) -> UIView {
        let separator = UIView()
        separator.backgroundColor = color
        separator.heightAnchor.constraint(equalToConstant: height).isActive = true
        return separator
    }
}
