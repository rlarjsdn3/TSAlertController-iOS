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

class ContentView: UIStackView {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    
    private let labelStack = UIStackView()
    private let textfieldStack = UIStackView()
    
    // MARK: - Intializer
    
    init(title: String?,
         message: String? = nil,
         textfields: [UITextField]? = nil,
         viewConfig: TSAlertController.Configuration) {
        super.init(frame: .zero)
        
        labelStack.axis = .vertical
        labelStack.spacing = viewConfig.spacing.titleMessageSpacing
        labelStack.alignment = .fill
        labelStack.distribution = .fillProportionally
        
        titleLabel.text = title
        titleLabel.textAlignment = viewConfig.titleTextAlignment
        titleLabel.numberOfLines = viewConfig.titleNumberOfLines
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: viewConfig.titleMinHeight).isActive = true
        if let titleTextAttributes = viewConfig.titleTextAttributes {
            let attrText = NSAttributedString(string: title ?? "",
                                              attributes: titleTextAttributes)
            titleLabel.attributedText = attrText
        }
        labelStack.addArrangedSubview(titleLabel)
        
        if let message = message {
            messageLabel.text = message
            messageLabel.textAlignment = viewConfig.messageTextAlignment
            messageLabel.numberOfLines = viewConfig.messageNumberOfLines
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: viewConfig.messageMinHeight).isActive = true
            if let messageTextAttributes = viewConfig.messageTextAttributes {
                let attrText = NSAttributedString(string: message,
                                                  attributes: messageTextAttributes)
                messageLabel.attributedText = attrText
            }
            labelStack.addArrangedSubview(messageLabel)
        }
        addArrangedSubview(labelStack)
        
        if textfields?.isEmpty == false, let textfields = textfields {
            let borderColor = viewConfig.textFieldContainerBorderColor
            let borderWidth = viewConfig.textFieldContainerBorderWidth
            
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
                    textfieldStack.addArrangedSubview(createSeparatorView((borderColor != nil) ? UIColor(cgColor: borderColor!) : nil))
                }
            }
            addArrangedSubview(textfieldStack)
        }
        
        configure(with: viewConfig)
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

private extension ContentView {
    
    func createSeparatorView(_ color: UIColor?) -> UIView {
        let separator = UIView()
        separator.backgroundColor = color
        separator.heightAnchor.constraint(equalToConstant: 0.75).isActive = true
        return separator
    }
}
