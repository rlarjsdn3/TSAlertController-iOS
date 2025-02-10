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

final class TSAlertPresentationController: UIPresentationController {
    
    // MARK: - Properties
    
    private let background: UIView
    
    private let preferredStyle: TSAlertController.Style
    
    private let viewConfiguration: TSAlertController.ViewConfiguration
    
    private let configuration: TSAlertController.Configuration
    
    
    // MARK: - Initializer
    
    init(presented presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?,
         background view: UIView,
         preferredStyle style: TSAlertController.Style,
         viewConfiguration: TSAlertController.ViewConfiguration,
         configuration: TSAlertController.Configuration) {
        self.background = view
        self.preferredStyle = style
        self.viewConfiguration = viewConfiguration
        self.configuration = configuration
        super.init(presentedViewController: presentedViewController,
                   presenting: presentingViewController)
    }
    
    // MARK: - Lifecycle
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        setupHierarchy()
        setupConstraints()
        setupAttributes()
        
        animateBackgroundAppearance(presenting: true)
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        animateBackgroundAppearance(presenting: false)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        
        if completed {
            background.removeFromSuperview()
        }
    }

    
    // MARK: - Setup
    
    private func setupHierarchy() {
        guard let containerView else { return }
        
        containerView.addSubview(background)
        containerView.addSubview(presentedViewController.view)
    }
    
    private func setupConstraints() {
        guard let containerView else { return }
        background.fill(to: containerView)

        let presentedView = presentedViewController.view!
        switch preferredStyle {
        case .alert:
            presentedView.center(in: containerView)
            
        case .actionSheet:
            presentedView.centerX(in: containerView)
            presentedView.anchor(bottom: containerView.safeAreaLayoutGuide.bottomAnchor, bottomInset: 10)
        }
    }
    
    private func setupAttributes() {
        background.alpha = 0.0

        switch viewConfiguration.dimmedBackgroundViewColor {
        case let .color(color, alpha):
            background.backgroundColor = color.withAlphaComponent(alpha)
        case let .blur(style):
            background.addBlurEffectView(style)
        case let .grdient(colors, startPoint, endPoint, locations):
            background.addGradientView(colors,
                                       startPoint,
                                       endPoint,
                                       locations,
                                       with: viewConfiguration)
        case .none:
            break
        }
    }
    
    
    // MARK: - Private

    private func animateBackgroundAppearance(presenting: Bool) {
        let alpha: CGFloat = presenting ? 1.0 : 0.0
        let coordinator = presentedViewController.transitionCoordinator
        
        coordinator?.animate(alongsideTransition: { _ in
            self.background.alpha = alpha
        })
    }
}


