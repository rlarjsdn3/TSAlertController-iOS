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

class DefaultAlertView: UIView, TSAlertView {
    
    // MARK: - Properties
    
    private let grabber = UIView()
    
    private let buttonGroupView: UIView
    private let contentView: UIView
    
    private let viewConfiguration: TSAlertController.ViewConfiguration
    private let configuration: TSAlertController.Configuration
    
    
    // MARK: - Intializer
    
    init(_ alert: TSAlertController,
         contentView: UIView,
         buttonGroupView: UIView,
         viewConfiguration: TSAlertController.ViewConfiguration,
         configuration: TSAlertController.Configuration) {
        self.contentView = contentView
        self.buttonGroupView = buttonGroupView
        self.viewConfiguration = viewConfiguration
        self.configuration = configuration
        super.init(frame: .zero)
        
        addSubview(contentView)
        addSubview(buttonGroupView)
        
        let isEmpty = alert.actions.isEmpty
        let textfieldButtonSpacing = isEmpty
        ? 0
        : viewConfiguration.spacing.textfieldButtonSpacing
        
        if configuration.prefersGrabberVisible {
            addSubview(grabber)
            grabber.centerX(in: self)
            grabber.anchor(top: self.topAnchor, topInset: 12.5)
            grabber.setWidth(equalTo: 50)
            grabber.setHeight(equalTo: 4)
            
            grabber.layer.cornerRadius = 2
            grabber.backgroundColor = .systemGray5
        }
        
        contentView.anchor(top: configuration.prefersGrabberVisible
                           ? grabber.bottomAnchor : self.topAnchor ,
                           leading: self.leadingAnchor,
                           trailing: self.trailingAnchor,
                           bottom: buttonGroupView.topAnchor,
                           topInset: viewConfiguration.margin.contentTop,
                           leadingInset: viewConfiguration.margin.contentLeft,
                           trailingInset: viewConfiguration.margin.contentRight,
                           bottomInset: textfieldButtonSpacing)
        
        buttonGroupView.anchor(leading: self.leadingAnchor,
                       trailing: self.trailingAnchor,
                       bottom: self.bottomAnchor,
                       leadingInset: viewConfiguration.margin.buttonLeft,
                       trailingInset: viewConfiguration.margin.buttonRight,
                       bottomInset: viewConfiguration.margin.buttonBottom)

        let actionsCount = CGFloat(alert.actions.count)
        let actionHeight: CGFloat = viewConfiguration.buttonHeight
        let spacing: CGFloat = viewConfiguration.spacing.buttonSpacing
        
        let height: CGFloat = if !isEmpty {
            isHorizontal
            ? actionHeight
            : (actionHeight * actionsCount) + ((actionsCount - 1) * spacing)
        } else {
            0
        }
        buttonGroupView.setHeight(equalTo: height)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Animate View
    
    func animateView(for alert: TSAlertController) {
        
        if let header = alert.configuration.headerAnimation {
            header.apply(to: contentView)
            UIView.animate(withDuration: 0.5) {
                header.undo(for: self.contentView)
            }
        }
        
        if let buttonGroup = alert.configuration.buttonGroupAnimation {
            buttonGroup.apply(to: buttonGroupView)
            UIView.animate(withDuration: 0.5) {
                buttonGroup.undo(for: self.buttonGroupView)
            }
        }
    }
}


// MARK: - Extension

fileprivate extension DefaultAlertView {
    
    var isHorizontal: Bool {
        return viewConfiguration.buttonGroupAxis == .horizontal
    }
}
