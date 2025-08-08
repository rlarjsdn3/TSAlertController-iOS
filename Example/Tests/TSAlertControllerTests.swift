import XCTest
@testable import TSAlertController

final class TSAlertControllerTests: XCTestCase {
    
    // MARK: - Verifies that TSAlertController initializes with correct title, message, and preferredStyle
    
    func testTSAlertController_WhenInitialized_ShouldSetTitleMessageAndPreferredStyle() {
        // given
        let alertController = TSAlertController(
            title: "The title of the alert",
            message: "Descriptive text that provides more details about the reason for the alert.",
            preferredStyle: .alert
        )
        let mockViewController = MockViewController()
        
        // when
        mockViewController.present(alertController, animated: true)
        
        // then
        XCTAssertEqual(alertController.title, "The title of the alert")
        XCTAssertEqual(alertController.message, "Descriptive text that provides more details about the reason for the alert.")
        XCTAssertEqual(alertController.preferredStyle, .alert)
        XCTAssertEqual(mockViewController.presentViewControllerTarget, alertController)
    }
    
    
    // MARK: - Verifies that TSAlertController initializes with correct textfields
    
    func testTSAlertController_WhenIntializedWithTextFields_ShouldSetTextFields() {
        // given
        let alertController = TSAlertController(
            title: "The title of the alert",
            preferredStyle: .alert
        )
        let mockViewController = MockViewController()
        
        alertController.addTextField()
        alertController.addTextField()
        
        // when
        mockViewController.present(alertController, animated: true)
        
        // then
        XCTAssertEqual(alertController.textFields?.count, 2)
        XCTAssertEqual(mockViewController.presentViewControllerTarget, alertController)
    }
    
    
    
    // MARK: - Verifies that TSAlertController initializes with the correct actions order and count
    
    func testTSAlertController_WhenInitializedWithTwoButtonsAndAutomaticAxis_ShouldSetCorrectActionsOrderAndCount() {
        // given
        let alertController = TSAlertController(
            title: "The title of the alert",
            preferredStyle: .alert
        )
        let mockViewController = MockViewController()
        
        let ok = TSAlertAction(title: "OK", style: .default)
        let cancel = TSAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(ok)
        alertController.addAction(cancel)
        
        // when
        mockViewController.present(alertController, animated: true)
        
        // then
        let actions = alertController.actions
        XCTAssertEqual(actions.count, 2)
        XCTAssertEqual(actions[0], cancel) // In LTR, the Cancel button is positioned at the far right.
        XCTAssertEqual(alertController.viewConfiguration.buttonGroupAxis, .horizontal)
        XCTAssertEqual(mockViewController.presentViewControllerTarget, alertController)
    }
    
    func testTSAlertController_WhenIntializedWithFourButtonsAndAutomaticAxis_ShouldSetCorrectActionsOrderAndCount() {
        // given
        let alertController = TSAlertController(
            title: "The title of the alert",
            preferredStyle: .alert
        )
        let mockViewController = MockViewController()
        
        let home = TSAlertAction(title: "Go to Home", style: .default)
        let profile = TSAlertAction(title: "Go to Profile", style: .default)
        let settings = TSAlertAction(title: "Go to Settings", style: .default)
        let cancel = TSAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(home)
        alertController.addAction(profile)
        alertController.addAction(cancel)
        alertController.addAction(settings)
        
        // when
        mockViewController.present(alertController, animated: true)
        
        // then
        let actions = alertController.actions
        XCTAssertEqual(actions.count, 4)
        XCTAssertEqual(actions[3], cancel) // If the button axis is vertical, the Cancel button is positioned at the very bottom.
        XCTAssertEqual(actions, [home, profile, settings, cancel])
        XCTAssertEqual(alertController.viewConfiguration.buttonGroupAxis, .vertical)
        XCTAssertEqual(mockViewController.presentViewControllerTarget, alertController)
    }
    
    
    
    
    
    func testTSAlertController_WhenIntlaizedWithAlertStyle_ShouldSetDefaultConfiguration() {
        // given
        let alertController = TSAlertController(
            title: "The title of the alert",
            preferredStyle: .alert
        )
        let mockViewController = MockViewController()
        
        // when
        mockViewController.present(alertController, animated: true)
        
        // then
        let config = alertController.configuration
        XCTAssertEqual(config.enteringTransition, .fadeInAndScaleDown)
        XCTAssertEqual(config.exitingTransition, .fadeOut)
        XCTAssertEqual(config.headerAnimation, .none)
        XCTAssertEqual(config.buttonGroupAnimation, .none)
        XCTAssertEqual(config.prefersGrabberVisible, false)
        XCTAssertEqual(mockViewController.presentViewControllerTarget, alertController)
    }
    
    func testTSAlertController_WhenIntializedWithAlertStyle_ShouldSetDefaultViewConfiguration() {
        // given
        let alertController = TSAlertController(
            title: "The title of the alert",
            preferredStyle: .alert
        )
        let mockViewController = MockViewController()
        
        // when
        mockViewController.present(alertController, animated: true)
        
        // then
        let viewConfig = alertController.viewConfiguration
        XCTAssertEqual(viewConfig.size.width, .proportional(minimumRatio: 0.75, maximumRatio: 0.75))
        XCTAssertEqual(viewConfig.spacing.keyboardSpacing, 100)
        XCTAssertEqual(mockViewController.presentViewControllerTarget, alertController)
    }
    
    func testTSAlertController_WhenIntializedWithAlertStyle_SouldSetCorrectConfigurationForcibly() {
        // given
        let alertController = TSAlertController(
            title: "The title of the alert",
            preferredStyle: .alert
        )
        let mockViewController = MockViewController()
        
        // when
        alertController.configuration.prefersGrabberVisible = true
        mockViewController.present(alertController, animated: true)
        
        // then
        let config = alertController.configuration
        XCTAssertEqual(config.prefersGrabberVisible, false)
        XCTAssertEqual(mockViewController.presentViewControllerTarget, alertController)
    }
    
    func testTSAlertController_WhenIntializedWithFloatingSheetStyle_ShouldSetDefaultConfiguration() {
        // given
        let alertController = TSAlertController(
            title: "The title of the alert",
            preferredStyle: .floatingSheet
        )
        let mockViewController = MockViewController()
        
        // when
        mockViewController.present(alertController, animated: true)
        
        // then
        let config = alertController.configuration
        XCTAssertEqual(config.enteringTransition, .slideUp)
        XCTAssertEqual(config.exitingTransition, .slideDown)
        XCTAssertEqual(config.headerAnimation, .none)
        XCTAssertEqual(config.buttonGroupAnimation, .none)
        XCTAssertEqual(config.prefersGrabberVisible, true)
        XCTAssertEqual(mockViewController.presentViewControllerTarget, alertController)
    }
    
    func testTSAlertController_WhenInitializedWithFloatingSheetStyle_ShouldSetDefaultViewConfiguration() {
        // given
        let alertController = TSAlertController(
            title: "The title of the alert",
            preferredStyle: .floatingSheet
        )
        let mockViewController = MockViewController()
        
        // when
        mockViewController.present(alertController, animated: true)
        
        // then
        let viewConfig = alertController.viewConfiguration
        XCTAssertEqual(viewConfig.size.width, .proportional(minimumRatio: 0.95, maximumRatio: 0.95))
        XCTAssertEqual(viewConfig.spacing.keyboardSpacing, 20)
        XCTAssertEqual(mockViewController.presentViewControllerTarget, alertController)
    }
    
    func testTSAlertController_WhenIntilizedWithFloatingSheetStyle_ShouldSetCorrectConfigurationForcibly() {
        // given
        let alertController = TSAlertController(
            title: "The title of the alert",
            preferredStyle: .floatingSheet
        )
        let mockViewController = MockViewController()
        
        // when
        mockViewController.present(alertController, animated: true)
        
        // then
        let config = alertController.configuration
        XCTAssertFalse(alertController.options.contains(.stretchyDragging))
        XCTAssertEqual(mockViewController.presentViewControllerTarget, alertController)
        XCTAssertEqual(mockViewController.presentViewControllerTarget, alertController)
    }
    
    func testTSAlertController_WhenIntializedWithActionSheetStyle_ShouldSetDefaultConfiguration() {
        // given
        let alertController = TSAlertController(
            title: "The title of the alert",
            preferredStyle: .actionSheet
        )
        let mockViewController = MockViewController()
        
        // when
        mockViewController.present(alertController, animated: true)
        
        // then
        let config = alertController.configuration
        XCTAssertEqual(config.enteringTransition, .slideUp)
        XCTAssertEqual(config.exitingTransition, .slideDown)
        XCTAssertEqual(config.headerAnimation, .none)
        XCTAssertEqual(config.buttonGroupAnimation, .none)
        XCTAssertEqual(config.prefersGrabberVisible, true)
        XCTAssertEqual(mockViewController.presentViewControllerTarget, alertController)
    }
    
    func testTSAlertController_WhenIntializedWithActionSheetStyle_ShouldSetDefaultViewConfiguration() {
        // given
        let alertController = TSAlertController(
            title: "The title of the alert",
            preferredStyle: .actionSheet
        )
        let mockViewController = MockViewController()
        
        // when
        mockViewController.present(alertController, animated: true)
        
        // then
        let viewConfig = alertController.viewConfiguration
        XCTAssertEqual(viewConfig.size.width, .proportional(minimumRatio: 1.0, maximumRatio: 1.0))
        XCTAssertEqual(viewConfig.spacing.keyboardSpacing, 0.0)
        XCTAssertEqual(mockViewController.presentViewControllerTarget, alertController)
    }
    
    func testTSAlertController_WhenIntializedWithActionSheetStyle_ShouldSetCorrectConfigurationForcibly() {
        // given
        let alertController = TSAlertController(
            title: "The title of the alert",
            preferredStyle: .floatingSheet
        )
        let mockViewController = MockViewController()
        
        // when
        mockViewController.present(alertController, animated: true)
        
        // then
        let config = alertController.configuration
        XCTAssertFalse(alertController.options.contains(.interactiveScaleAndDrag))
        XCTAssertEqual(mockViewController.presentViewControllerTarget, alertController)
    }
    
    func testTSAlertController_WhenIntializedWithActionSheetStyle_ShouldSetCorrectViewConfigurationForcibly() {
        // given
        let alertController = TSAlertController(
            title: "The title of the alert",
            preferredStyle: .actionSheet
        )
        let mockViewController = MockViewController()
        
        // when
        alertController.viewConfiguration.cornerRadius = 25.0
        
        mockViewController.present(alertController, animated: true)
        
        // then
        let viewConfig = alertController.viewConfiguration
        XCTAssertEqual(viewConfig.cornerRadius.bottomLeft, 0.0)
        XCTAssertEqual(viewConfig.cornerRadius.bottomRight, 0.0)
        XCTAssertEqual(mockViewController.presentViewControllerTarget, alertController)
    }
    
}
