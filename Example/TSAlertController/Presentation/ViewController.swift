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
    
    @IBOutlet weak var alertStack: UIStackView!
    
    @IBOutlet weak var actionSheetStack: UIStackView!
    
    
    // MARK: - Alert ① - Basic Usage
    
    @IBAction func showBasicAlert(_ sender: Any) {
        
        let alert = TSAlertController(title: "Current Location Not Available",
                                      message: "Your current location can't be determined at this time.",
                                      preferredStyle: .alert)
        
        let okAction = TSAlertAction(title: "OK", style: .default)
        okAction.configuration.backgroundColor = .systemBlue
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    

    // MARK: - Alert ② - with TextFields
    
    @IBAction func showAlertWithTextfields(_ sender: Any) {
        
        let alert = TSAlertController(title: "Sign In",
                                      message: "Please enter your username and password to access your account.",
                                      options: [.dismissOnTapOutside],
                                      preferredStyle: .alert)
        
        let okAction = TSAlertAction(title: "Sign In", style: .default) { _ in
            print("Sign In")
        }
        alert.addAction(okAction)
        alert.preferredAction = okAction
        
        let cancelAction = TSAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        cancelAction.configuration.backgroundColor = .systemBlue
        alert.addAction(cancelAction)
        
        alert.addTextField { textfield in
            textfield.placeholder = "Username"
            textfield.returnKeyType = .next
        }
        alert.addTextField { textfield in
            textfield.placeholder = "Password"
            textfield.isSecureTextEntry = true
            textfield.returnKeyType = .done
        }
        
        present(alert, animated: true)
    }
    
    
    // MARK: - ActionSheet ① - Basic Usage
    
    @IBAction func showBasicActionSheet(_ sender: Any) {
        
        let marketCap = MarketCapView()
        let actionSheet = TSAlertController(marketCap,
                                            options: [.dismissOnSwipeDown, .interactiveScaleAndDrag],
                                            preferredStyle: .actionSheet)
        
        let okAction = TSAlertAction(title: "Confirm")
        okAction.configuration.backgroundColor = .systemBlue
        actionSheet.addAction(okAction)
        
        present(actionSheet, animated: true)
    }
    

    // MARK: - ActionSheet ② - with Various Appearances
    
    @IBAction func showActionSheetWithVariousAppearance(_ sender: Any) {
        
        let actionSheet = TSAlertController(title: "What kind of inquiry do you have?",
                                            options: [.interactiveScaleAndDrag],
                                            preferredStyle: .actionSheet)
        actionSheet.viewConfiguration.margin = .init(buttonLeft: 5, buttonRight: 5)
        
        let config = TSButton.Configuration(imageSpacing: 15,
                                            preferredSymbolConfigurationForImage: .init(paletteColors: [.label]),
                                            accessoryImage: UIImage(systemName: "chevron.right"),
                                            preferredSymbolConfigurationForAccessoryImage: .init(paletteColors: [.label]),
                                            contentAlignment: .left,
                                            backgroundColor: .clear)
        
        let appUsageInquiry = TSAlertAction(title: "App Usage Inquiry")
        appUsageInquiry.configuration = config
        appUsageInquiry.configuration.image = UIImage(systemName: "app")
        appUsageInquiry.highlightType = .tintAndScaleDown(color: .systemGray4)
        actionSheet.addAction(appUsageInquiry)
        
        let paymentIssue = TSAlertAction(title: "Payment Issues")
        paymentIssue.configuration = config
        paymentIssue.configuration.imageSpacing = 10
        paymentIssue.configuration.image = UIImage(systemName: "creditcard.fill")
        paymentIssue.highlightType = .tintAndScaleDown(color: .systemGray4)
        actionSheet.addAction(paymentIssue)
        
        let accountSupport = TSAlertAction(title: "Account & Login Issues")
        accountSupport.configuration = config
        accountSupport.configuration.image = UIImage(systemName: "person.crop.circle")
        accountSupport.highlightType = .tintAndScaleDown(color: .systemGray4)
        actionSheet.addAction(accountSupport)
        
        let bugReport = TSAlertAction(title: "Bug Report")
        bugReport.configuration = config
        bugReport.configuration.image = UIImage(systemName: "ladybug")
        bugReport.highlightType = .tintAndScaleDown(color: .systemGray4)
        actionSheet.addAction(bugReport)
        
        present(actionSheet, animated: true)
    }
    
    
    
    
    @IBAction func button(_ sender: Any) {
        
        let alert = TSAlertController(title: "Save it for later?", message: "Your current progress will not be saved.", preferredStyle: .alert)
        alert.viewConfiguration.buttonGroupAxis = .vertical

        let closeAction = TSAlertAction(title: "Close")
        closeAction.configuration.titleAttributes = [.font: UIFont.systemFont(ofSize: 16)]
        closeAction.configuration.backgroundColor = .systemGray2
        alert.addAction(closeAction)

        let dismissAction = TSAlertAction(title: "Exit")
        dismissAction.configuration.titleAttributes = [.font: UIFont.systemFont(ofSize: 16)]
        dismissAction.configuration.backgroundColor = .systemRed
        alert.addAction(dismissAction)

        present(alert, animated: true)
    }
    
    
    
}






// MARK: - Lifecycle

extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        alertStack.isHidden = true
        actionSheetStack.isHidden = true
    }
}
