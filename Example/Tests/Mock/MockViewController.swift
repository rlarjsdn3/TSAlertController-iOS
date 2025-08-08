//
//  MockViewController.swift
//  TSAlertController
//
//  Created by 김건우 on 2/24/25.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit

final class MockViewController: UIViewController {
    var presentViewControllerTarget: UIViewController?
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        //
        viewControllerToPresent.loadViewIfNeeded()
        //
        viewControllerToPresent.beginAppearanceTransition(true, animated: flag)
        viewControllerToPresent.endAppearanceTransition()
        
        //
        presentViewControllerTarget = viewControllerToPresent
    }
}
