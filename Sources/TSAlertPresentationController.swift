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
import UIKit

///
final class TSAlertPresentationController: UIPresentationController {
    
    // MARK: - Properties
    
    ///
    private let dimmingView = UIView()
    
    ///
    private let viewConfiguration: TSAlertController.ViewConfiguration
    
    
    // MARK: - Intializer
    
    ///
    init(presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?,
         viewConfiguration: TSAlertController.ViewConfiguration) {
        self.viewConfiguration = viewConfiguration
        
        super.init(presentedViewController: presentedViewController,
                   presenting: presentingViewController)
    }

    
    // MARK: - Lifecycle
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        configure(with: viewConfiguration)
        
        let coordinator = presentedViewController.transitionCoordinator
        
        coordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        let coordinator = presentedViewController.transitionCoordinator
        
        coordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }
    
    
    // MARK: - Configure
    
    private func configure(with viewConfiguration: TSAlertController.ViewConfiguration) {
        
        dimmingView.alpha = 0.0
        if case let .color(color, alpha) = viewConfiguration.dimmedBackgroundViewColor {
            dimmingView.backgroundColor = color.withAlphaComponent(alpha)
        }
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        guard let containerView else { return }
        
        containerView.addSubview(presentedViewController.view)
        presentedViewController.view.applyCenterXYConstraint(in: containerView)
        
        containerView.insertSubview(dimmingView, at: 0)
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
