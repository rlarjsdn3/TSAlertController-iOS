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
    public var textfields: [UITextField]  = []
    
    ///
    public var configuration: TSAlertController.Configuration = .init()
    
    ///
    public var viewConfiguration: TSAlertController.ViewConfiguration = .init()
    
    ///
    public var alertTransitionStyle: TSAlertController.AlertTransitionStyle = .automatic
    
    
    ///
    private var alertView: TSAlertView?
    
    
    ///
    private var initialAlertTopY: CGFloat = 0
    
    ///
    private var keyboardShiftTopY: CGFloat = 0
    
    
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
        
        initializeAlertView()
        configure(with: viewConfiguration)
        registerKeyboardObservers()
    }

    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        initialAlertTopY = view.frame.origin.y
        activateFirstResponderIfNeeded()
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        unregisterKeyboardObservers()
    }

    // MARK: - Helpers

    private func initializeAlertView() {
        self.alertView = DefaultAlertView(with: viewConfiguration)
        
        guard let alertView = alertView else { return }
        view.addSubview(alertView)
        alertView.createView(for: self)
        view.applySizeConstraint(with: viewConfiguration.size)
    }

    private func registerKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    private func unregisterKeyboardObservers() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }

    private func activateFirstResponderIfNeeded() {
        if let textField = textfields.first, textField.canBecomeFirstResponder {
            textField.becomeFirstResponder()
        }
    }

    private func configure(with viewConfig: TSAlertController.ViewConfiguration) {
        switch viewConfig.backgroundColor {
        case let .color(color, alpha):
            view.backgroundColor = color.withAlphaComponent(alpha)
        case let .effect(style):
            view.addBlurEffect(style, with: viewConfig)
        }
        
        view.layer.borderColor = viewConfiguration.backgroundBorderColor
        view.layer.borderWidth = viewConfiguration.backgroundBorderWidth
        view.layer.cornerRadius = viewConfiguration.cornerRadius
        
        guard let shadow = viewConfiguration.shadow else { return }
        view.layer.shadowColor = shadow.color
        view.layer.shadowOffset = shadow.offset
        view.layer.shadowOpacity = shadow.opacity
        view.layer.shadowRadius = shadow.radius
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

private extension TSAlertController {
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let keyboardAnimationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else {
            return
        }

        self.initialAlertTopY = view.frame.origin.y

        let alertTopY = initialAlertTopY
        let keyboardTopY = keyboardFrame.origin.y
        let alertHeight = view.frame.height

        let duration = keyboardAnimationDuration.doubleValue
        let adjustedAlertTopY = keyboardTopY - configuration.alertKeyboardSpacing - alertHeight
        
        // Move the alert up only if the spacing is smaller than the configured value.
        // If the space between the alert and the keyboard is greater than the configured value, the alert will not move.
        if adjustedAlertTopY < alertTopY {
            animate(to: adjustedAlertTopY, withDuration: duration)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
              let keyboardAnimationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else {
            return
        }
        let duration = keyboardAnimationDuration.doubleValue
        
        // To test it properly, switch to software keyboard mode (Command + K) before displaying the alert.
        animate(to: initialAlertTopY, withDuration: duration)
    }
    
    func animate(to yConstant: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseIn) {
            self.view.frame.origin.y = yConstant
        }
    }
}


// MARK: - UIViewControllerTransitioningDelegate

extension TSAlertController: UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController,
                                       presenting: UIViewController?,
                                       source: UIViewController) -> UIPresentationController? {
        return TSAlertPresentationController(presentedViewController: presented,
                                             presenting: presenting,
                                             viewConfig: viewConfiguration)
    }
    
    public func animationController(forPresented presented: UIViewController,
                                    presenting resenting: UIViewController,
                                    source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        
//        return alertTransitionStyle.resolveAnimator(for: true)
        return SlideUpAnimator(duration: 0.5, presenting: true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        
//        return alertTransitionStyle.resolveAnimator(for: false)
        return SlideUpAnimator(duration: 0.5, presenting: false)
    }
}


