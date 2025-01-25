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
    
    private var viewConfiguration: TSAlertController.ViewConfiguration
    
    // MARK: - Intializer
    
    init(viewConfiguration: TSAlertController.ViewConfiguration) {
        self.viewConfiguration = viewConfiguration
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
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: viewConfiguration.margin.contentTop),
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: viewConfiguration.margin.contentBottom),
            self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: viewConfiguration.margin.contentLeft),
            self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: viewConfiguration.margin.contentRight)
        ])
        
        setupContentView(for: alert)
        setupButtonsView(for: alert)
    }
    
    // MARK: - Private
    
    private func configure() {
        self.axis = .vertical
        self.spacing = 10
        self.alignment = .fill
        self.distribution = .fillProportionally
    }
    
    private func setupContentView(for alert: TSAlertController) {
        let contentView = TSAlertContentView(
            title: alert.title,
            message: alert.message,
            viewConfiguration: viewConfiguration
        )
        addArrangedSubview(contentView)
    }
    
    private func setupButtonsView(for alert: TSAlertController) {
        let buttonsView = TSAlertButtonStackView(
            actions: alert.actions,
            viewConfiguration: viewConfiguration
        )
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        addArrangedSubview(buttonsView)
    }
}
