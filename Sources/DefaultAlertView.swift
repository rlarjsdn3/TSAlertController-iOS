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
    
    private let buttonGroupView: UIView
    private let contentView: UIView
    
    private var configuration: TSAlertController.ViewConfiguration
    
    
    // MARK: - Intializer
    
    init(_ alert: TSAlertController,
         _ contentView: UIView,
         _ buttonsView: UIView,
         _ configuration: TSAlertController.ViewConfiguration) {
        self.contentView = contentView
        self.buttonGroupView = buttonsView
        self.configuration = configuration
        super.init(frame: .zero)
        
        addSubview(contentView)
        addSubview(buttonsView)
        
        let isEmpty = alert.actions.isEmpty
        let textfieldButtonSpacing = isEmpty
        ? 0
        : configuration.spacing.textfieldButtonSpacing
        
        contentView.anchor(top: self.topAnchor,
                       leading: self.leadingAnchor,
                       trailing: self.trailingAnchor,
                       bottom: buttonsView.topAnchor,
                       topInset: configuration.margin.contentTop,
                       leadingInset: configuration.margin.contentLeft,
                       trailingInset: configuration.margin.contentRight,
                       bottomInset: textfieldButtonSpacing)
        
        buttonsView.anchor(leading: self.leadingAnchor,
                       trailing: self.trailingAnchor,
                       bottom: self.bottomAnchor,
                       leadingInset: configuration.margin.buttonLeft,
                       trailingInset: configuration.margin.buttonRight,
                       bottomInset: configuration.margin.buttonBottom)

        let actionsCount = CGFloat(alert.actions.count)
        let actionHeight: CGFloat = configuration.buttonHeight
        let spacing: CGFloat = configuration.spacing.buttonSpacing
        
        let height: CGFloat = if !isEmpty {
            isHorizontal
            ? actionHeight
            : (actionHeight * actionsCount) + ((actionsCount - 1) * spacing)
        } else {
            0
        }
        buttonsView.setHeight(equalTo: height)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Animate
    
    ///
    func animateView(for alert: TSAlertController) {
        //
        if let type = alert.configuration.headerAnimation {
            type.apply(to: contentView)
            UIView.animate(withDuration: 0.5) {
                type.undo(for: self.contentView)
            }
        }
        
        //
        if let type = alert.configuration.buttonGroupAnimation {
            type.apply(to: buttonGroupView)
            UIView.animate(withDuration: 0.5) {
                type.undo(for: self.buttonGroupView)
            }
        }
    }
}


// MARK: - Extension

fileprivate extension DefaultAlertView {
    
    var isHorizontal: Bool {
        return configuration.buttonLayoutAxis == .horizontal
    }
}
