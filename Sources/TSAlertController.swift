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
    
    /// The title of the alert.
    ///
    /// The title string is displayed prominently in the alert or action sheet.
    /// You should use this string to get the user’s attention and communicate the reason for displaying the alert.
    /// If you want to change the font attributes such as size or color, use the `titleAttributes` property
    /// in `TSAlertController.ViewConfiguration`.
    public override var title: String? {
        get { return _title }
        set { _title = newValue }
    }

    private var _title: String?

    /// Descriptive text that provides more details about the reason for the alert.
    ///
    /// The message string is displayed below the title string and is less prominent.
    /// Use this string to provide additional context about the reason for the alert or
    /// about the actions that the user might take.
    /// If you want to change the font attributes such as size or color, use the `messageAttributes` property
    /// in `TSAlertController.ViewConfiguration`.
    public var message: String?

    /// Options that determine how the alert responds to user interactions.
    public var options: TSAlertController.Options = []

    /// The style of the alert controller.
    ///
    /// The value of this property is set to the value you specified in the `init(title:message:preferredStyle:)` method.
    /// This value determines how the alert is displayed on the screen.
    public var preferredStyle: TSAlertController.Style = .alert

    /// The actions that the user can take in response to the alert or action sheet.
    ///
    /// The actions are in the order in which you added them to the alert controller.
    /// This order also corresponds to the order in which they are displayed in the alert or action sheet.
    public var actions: [TSAlertAction] = []

    /// The preferred action for the user to take from an alert.
    ///
    /// The preferred action is relevant for the `TSAlertController.Style.alert` style only;
    /// it is not used by action sheets. When you specify a preferred action,
    /// pressing the Return key in the last text field of an alert with a text field
    /// triggers the preferred action and dismisses the alert.
    public var preferredAction: TSAlertAction?

    /// The array of text fields displayed by the alert.
    ///
    /// Use this property to access the text fields displayed in the alert.
    /// The text fields are in the order in which you added them to the alert controller.
    /// This order also corresponds to the order in which they are displayed in the alert.
    public var textFields: [UITextField]? = []

    /// The configuration that defines the behavior of the alert controller.
    public lazy var configuration: TSAlertController.Configuration = .init()

    /// A configuration that specifies the behavior of the alert and action sheet.
    ///
    /// You can configure the behavior of the alert with a `TSAlertController.ViewConfiguration`.
    /// It allows you to define transition styles when the alert appears and disappears,
    /// as well as animations for the alert header and button group views.
    public lazy var viewConfiguration: TSAlertController.ViewConfiguration = .init()

    /// The header view of the alert.
    private var headerView: UIView?

    /// The main view of the alert.
    ///
    /// The main view consists of a header view and a button group view.
    private var alertView: (any TSAlertView)?

    /// The background view that appears behind the alert.
    ///
    /// The background view is controlled by `TSAlertPresentationController`.
    private var background = UIView()

    /// The initial Y position of the top-left corner of the alert.
    private var initialViewTopY: CGFloat = 0

    /// The Y position of the top-left corner of the alert when the keyboard appears.
    private var keyboardShiftTopY: CGFloat = 0
    
    
    // MARK: - Initializer
    
    /// Initializes a new alert controller with a custom header view.
    ///
    /// Use this initializer to create an alert with a custom header view.
    /// - Parameters:
    ///   - headerView: A `UIView` that serves as the custom header of the alert.
    ///   - options: Options that define the behavior of the alert. Defaults to an empty set.
    ///   - style: The preferred style of the alert, determining whether it is an alert or an action sheet.
    public init(_ headerView: UIView,
                options: TSAlertController.Options = [],
                preferredStyle style: TSAlertController.Style) {
        
        self.headerView = headerView
        self.options = options
        self.preferredStyle = style
        super.init(nibName: nil, bundle: nil)
        
        commonInit()
    }

    /// Initializes a new alert controller with a title and message.
    ///
    /// Use this initializer to create an alert with a title and an optional message.
    /// - Parameters:
    ///   - title: The title of the alert, displayed prominently at the top.
    ///   - message: The message providing additional context for the alert. Defaults to `nil`.
    ///   - options: Options that define the behavior of the alert. Defaults to an empty set.
    ///   - style: The preferred style of the alert, determining whether it is an alert or an action sheet.
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
        
        initialViewTopY = view.frame.origin.y
        alertView?.animateView(for: self)

        activateFirstResponderIfNeeded()
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
            viewConfiguration.size.width = .proportional(minimumRatio: 0.75, maximumRatio: 0.75)
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
        adjustPrefersGrabberVisible()
    }
    
    /// Before the alert is displayed on the screen, this method forcibly updates the final `ViewConfiguration`
    /// based on `TSAlertController.Style`.
    /// This ensures that the alert is presented correctly and prevents unintended behavior.
    private func adjustViewConfiguration() {
        adjustButtonGroupAxis()
        adjustActionOrder()
    }
    
    //
    private func adjustPrefersGrabberVisible() {
        if preferredStyle == .alert {
            configuration.prefersGrabberVisible = false
        }
    }

    /// If `buttonLayoutAxis` is set to `.automatic`, the axis is adjusted based on the number of buttons.
    /// - Parameter axis: The current button layout axis.
    private func adjustButtonGroupAxis() {
        let axis = viewConfiguration.buttonGroupAxis
        viewConfiguration.buttonGroupAxis = axis.resolvedAxis(for: actions.count)
    }
    
    /// Adjusts the order of actions, ensuring that the cancel action appears either at the beginning or end.
    /// - Parameter actions: The list of `TSAlertAction` instances to be reordered.
    ///
    /// - TODO: Modify sorting logic based on `UITraitCollectionLayoutDirection` to handle right-to-left layouts properly.
    private func adjustActionOrder() {
        actions.sort {
            let isHorizontal = viewConfiguration.buttonGroupAxis == .horizontal
            return isHorizontal ? ($0.style == .cancel && $1.style != .cancel)
            : ($0.style != .cancel && $1.style == .cancel)
        }
    }
    
    private func initializeAlertView() {
        setupAlertView()
        setupConstraints()
        setupAttributes()
    }
    
    // Configures and adds the alert view to the main view.
    private func setupAlertView() {
        let buttonGroup = actions.compactMap {
            $0.instantiateButton(for: preferredStyle)
        }
        let contentView = headerView ?? DefaultContentView(title: title,
                                                           message: message,
                                                           textFields: textFields,
                                                           viewConfiguration: viewConfiguration,
                                                           configuration: configuration)
        let buttonGroupView = DefaultButtonGroupView(buttonGroup: buttonGroup,
                                                     viewConfiguration: viewConfiguration,
                                                     configuration: configuration)
        
        alertView = DefaultAlertView(self,
                                     contentView: contentView,
                                     buttonGroupView: buttonGroupView,
                                     viewConfiguration: viewConfiguration,
                                     configuration: configuration)
        view.addSubview(alertView!)
    }

    // Applies size constraints and positions the alert view within its parent view.
    private func setupConstraints() {
        view.applySizeConstraint(with: viewConfiguration.size)
        alertView?.fill(to: view)
    }

    // Sets up visual attributes such as background color, blur effect, border, and shadow.
    private func setupAttributes() {
        switch viewConfiguration.backgroundColor {
        case let .color(color, alpha):
            view.backgroundColor = color.withAlphaComponent(alpha)
        case let .blur(style):
            view.addBlurEffect(style, with: viewConfiguration)
        case let .grdient(colors, startPoint, endPoint, locations):
            view.addGradientView(colors: colors,
                                  startPoint: startPoint,
                                  endPoint: endPoint,
                                 locations: locations, with: viewConfiguration)
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

    // Registers notifications to handle keyboard appearance and disappearance.
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

    // Registers notifications to handle keyboard appearance and disappearance.
    private func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    // Adds gesture recognizers to handle user interactions for dismissing or moving the alert.
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
    
    /// Presents the alert with optional haptic feedback.
    ///
    /// This method presents the alert after a specified delay and provides haptic feedback
    /// before displaying the alert. The haptic feedback is generated using `UINotificationFeedbackGenerator`.
    /// If a delay is specified, the alert is presented after the given time interval.
    ///
    /// - Parameters:
    ///   - animated: A Boolean value indicating whether the presentation should be animated.
    ///   - time: The delay, in seconds, before presenting the alert. Defaults to `0`.
    ///   - type: The type of haptic feedback to trigger before presenting the alert.
    ///   - completion: A closure executed after the alert is presented.
    public func present(animated: Bool,
                        after time: TimeInterval = 0,
                        haptic type: UINotificationFeedbackGenerator.FeedbackType,
                        completion: (() -> Void)? = nil) {
        
        UINotificationFeedbackGenerator().notificationOccurred(type)
        present(animated: animated, after: time, completion: completion)
    }
    
    /// Presents the alert after an optional delay.
    ///
    /// This method presents the alert after a specified delay.
    /// If a delay is specified, the alert is presented after the given time interval.
    ///
    /// - Parameters:
    ///   - animated: A Boolean value indicating whether the presentation should be animated.
    ///   - time: The delay, in seconds, before presenting the alert. Defaults to `0`.
    ///   - completion: A closure executed after the alert is presented.
    public func present(animated: Bool,
                        after time: TimeInterval = 0,
                        completion: (() -> Void)? = nil) {
        
        Helper.topController()?.present(self, animated: animated, completion: completion)
    }
    
    
    // MARK: - Dismiss
    
    /// Dismisses the alert with an optional completion handler.
    ///
    /// This method dismisses the alert from topmost view controller.
    /// If animation is enabled, the alert is dismissed with an animated transition.
    ///
    /// - Parameters:
    ///   - animated: A Boolean value indicating whether the dismissal should be animated. Defaults to `true`.
    ///   - completion: A closure executed after the alert is dismissed.
    public func dismiss(aniamted: Bool = true,
                        completion: (() -> Void)? = nil) {
        
        Helper.topController()?.dismiss(animated: aniamted, completion: completion)
    }
}


// MARK: - Extensions

public extension TSAlertController {

    /// Adds an action to the alert controller.
    ///
    /// The action is appended to the `actions` array and displayed in the order it was added.
    ///
    /// - Parameter action: The `TSAlertAction` to be added to the alert.
    func addAction(_ action: TSAlertAction) {
        actions.append(action)
    }
    
    /// Adds a text field to the alert.
    ///
    /// This method creates a new `UITextField` to the alert, applies the provided configuration handler.
    ///
    /// - Important: The text field’s `borderStyle` is always set to `.none` to maintain a consistent alert design.
    /// Do **not** manually set a delegate for the text field, as the alert controller manages it internally.
    ///
    /// - Parameter configurationHandler: A closure that allows further customization of the text field.
    func addTextField(configurationHandler: ((UITextField) -> Void)? = nil) {
        let textField = UITextField()
        configurationHandler?(textField)
        textField.borderStyle = .none  // Ensuring no border style
        textField.delegate = self      // Delegate must not be manually modified
        textFields?.append(textField)
    }
}

private extension TSAlertController {

    // Activates the first text field as the first responder if available.
    private func activateFirstResponderIfNeeded() {
        if let textField = textFields?.first, textField.canBecomeFirstResponder {
            textField.becomeFirstResponder()
        }
    }
    
    // Adds a gesture recognizer to the target view if the specified option is enabled.
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
    
    // Dismisses the alert when tapped inside.
    @objc private func handleTapInsideToDismissGesture(_ gesture: UITapGestureRecognizer) {
        dismiss()
    }
    
    // Dismisses the alert when tapped outside.
    @objc private func handleTapOutsideToDismissGesture(_ gesture: UITapGestureRecognizer) {
        dismiss()
    }
    
    // Handles swipe-down gesture to dismiss the alert with animation.
    @objc private func handleSwipeToDismissGesture(_ gesture: UIPanGestureRecognizer) {
        
        guard let presentingView = self.presentingViewController?.view else { return }
        
        //
        let scaleDownFactor: CGFloat = 0.95
        let dismissThreshold: CGFloat = 100
        let velocityThreshold: CGFloat = 800
        
        let velocity = gesture.velocity(in: self.view)
        let translation = gesture.translation(in: self.view)

        switch gesture.state {
        case .changed:
            if translation.y > 0 {
                self.view.transform = CGAffineTransform(translationX: translation.x * 0.1, y: translation.y)
                
                if options.contains(.interactiveScaleAndDrag) {
                    self.view.transform = CGAffineTransform(translationX: translation.x * 0.1, y: translation.y)
                        .scaledBy(x: scaleDownFactor, y: scaleDownFactor)
                }
            }
            
        case .ended, .cancelled, .failed:
            let shouldDismiss = (translation.y > dismissThreshold) || (velocity.y > velocityThreshold)

            if shouldDismiss {
                UIView.animate(withDuration: 0.5,
                               delay: 0,
                               usingSpringWithDamping: 0.6,
                               initialSpringVelocity: 0.6,
                               options: .curveEaseIn,
                               animations: {
                    
                    self.view.alpha = 0
                    self.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                    self.view.frame.origin.y = presentingView.frame.maxY + 100
                    self.background.alpha = 0.0
                }, completion: { finished in
                    if finished { self.dismiss(aniamted: false) }
                })
            } else {
                UIView.animate(withDuration: 0.5,
                               delay: 0,
                               usingSpringWithDamping: 0.6,
                               initialSpringVelocity: 0.6,
                               options: .curveEaseIn,
                               animations: {
                    
                    self.view.transform = .identity
                })
            }
            
        default:
            break
        }
    }
    
    // Handles interactive scaling and dragging with a spring effect.
    @objc private func handleTapDragSpringGesture(_ gesture: UIPanGestureRecognizer) {
        
        let scaleDownFactor: CGFloat = 0.95
        let interpolationFactor: CGFloat = 0.1
        let translation = gesture.translation(in: self.view)
        
        switch gesture.state {
        case .began:
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0.6,
                           options: .curveEaseIn,
                           animations: {
                
                self.view.transform = CGAffineTransform(scaleX: scaleDownFactor, y: scaleDownFactor)
            })
            
        case .changed:
                self.view.transform = CGAffineTransform(translationX: translation.x * interpolationFactor,
                                                        y: translation.y * interpolationFactor).scaledBy(x: scaleDownFactor, y: scaleDownFactor)
            
        case .ended, .cancelled, .failed:
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0.6,
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
    
    // Adjusts the alert’s position when the keyboard appears.
    @objc func keyboardWillShow(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let keyboardAnimationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else {
            return
        }

        let viewHeight = view.frame.height
        let keyboardTopY = keyboardFrame.origin.y

        let duration = keyboardAnimationDuration.doubleValue
        let adjustedViewTopY = keyboardTopY - viewConfiguration.spacing.keyboardSpacing - viewHeight
        
        // Move the alert up only if the spacing is smaller than the configured value.
        // If the space between the alert and the keyboard is greater than the configured value, the alert will not move.
        if adjustedViewTopY < initialViewTopY {
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: .curveEaseIn) {
                self.view.frame.origin.y = adjustedViewTopY
            }
        }
    }
    
    // Resets the alert’s position when the keyboard disappears.
    @objc func keyboardWillHide(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
              let keyboardAnimationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else {
            return
        }
        let duration = keyboardAnimationDuration.doubleValue
        
        // Ensure the software keyboard is enabled for proper testing (Command + K).
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: .curveEaseIn) {
            self.view.frame.origin.y = self.initialViewTopY
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
                                             viewConfiguration: viewConfiguration,
                                             configuration: configuration)
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


// MARK: - UITextFieldDelegate

extension TSAlertController: UITextFieldDelegate {

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let index = textFields?.firstIndex(where: { $0 === textField }) else {
            return false
        }

        let nextIndex = index + 1
        if nextIndex < textFields!.count {
            textFields?[nextIndex].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            if let preferredAction = preferredAction {
                preferredAction.sendActions()
            }
        }
        return true
    }
}
