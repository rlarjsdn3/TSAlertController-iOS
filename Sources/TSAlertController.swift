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
public class TSAlertController: UIViewController {
    
    // MARK: - Properties
    
    ///
    public override var title: String? {
        get { return _title }
        set { _title = newValue }
    }
    
    private var _title: String?
    
    ///
    public var message: String?
    
    ///
    public var preferredStyle: TSAlertController.Style?
    
    ///
    public var actions: [TSAlertAction] = []
    
    ///
    public var textfields: [UITextField] = []
    
    ///
    public var configuration: TSAlertController.Configuration = .init()
    
    ///
    public var viewConfiguration: TSAlertController.ViewConfiguration = .init()
    
    ///
    public var alertTransitionStyle: TSAlertController.AlertTransitionStyle = .automatic
    
    
    ///
    private var containerView: TSAlertView?
    
    
    // MARK: - Initializer
    
    ///
    public init(title: String?,
                message: String? = nil,
                preferredStyle style: TSAlertController.Style) {
        
        self._title = title
        self.message = message
        self.preferredStyle = style
        super.init(nibName: nil, bundle: nil)
        
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.containerView = TSAlertContainerView(with: viewConfiguration)
        
        view.addSubview(containerView!)
        view.applySizeConstraint(with: viewConfiguration.size)
        containerView?.createView(for: self)
        view.layoutIfNeeded()
        
        configure(with: viewConfiguration)
    }
    
    // MARK: - Configure
    
    private func configure(with viewConfig: TSAlertController.ViewConfiguration) {

        switch viewConfig.backgroundColor {
        case let .color(color, alpha):
            view.backgroundColor = color.withAlphaComponent(alpha)
        case let .effect(style):
            view.addBlurEffect(style, with: viewConfiguration)
        }
        view.layer.borderColor = viewConfig.backgroundBorderColor
        view.layer.borderWidth = viewConfig.backgroundBorderWidth
        
        if let shadow = viewConfig.shadow {
            view.layer.addShadow(shadow.color,
                                 shadow.offset,
                                 shadow.opacity,
                                 shadow.radius)
        }
        view.layer.cornerRadius = viewConfiguration.cornerRadius
    }
    
    
    // MARK: - Present
    
    ///
    public func present(after delay: TimeInterval = 0.0,
                        haptic type: UINotificationFeedbackGenerator.FeedbackType? = nil,
                        completion: (() -> Void)? = nil) {
        
    }
    
    
    // MARK: - Dismiss
    
    ///
    public func dismiss(completion: (() -> Void)?) {
        
    }
    
    
    // MARK: - Deinitializer
    
    deinit {
        print("Deinit \(Self.self)")
    }
    
}


// MARK: - Extensions

public extension TSAlertController {
    
    ///
    func addAction(_ action: TSAlertAction) {
        actions.append(action)
    }
    
    ///
    func addTextField(configurationHandler: (UITextField) -> Void) {
        let textfield = UITextField()
        configurationHandler(textfield)
        textfield.borderStyle = .none
        textfields.append(textfield)
    }
}


// MARK: - UIViewControllerTransitioningDelegate

extension TSAlertController: UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController,
                                       presenting: UIViewController?,
                                       source: UIViewController) -> UIPresentationController? {
        return TSAlertPresentationController(presentedViewController: presented,
                                            presenting: presenting,
                                            viewConfiguration: viewConfiguration)
    }
    
    public func animationController(forPresented presented: UIViewController,
                                    presenting resenting: UIViewController,
                                    source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        
        return alertTransitionStyle.resolveAnimator(for: true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        
        return alertTransitionStyle.resolveAnimator(for: false)
    }
}


