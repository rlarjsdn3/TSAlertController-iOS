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

///
final class TSAlertPresentationController: UIPresentationController {
    
    // MARK: - Properties
    
    ///
    private let dimmedView: UIView
    
    ///
    private let preferredStyle: TSAlertController.Style
    
    ///
    private let configuration: TSAlertController.Configuration
    
    
    // MARK: - Initializer
    
    ///
    init(presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?,
         dimmedView view: UIView,
         preferredStyle style: TSAlertController.Style,
         config: TSAlertController.Configuration) {
        self.dimmedView = view
        self.preferredStyle = style
        self.configuration = config
        super.init(presentedViewController: presentedViewController,
                   presenting: presentingViewController)
    }
    
    // MARK: - Lifecycle
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        setupViewHierarchy()
        setupViewConstraints()
        containerView?.layoutIfNeeded()
        
        configureDimmedView(with: configuration)
        
        animateDimmedViewAppearance(presenting: true)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        animateDimmedViewAppearance(presenting: false)
    }
    
    
    // MARK: - View Setup
    
    ///
    private func setupViewHierarchy() {
        guard let containerView else { return }
        
        containerView.addSubview(dimmedView)
        containerView.addSubview(presentedViewController.view)
    }
    
    ///
    private func setupViewConstraints() {
        guard let containerView else { return }
        let presentedView = presentedViewController.view
        
        dimmedView.fill(to: containerView)
        
        switch preferredStyle {
        case .alert:
            presentedView?.center(in: containerView)
            
        case .actionSheet:
            presentedView?.centerX(in: containerView)
            presentedView?.anchor(bottom: containerView.safeAreaLayoutGuide.bottomAnchor, bottomInset: 10)
        }
    }
    
    ///
    private func configureDimmedView(with config: TSAlertController.Configuration) {
        dimmedView.alpha = 0
        
        switch config.dimmedBackgroundViewColor {
        case let .color(color, alpha):
            dimmedView.backgroundColor = color.withAlphaComponent(alpha)
        case let .effect(style):
            dimmedView.addBlurEffect(style, with: config)
        case .none:
            break
        }
    }
    
    
    // MARK: - Private
    
    ///
    private func animateDimmedViewAppearance(presenting: Bool) {
        let alpha: CGFloat = presenting ? 1.0 : 0.0
        let coordinator = presentedViewController.transitionCoordinator
        
        coordinator?.animate(alongsideTransition: { _ in
            self.dimmedView.alpha = alpha
        })
    }
}


