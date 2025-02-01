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
    public var options: TSAlertController.Options = []
    
    ///
    public var preferredStyle: TSAlertController.Style = .alert
    
    ///
    public var actions: [TSAlertAction] = []
    
    ///
    public var textfields: [UITextField]  = []
    
    ///
    public lazy var configuration: TSAlertController.Configuration = Self.defaultConfiguration(preferredStyle: preferredStyle)
    
    ///
    public lazy var transitionStyle: TSAlertController.TransitionStyle = Self.defaultTransitionStyle(preferredStyle: preferredStyle)
    
    
    ///
    private var child: (any TSAlertView)?
    
    ///
    private var background = UIView()
    
    
    ///
    private var initialAlertTopY: CGFloat = 0
    
    ///
    private var keyboardShiftTopY: CGFloat = 0
    
    
    // MARK: - Initializer
    
    ///
    public init(title: String?,
                message: String? = nil,
                options: TSAlertController.Options = [],
                preferredStyle style: TSAlertController.Style) {
        
        self._title = title
        self.message = message
        self.options = options
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
        
        checkVaildConfigurationBeforePresent()
        initializeController()
        configureController()
        registerKeyboardObservers()
        registerGestureRecognizers()
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
#if targetEnvironment(simulator)
        initialAlertTopY = view.frame.origin.y
#endif
        activateFirstResponderIfNeeded()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        unregisterKeyboardObservers()
    }

    // MARK: - Helpers

    ///
    private func initializeController() {
        self.child = DefaultAlertView(with: configuration)
        
        guard let alertView = child else { return }
        view.addSubview(alertView)
        alertView.createView(for: self)
        view.applySizeConstraint(with: configuration.size)
    }
    
    ///
    private func configureController() {
        switch configuration.backgroundColor {
        case let .color(color, alpha):
            view.backgroundColor = color.withAlphaComponent(alpha)
        case let .effect(style):
            view.addBlurEffect(style, with: configuration)
        }
        
        view.layer.borderColor = configuration.backgroundBorderColor
        view.layer.borderWidth = configuration.backgroundBorderWidth
        view.layer.cornerRadius = configuration.cornerRadius
        
        guard let shadow = configuration.shadow else { return }
        view.layer.shadowColor = shadow.color
        view.layer.shadowOffset = shadow.offset
        view.layer.shadowOpacity = shadow.opacity
        view.layer.shadowRadius = shadow.radius
    }
    
    ///
    private func checkVaildConfigurationBeforePresent() {
        if case .actionSheet = preferredStyle {
            let width = configuration.size.width
            let minimumAllowedWidth = Configuration.LayoutSize.Constraint.proportional(minimumRatio: 0.95, maximumRatio: 0.95)
            
            //
            if width < minimumAllowedWidth {
                configuration.size.width = minimumAllowedWidth
                print(configuration.size.width)
            }
            configuration.buttonLayoutAxis = .vertical
        }
    }

    ///
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

    ///
    private func unregisterKeyboardObservers() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    ///
    private func registerGestureRecognizers() {
        addGestureRecognizerIfNeeded(for: .interactiveScaleAndDrag,
                                     gesture: UIPanGestureRecognizer(target: self,
                                                                     action: #selector(handleTapDragSpringGesture(_:))),
                                     to: view)
        
        addGestureRecognizerIfNeeded(for: .dismissOnDragDown,
                                     gesture: UIPanGestureRecognizer(target: self,
                                                                     action: #selector(handleSwipeToDismissGesture(_:))),
                                     to: view)
        
        addGestureRecognizerIfNeeded(for: .dismissOnTapOutside,
                                     gesture: UITapGestureRecognizer(target: self,
                                                                     action: #selector(handleTapOutsideToDismissGesture(_:))),
                                     to: background)
        addGestureRecognizerIfNeeded(for: .dismissOnTapInside,
                                     gesture: UITapGestureRecognizer(target: self, action: #selector(handleTapInsideToDismissGesture(_:))),
                                     to: view)
    }
    
    
    
    
    
    ///
    private func addGestureRecognizerIfNeeded(for option: Options,
                                              gesture: UIGestureRecognizer,
                                              to targetView: UIView) {
        guard options.contains(option) else { return }
        targetView.addGestureRecognizer(gesture)
        
        if let panGesture = gesture as? UIPanGestureRecognizer {
            panGesture.delegate = self
        }
    }

    ///
    private func activateFirstResponderIfNeeded() {
        if let textField = textfields.first, textField.canBecomeFirstResponder {
            textField.becomeFirstResponder()
        }
    }
    
    
    // MARK: - Present
    
    ///
    public func present(after delay: TimeInterval = 0.0,
                        haptic type: UINotificationFeedbackGenerator.FeedbackType? = nil,
                        completion: (() -> Void)? = nil) {
        
    }
    
    
    // MARK: - Dismiss
    
    ///
    public func dismiss(completion: (() -> Void)? = nil) {
        guard let presenting = self.presentingViewController else { return }
        presenting.dismiss(animated: true, completion: completion)
    }
    
    
    // MARK: - Deinitializer
    
#if targetEnvironment(simulator)
    deinit {
        print("Deinit \(Self.self)")
    }
#endif
    
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
        let adjustedAlertTopY = keyboardTopY - configuration.spacing.keyboardSpacing - alertHeight
        
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

private extension TSAlertController {
    
    @objc private func handleTapInsideToDismissGesture(_ gesture: UITapGestureRecognizer) {
        dismiss()
    }
    
    @objc private func handleTapOutsideToDismissGesture(_ gesture: UITapGestureRecognizer) {
        dismiss()
    }
    
    @objc private func handleSwipeToDismissGesture(_ gesture: UIPanGestureRecognizer) {
        
        guard let presentingView = self.presentingViewController?.view else { return }
        
        //
        let dismissThreshold: CGFloat = 100
        let velocityThreshold: CGFloat = 800
        
        //
        let velocity = gesture.velocity(in: self.view)
        let translation = gesture.translation(in: self.view)

        switch gesture.state {
        case .changed:
            //
            if translation.y > 0 {
                self.view.transform = CGAffineTransform(translationX: translation.x * 0.1, y: translation.y)
                
                //
                if options.contains(.interactiveScaleAndDrag) {
                    self.view.transform = CGAffineTransform(translationX: translation.x * 0.1, y: translation.y)
                        .scaledBy(x: 0.95, y: 0.95)
                }
            }
            
        case .ended, .cancelled, .failed:
            
            let shouldDismiss = (translation.y > dismissThreshold) || (velocity.y > velocityThreshold)
            
            //
            if shouldDismiss {
                UIView.animate(withDuration: 0.5,
                               delay: 0,
                               usingSpringWithDamping: 0.6,
                               initialSpringVelocity: 1.0,
                               options: .curveEaseOut,
                               animations: {
                    self.view.alpha = 0
                    self.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                    self.view.frame.origin.y = presentingView.frame.maxY + 100
                    self.background.alpha = 0.0
                }, completion: { finished in
                    if finished { self.dismiss() }
                })
            //
            } else {
                UIView.animate(withDuration: 0.5,
                               delay: 0,
                               usingSpringWithDamping: 0.6,
                               initialSpringVelocity: 1.0,
                               options: .curveEaseOut,
                               animations: {
                    self.view.transform = .identity // 원래 위치로 복귀
                })
            }
            
        default:
            break
        }
    }
    
    @objc private func handleTapDragSpringGesture(_ gesture: UIPanGestureRecognizer) {
        
        //
        let interplationFactor: CGFloat = 0.1
        let translation = gesture.translation(in: self.view)
        
        switch gesture.state {
        case .began:
            //
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 1.0,
                           options: .curveEaseOut,
                           animations: {
                self.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            })
            
        case .changed:
                self.view.transform = CGAffineTransform(translationX: translation.x * interplationFactor,
                                                        y: translation.y * interplationFactor).scaledBy(x: 0.95, y: 0.95)
            
        case .ended, .cancelled, .failed:
            //
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 1.0,
                           options: .curveEaseOut,
                           animations: {
                self.view.transform = .identity
            })
            
        default:
            break
        }
    }
}


private extension TSAlertController {
    
    ///
    private static func defaultConfiguration(preferredStyle: TSAlertController.Style) -> TSAlertController.Configuration {
        switch preferredStyle {
        case .alert:
            return .init()
            
        case .actionSheet:
            return .init(size: .init(width: .proportional(minimumRatio: 0.95, maximumRatio: 0.95)), buttonLayoutAxis: .vertical)
        }
    }
    
    ///
    private static func defaultTransitionStyle(preferredStyle: TSAlertController.Style) -> TSAlertController.TransitionStyle {
        switch preferredStyle {
        case .alert:
            return .fadeAndScaleDown
            
        case .actionSheet:
            return .slideUp
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
                                             dimmedView: background,
                                             preferredStyle: preferredStyle,
                                             config: configuration)
    }
    
    public func animationController(forPresented presented: UIViewController,
                                    presenting resenting: UIViewController,
                                    source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        
        return transitionStyle.resolve(presenting: true)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        
        return transitionStyle.resolve(presenting: false)
    }
}


// MARK: - UIGestureRecognizerDelegate

extension TSAlertController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
}
