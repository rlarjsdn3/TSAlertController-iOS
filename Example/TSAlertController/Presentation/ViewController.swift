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
        // TSAlertController Initalization
        let alert = TSAlertController(
            title: "다음에 할까요?",
            message: "여기서 나가면 처음부터 다시 진행해야 해요.",
            preferredStyle: .alert
        )

        // Add button actions
        let okAction = TSAlertAction(title: "이어서 하기", style: .default) { _ in
        }
        alert.addAction(okAction)
        
        let cancelAction = TSAlertAction(title: "나가기", style: .cancel) { _ in
        }
        alert.addAction(cancelAction)
        
        // Add textfield
        alert.addTextField {
            $0.placeholder = "아이디"
        }
        alert.addTextField {
            $0.placeholder = "비밀번호"
        }

        // Present alert
        present(alert, animated: true)
    }
    
}

