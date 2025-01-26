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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func test(_ sender: Any) {
        // TSAlertController Initalization
        let alert = TSAlertController(
            title: "Hello, World!",
            message: "TSAlertController",
            preferredStyle: .alert
        )
        // ViewConfig Init & assign to it
        alert.viewConfiguration = TSAlertController.ViewConfiguration(backgroundColor: .color(.secondarySystemBackground, alpha: 0.5))

        // Add button actions
        let okAction = TSAlertAction(title: "Ok", style: .default) { [weak self] _ in
//            self?.dismiss(animated: true)
        }
        alert.addAction(okAction)
        let cancelAction = TSAlertAction(title: "Cancel", style: .cancel) { [weak self] _ in
//            self?.dismiss(animated: true)
        }
        alert.addAction(cancelAction)

        // Present Alert
        present(alert, animated: true)
    }
    
}

