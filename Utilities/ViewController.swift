//
//  ViewController.swift
//  Utilities
//
//  Created by Jose A Ramirez on 25/05/2020.
//  Copyright © 2020 The Curious Pixel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func testViewControllerPromptForString(id: Any) {
        promptForString(withTitle: "This is a title") { (response) in
            
            debugPrint("Got text \(response ?? "nil")")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

