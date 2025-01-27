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

class TSAlertContainerView: UIStackView, TSAlertView {
    
    // MARK: - Properties
    
    private var viewConfig: TSAlertController.ViewConfiguration
    
    // MARK: - Intializer
    
    init(with viewConfiguration: TSAlertController.ViewConfiguration) {
        self.viewConfig = viewConfiguration
        super.init(frame: .zero)
        
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Create View
    
    func createView(for alert: TSAlertController) {
        guard let superview = superview else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: viewConfig.margin.contentTop),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -viewConfig.margin.contentBottom),
            self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: viewConfig.margin.contentLeft),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -viewConfig.margin.contentRight)
        ])
        
        configureContentView(for: alert)
        configureButtonsView(for: alert)
    }
    
    // MARK: - Private
    
    private func configure() {
        self.axis = .vertical
        self.spacing = 20
        self.alignment = .fill
        self.distribution = .fillProportionally
    }
    
    private func configureContentView(for alert: TSAlertController) {
        let contentView = TSAlertContentView(
            title: alert.title,
            message: alert.message,
            viewConfig: viewConfig
        )
        addArrangedSubview(contentView)
    }
    
    private func configureButtonsView(for alert: TSAlertController) {
        let buttonsView = TSAlertButtonStackView(
            actions: alert.actions,
            viewConfig: viewConfig
        )
        
        var height: CGFloat = 0
        let actionsCount = CGFloat(alert.actions.count)
        let actionHeight: CGFloat = 37.5
        let spacing: CGFloat = 7.5
        
        //
        if viewConfig.buttonLayoutAxis.isHorizontal(for: alert.actions) {
            height = 42.5
        //
        } else {
            height = (actionHeight * actionsCount) + ((actionsCount - 1) * spacing)
        }
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.heightAnchor.constraint(equalToConstant: height).isActive = true
        addArrangedSubview(buttonsView)
    }
}
