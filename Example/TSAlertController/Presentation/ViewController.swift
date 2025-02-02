//
//  ViewController.swift
//  TSAlertController
//
//  Created by rlarjsdn3 on 01/13/2025.
//  Copyright (c) 2025 rlarjsdn3. All rights reserved.
//

import UIKit

import TSAlertController

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func test(_ sender: Any) {
        // TSAlertController Initialization
        let alert = TSAlertController(
            title: "Delete?",
            message: "To delete this item, enter the verification code. You can find the code in the OTP.",
            options: [.interactiveScaleAndDrag, .dismissOnSwipeDown, .dismissOnTapOutside],
            preferredStyle: .alert
        )
//        alert.configuration.buttonLayoutAxis = .vertical
        alert.transitionStyle = .slideUp
        
        // Add button actions
        let okAction = TSAlertAction(title: "Continue",
                                     style: .default()) { _ in
        }
        alert.addAction(okAction)
        
        let cancelAction = TSAlertAction(title: "Exit",
                                         style: .cancel()) { _ in
        }
        alert.addAction(cancelAction)
        
        // Add textfield
        alert.addTextField {
            $0.placeholder = "Verification Code"
        }
        
        // Present alert
        present(alert, animated: true)
    }
}
