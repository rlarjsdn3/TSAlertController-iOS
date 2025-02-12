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

class DefaultContentView: UIStackView {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    
    private let labelStack = UIStackView()
    private let textfieldStack = UIStackView()
    
    // MARK: - Intializer
    
    init(title: String?,
         message: String?,
         textFields: [UITextField]? = nil,
         viewConfiguration: TSAlertController.ViewConfiguration,
         configuration: TSAlertController.Configuration) {
        super.init(frame: .zero)
        
        labelStack.axis = .vertical
        labelStack.spacing = viewConfiguration.spacing.titleMessageSpacing
        labelStack.alignment = .fill
        labelStack.distribution = .fillProportionally
        
        if let title = title {
            let attrText = NSAttributedString(string: title,
                                              attributes: viewConfiguration.titleTextAttributes ?? [:])
            titleLabel.attributedText = attrText
            titleLabel.text = title
            titleLabel.textAlignment = viewConfiguration.titleTextAlignment
            titleLabel.numberOfLines = viewConfiguration.titleNumberOfLines
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: viewConfiguration.titleHeight ?? 0).isActive = true
            // Prevents the label from growing too large unnecessarily, but allows it to expand if needed.
            titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
            // Ensures the label does not shrink too much, preventing text from being cut off.
            titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            titleLabel.setHeight(greaterThanOrEqualTo: viewConfiguration.titleHeight ?? 0)
            labelStack.addArrangedSubview(titleLabel)
        }
        
        if let message = message {
            let attrText = NSAttributedString(string: message,
                                              attributes: viewConfiguration.messageTextAttributes ?? [:])
            messageLabel.attributedText = attrText
            messageLabel.text = message
            messageLabel.textAlignment = viewConfiguration.messageTextAlignment
            messageLabel.numberOfLines = viewConfiguration.messageNumberOfLines
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            messageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: viewConfiguration.messageHeight ?? 0).isActive = true
            // Prevents the label from growing too large unnecessarily, but allows it to expand if needed.
            messageLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
            // Ensures the label does not shrink too much, preventing text from being cut off.
            messageLabel.setContentCompressionResistancePriority(.required, for: .vertical)
            messageLabel.setHeight(greaterThanOrEqualTo: viewConfiguration.messageHeight ?? 0)
            labelStack.addArrangedSubview(messageLabel)
        }
        addArrangedSubview(labelStack)
        
        if textFields?.isEmpty == false, let textfields = textFields {
            let borderColor = viewConfiguration.textFieldContainerBorderColor
            let borderWidth = viewConfiguration.textFieldContainerBorderWidth
            
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
        
        configure(with: viewConfiguration)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func configure(with viewConfiguration: TSAlertController.ViewConfiguration) {
        self.axis = .vertical
        self.spacing = viewConfiguration.spacing.messageTextfieldSpacing
        self.alignment = .fill
        self.distribution = .fill
    }
}


// MARK: - Extension

fileprivate extension DefaultContentView {
    
    func createSeparatorView(_ color: UIColor?, height: CGFloat) -> UIView {
        let separator = UIView()
        separator.backgroundColor = color
        separator.heightAnchor.constraint(equalToConstant: height).isActive = true
        return separator
    }
}
