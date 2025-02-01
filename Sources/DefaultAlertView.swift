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
    
    private var configuration: TSAlertController.Configuration
    
    // MARK: - Intializer
    
    init(with configuration: TSAlertController.Configuration) {
        self.configuration = configuration
        super.init(frame: .zero)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Create View
    
    func createView(for alert: TSAlertController) {
        guard let superview = superview else { return }
        
        let contentsView = DefaultContentsView(alert,
                                              configuration: configuration)
        let buttonsView = DefaultButtonsView(alert,
                                             configuration: configuration)
        
        addSubview(buttonsView)
        addSubview(contentsView)
        
        self.anchor(top: superview.topAnchor,
                    leading: superview.leadingAnchor,
                    trailing: superview.trailingAnchor,
                    bottom: superview.bottomAnchor,
                    topInset: 0,
                    leadingInset: 0,
                    trailingInset: 0,
                    bottomInset: 0)
        
        contentsView.anchor(top: self.topAnchor,
                            leading: self.leadingAnchor,
                            trailing: self.trailingAnchor,
                            bottom: buttonsView.topAnchor,
                            topInset: configuration.margin.contentTop,
                            leadingInset: configuration.margin.contentLeft,
                            trailingInset: configuration.margin.contentRight,
                            bottomInset: configuration.spacing.textfieldButtonSpacing)
        
        buttonsView.anchor(leading: self.leadingAnchor,
                           trailing: self.trailingAnchor,
                           bottom: self.bottomAnchor,
                           leadingInset: configuration.margin.buttonLeft,
                           trailingInset: configuration.margin.buttonRight,
                           bottomInset: configuration.margin.buttonBottom)

        var height: CGFloat = 0
        let actionsCount = CGFloat(alert.actions.count)
        let actionHeight: CGFloat = configuration.buttonMinHeight
        let spacing: CGFloat = 7.5
        
        //
        if configuration.isButtonLayoutAxisHorizontal(alert) {
            height = actionHeight
        //
        } else {
            height = (actionHeight * actionsCount) + ((actionsCount - 1) * spacing)
        }
        buttonsView.setHeight(greaterThanOrEqualTo: height)
    }
    
    
    // MARK: - Animate View
    
    func animateView(for alert: TSAlertController) {
    }
}
