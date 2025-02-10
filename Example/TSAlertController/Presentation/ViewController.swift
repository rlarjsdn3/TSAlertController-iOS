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
    
    
    // MARK: - Alert ① - Basic Usage
    
    @IBAction func showBasicAlert(_ sender: Any) {
        
        //
        let alert = TSAlertController(title: "Current Location Not Available",
                                      message: "Your current location can't be determined at this time.",
                                      preferredStyle: .alert)
        
        //
        let okAction = TSAlertAction(title: "OK", style: .default)
        okAction.configuration.backgroundColor = .systemBlue
        alert.addAction(okAction)
        
        //
        present(alert, animated: true)
    }
    
    // MARK: - Alert ① - Basic Usage
    
    @IBAction func showAlertWithTextfields(_ sender: Any) {
        
        //
        let alert = TSAlertController(title: "Sign In",
                                      message: "Please enter your username and password to access your account.",
                                      options: [.dismissOnTapOutside],
                                      preferredStyle: .alert)
        //
        alert.viewConfiguration.backgroundBorderColor = UIColor.systemGray2.cgColor
        alert.viewConfiguration.backgroundBorderWidth = 1.5
        alert.viewConfiguration.backgroundColor = .blur(.systemChromeMaterial)
        
        //
        let okAction = TSAlertAction(title: "Sign In", style: .default) { _ in
            print("Sign In")
        }
        alert.addAction(okAction)
        alert.preferredAction = okAction
        
        //
        let cancelAction = TSAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        cancelAction.configuration.backgroundColor = .systemBlue
        alert.addAction(cancelAction)
        
        //
        alert.addTextField { textfield in
            textfield.placeholder = "Username"
        }
        alert.addTextField { textfield in
            textfield.placeholder = "Password"
        }
        
        present(alert, animated: true)
    }
    
    
    
    // MARK: - Show Basic ActionSheet
    
    @IBAction func showBasicActionSheet(_ sender: Any) {
        
        //
        let actionSheet = TSAlertController(
            title: "Share File",
            message: "Choose how you want to share this file.",
            options: [.interactiveScaleAndDrag],
            preferredStyle: .actionSheet
        )

        //
        let shareViaEmailAction = TSAlertAction(title: "Share via Email", style: .default) { _ in
            print("Email selected")
        }
        actionSheet.addAction(shareViaEmailAction)
        
        let shareViaMessagesAction = TSAlertAction(title: "Share via Messages", style: .default) { _ in
            print("Messages selected")
        }
        actionSheet.addAction(shareViaMessagesAction)
        
        let copyLinkAction = TSAlertAction(title: "Copy Link", style: .default) { _ in
            print("Link copied")
        }
        actionSheet.addAction(copyLinkAction)

        let cancelAction = TSAlertAction(title: "Cancel", style: .cancel)
        cancelAction.configuration.backgroundColor = .systemBlue
        actionSheet.addAction(cancelAction)

        //
        present(actionSheet, animated: true)
    }
    
    
    
    
    // MARK: - Show ActionSheet with Slide Animation
    
    @IBAction func showActionSheetWithSlideAnimation(_ sender: Any) {
        
        //
        let actionSheet = TSAlertController(
            title: "Change Profile Picture",
            message: "Select how you want to update your profile picture.",
            options: [.interactiveScaleAndDrag, .dismissOnSwipeDown],
            preferredStyle: .actionSheet
        )
        //
        actionSheet.configuration.headerAnimation = .fadeIn()
        actionSheet.configuration.buttonGroupAnimation = .slide()

        actionSheet.viewConfiguration.dimmedBackgroundViewColor = .blur(.systemChromeMaterialDark)
        
        //
        let cameraAction = TSAlertAction(title: "Take a Photo", style: .default) { _ in
            print("Open Camera")
        }
        cameraAction.configuration.image = UIImage(systemName: "camera.fill")
        cameraAction.configuration.accessoryImage = UIImage(systemName: "chevron.right")
        cameraAction.configuration.backgroundColor = .systemBlue
        cameraAction.configuration.preferredSymbolConfigurationForImage = .init(paletteColors: [.white])
        cameraAction.configuration.preferredSymbolConfigurationForAccessoryImage = .init(paletteColors: [.white])
        
        actionSheet.addAction(cameraAction)

        //
        let galleryAction = TSAlertAction(title: "Choose from Gallery", style: .default) { _ in
            print("Open Photo Library")
        }
        galleryAction.configuration.image = UIImage(systemName: "photo.on.rectangle.angled")
        galleryAction.configuration.accessoryImage = UIImage(systemName: "chevron.right")
        galleryAction.configuration.backgroundColor = .systemBlue
        galleryAction.configuration.preferredSymbolConfigurationForImage = .init(paletteColors: [.white])
        galleryAction.configuration.preferredSymbolConfigurationForAccessoryImage = .init(paletteColors: [.white])
        
        actionSheet.addAction(galleryAction)

        //
        let defaultImageAction = TSAlertAction(title: "Remove", style: .destructive) { _ in
            print("Reset to Default Image")
        }
        defaultImageAction.configuration.preferredSymbolConfigurationForImage = .init(paletteColors: [.white])
        actionSheet.addAction(defaultImageAction)
        
        //
        present(actionSheet, animated: true)
    }
}






// MARK: - Lifecycle

extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
    }
}
