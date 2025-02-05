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
    public lazy var configuration: TSAlertController.Configuration = .init()

    ///
    public lazy var viewConfiguration: TSAlertController.ViewConfiguration = .init()
    
    ///
    private var customView: UIView?
    
    ///
    private var alertView: (any TSAlertView)?
    
    ///
    private var background = UIView()
    
    
    ///
    private var initialViewTopY: CGFloat = 0
    
    ///
    private var keyboardShiftTopY: CGFloat = 0
    
    
    // MARK: - Initializer
    
    ///
    public init(_ customView: UIView,
                options: TSAlertController.Options = [],
                preferredStyle style: TSAlertController.Style) {
        
        self.customView = customView
        self.options = options
        self.preferredStyle = style
        super.init(nibName: nil, bundle: nil)
        
        commonInit()
    }
    
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
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
        
        applyConfiguration(for: preferredStyle)
        applyViewConfiguration(for: preferredStyle)
    }
    
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        adjustConfiguration()
        adjustViewConfiguration()
        
        initializeAlertView()
        registerKeyboardNotifications()
        registerGestureRecognizers()
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        activateFirstResponderIfNeeded()
        alertView?.animateView(for: self)
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        unregisterKeyboardNotifications()
    }

    // MARK: - Private
    
    /// Configures the initial `Configuration` settings based on the specified `TSAlertController.Style`.
    /// This method is called when creating a `TSAlertController` instance.
    ///
    /// - Parameter style: The style of the alert controller (`.alert` or `.actionSheet`).
    private func applyConfiguration(for style: TSAlertController.Style) {
        switch style {
        case .alert:
            configuration.enteringTransition = .fadeInAndScaleDown
            configuration.exitingTransition = .fadeOut
            configuration.prefersGrabberVisible = false
            
        case .actionSheet:
            configuration.enteringTransition = .slideUp
            configuration.exitingTransition = .slideDown
            configuration.prefersGrabberVisible = true
        }
    }
    
    /// Configures the `ViewConfiguration` properties based on the specified `TSAlertController.Style`.
    /// This method defines the layout size and keyboard spacing for the alert controller.
    ///
    /// - Parameter style: The style of the alert controller (`.alert` or `.actionSheet`).
    private func applyViewConfiguration(for style: TSAlertController.Style) {
        switch style {
        case .alert:
            viewConfiguration.size.width = .proportional(minimumRatio: 0.1, maximumRatio: 0.8)
            viewConfiguration.spacing.keyboardSpacing = 100
            
        case .actionSheet:
            viewConfiguration.size.width = .proportional(minimumRatio: 0.95, maximumRatio: 0.95)
            viewConfiguration.spacing.keyboardSpacing = 20
        }
    }
    
    /// Before the alert is displayed on the screen, this method forcibly updates the final `Configuration`
    /// based on `TSAlertController.Style`.
    /// This ensures that the alert is presented correctly and prevents unintended behavior.
    private func adjustConfiguration() {
        adjustActionOrder(&actions)
        adjustPrefersGrabberVisible(&configuration)
    }
    
    /// Before the alert is displayed on the screen, this method forcibly updates the final `ViewConfiguration`
    /// based on `TSAlertController.Style`.
    /// This ensures that the alert is presented correctly and prevents unintended behavior.
    private func adjustViewConfiguration() {
        adjustButtonGroupAxis(&viewConfiguration.buttonGroupAxis)
    }
    
    /// If `buttonLayoutAxis` is set to `.automatic`, the axis is adjusted based on the number of buttons.
    /// - Parameter axis: The current button layout axis.
    private func adjustButtonGroupAxis(_ axis: inout TSAlertController.ViewConfiguration.ButtonGroupAxis) {
        axis = axis.resolvedAxis(for: actions.count)
    }
    
    private func adjustPrefersGrabberVisible(_ config: inout TSAlertController.Configuration) {
        if preferredStyle == .alert {
            config.prefersGrabberVisible = false
        }
    }
    
    /// Adjusts the order of actions, ensuring that the cancel action appears either at the beginning or end.
    /// - Parameter actions: The list of `TSAlertAction` instances to be reordered.
    ///
    /// - TODO: Modify sorting logic based on `UITraitCollectionLayoutDirection` to handle right-to-left layouts properly.
    private func adjustActionOrder(_ actions: inout [TSAlertAction]) {
        actions.sort {
            let isHorizontal = viewConfiguration.buttonGroupAxis == .horizontal
            return isHorizontal ? ($0.style == .cancel && $1.style != .cancel)
            : ($0.style != .cancel && $1.style == .cancel)
        }
    }
    
    ///
    private func initializeAlertView() {
        setupAlertView()
        setupConstraints()
        setupAttributes()
    }
    
    ///
    private func setupAlertView() {
        let buttons = actions.compactMap { $0.instantiateButton(for: preferredStyle) }
        let contentView = customView ?? DefaultContentView(title, message, textfields, viewConfiguration)
        let buttonGroupView = DefaultButtonGroupView(buttons, viewConfiguration)
        
        alertView = DefaultAlertView(self, contentView, buttonGroupView, viewConfiguration, configuration)

        view.addSubview(alertView!)
    }

    ///
    private func setupConstraints() {
        view.applySizeConstraint(with: viewConfiguration.size)
        alertView?.fill(to: view)
    }

    ///
    private func setupAttributes() {
        switch viewConfiguration.backgroundColor {
        case let .color(color, alpha):
            view.backgroundColor = color.withAlphaComponent(alpha)
        case let .blur(style):
            view.addBlurEffect(style, with: viewConfiguration)
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

    ///
    private func registerKeyboardNotifications() {
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
    private func unregisterKeyboardNotifications() {
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
        
        addGestureRecognizerIfNeeded(for: .dismissOnSwipeDown,
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
    
    
    // MARK: - Present
    
    ///
    public func present(animated: Bool,
                        after time: TimeInterval = 0,
                        haptic type: UINotificationFeedbackGenerator.FeedbackType,
                        completion: (() -> Void)? = nil) {
        
        UINotificationFeedbackGenerator().notificationOccurred(type)
        present(animated: animated, after: time, completion: completion)
    }
    
    ///
    public func present(animated: Bool,
                        after time: TimeInterval = 0,
                        completion: (() -> Void)? = nil) {
        
        Helper.topController()?.present(self, animated: animated, completion: completion)
    }
    
    
    // MARK: - Dismiss
    
    ///
    public func dismiss(aniamted: Bool = true,
                        completion: (() -> Void)? = nil) {
        
        Helper.topController()?.dismiss(animated: aniamted, completion: completion)
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

    ///
    private func activateFirstResponderIfNeeded() {
        if let textField = textfields.first, textField.canBecomeFirstResponder {
            textField.becomeFirstResponder()
        }
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
}


// MARK: - Gesture

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
        let scaleDownFactor: CGFloat = 0.95
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
                        .scaledBy(x: scaleDownFactor, y: scaleDownFactor)
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
                               options: .curveEaseIn,
                               animations: {
                    
                    self.view.alpha = 0
                    self.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                    self.view.frame.origin.y = presentingView.frame.maxY + 100
                    self.background.alpha = 0.0
                }, completion: { finished in
                    if finished { self.dismiss(aniamted: false) }
                })
            //
            } else {
                UIView.animate(withDuration: 0.5,
                               delay: 0,
                               usingSpringWithDamping: 0.6,
                               initialSpringVelocity: 1.0,
                               options: .curveEaseIn,
                               animations: {
                    
                    self.view.transform = .identity
                })
            }
            
        default:
            break
        }
    }
    
    @objc private func handleTapDragSpringGesture(_ gesture: UIPanGestureRecognizer) {
        
        //
        let scaleDownFactor: CGFloat = 0.95
        let interpolationFactor: CGFloat = 0.1
        let translation = gesture.translation(in: self.view)
        
        switch gesture.state {
        case .began:
            //
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 1.0,
                           options: .curveEaseIn,
                           animations: {
                
                self.view.transform = CGAffineTransform(scaleX: scaleDownFactor, y: scaleDownFactor)
            })
            
        case .changed:
                self.view.transform = CGAffineTransform(translationX: translation.x * interpolationFactor,
                                                        y: translation.y * interpolationFactor).scaledBy(x: scaleDownFactor, y: scaleDownFactor)
            
        case .ended, .cancelled, .failed:
            //
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 1.0,
                           options: .curveEaseIn,
                           animations: {
                
                self.view.transform = .identity
            })
            
        default:
            break
        }
    }
}


// MARK: - Keyboard

private extension TSAlertController {
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let keyboardAnimationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else {
            return
        }

        self.initialViewTopY = view.frame.origin.y

        let viewHeight = view.frame.height
        let keyboardTopY = keyboardFrame.origin.y

        let duration = keyboardAnimationDuration.doubleValue
        let adjustedViewTopY = keyboardTopY - viewConfiguration.spacing.keyboardSpacing - viewHeight
        
        // Move the alert up only if the spacing is smaller than the configured value.
        // If the space between the alert and the keyboard is greater than the configured value, the alert will not move.
        if adjustedViewTopY < initialViewTopY {
            animate(to: adjustedViewTopY, duration: duration)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
              let keyboardAnimationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else {
            return
        }
        let duration = keyboardAnimationDuration.doubleValue
        
        // To test it properly, switch to software keyboard mode (Command + K) before displaying the alert.
        animate(to: initialViewTopY, duration: duration)
    }
    
    func animate(to yConstant: CGFloat, duration: TimeInterval) {
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
        
        return TSAlertPresentationController(presented: presented,
                                             presenting: presenting,
                                             background: background,
                                             preferredStyle: preferredStyle,
                                             configuration: viewConfiguration)
    }
    
    public func animationController(forPresented presented: UIViewController,
                                    presenting resenting: UIViewController,
                                    source: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        
        return configuration.enteringTransition?.resolvedAnimator
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        
        return configuration.exitingTransition?.resolvedAnimator
    }
}


// MARK: - UIGestureRecognizerDelegate

extension TSAlertController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
}
