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
            title: "Menu",
            message: "Select one of the file processing options below.",
            options: [.interactiveScaleAndDrag, .dismissOnSwipeDown, .dismissOnTapOutside],
            preferredStyle: .actionSheet
        )
        alert.viewConfiguration.margin.buttonLeft = 5
        alert.viewConfiguration.margin.buttonRight = 5
        alert.viewConfiguration.spacing.buttonSpacing = 2
        alert.viewConfiguration.buttonGroupAxis = .vertical
        alert.configuration.enteringTransition = .slideUp
        alert.configuration.exitingTransition = .slideDown
        alert.configuration.headerAnimation = .fade()
        alert.configuration.buttonGroupAnimation = .slide()
        alert.configuration.prefersGrabberVisible = true
        
        // SFSymbol Image
        let trash = UIImage(systemName: "trash.fill")
        let folder = UIImage(systemName: "arrow.up.and.down.and.arrow.left.and.right")
        
        // Configuration Intialization
        let configuration = TSButton.Configuration(titleAttributes: [.font: UIFont.boldSystemFont(ofSize: 17),
                                                                     .foregroundColor: UIColor.label],
                                                   titleAlignment: .left,
                                                   leftImageSpacing: 15,
                                                   preferredSymbolConfigurationForRightImage: UIImage.SymbolConfiguration(paletteColors: [.lightGray]),
                                                   contentEdgeInset: .init(top: 0, leading: 4, bottom: 0, trailing: 4),
                                                   backgroundColor: .clear)
        
        // Add button actions
        let desctructiveAction = TSAlertAction(title: "Move",
                                               style: .destructive) { _ in
        }
        desctructiveAction.configuration = configuration
        desctructiveAction.leftImage = trash
        desctructiveAction.highlightType = .dimAndScaleDown(color: .systemGray5)
        alert.addAction(desctructiveAction)
        
        let trashAction = TSAlertAction(title: "Trash",
                                        style: .default) { _ in
        }
        trashAction.leftImage = folder
        trashAction.configuration = configuration
        trashAction.highlightType = .dimAndScaleDown(color: .systemGray5)
        alert.addAction(trashAction)
        
        let trashAction2 = TSAlertAction(title: "Cancel",
                                        style: .cancel) { _ in
        }
        trashAction2.leftImage = folder
        trashAction2.configuration = configuration
        trashAction2.highlightType = .dimAndScaleDown(color: .systemGray5)
        alert.addAction(trashAction2)
        
        let trashAction1 = TSAlertAction(title: "Destructive",
                                         style: .destructive) { _ in
        }
        trashAction1.leftImage = folder
        trashAction1.configuration = configuration
        trashAction1.highlightType = .dimAndScaleDown(color: .systemGray5)
        alert.addAction(trashAction1)
        
        // Present alert
        alert.present(animated: true)
    }
}
