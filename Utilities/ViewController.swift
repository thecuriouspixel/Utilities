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
    
    @IBAction func testViewControllerResizeImage(id: Any) {
        
        if let image = UIImage(named: "mila.jpg") {
            if let resized = image.resizedImage(for: CGSize(width: 50, height: 50)) {
                
                let imageView = UIImageView(frame: self.view.frame)
                imageView.image = resized
                imageView.contentMode = .scaleAspectFit
                
                let displayController = UIViewController()
                displayController.view.addSubview(imageView)
                
                self.present(displayController, animated: true) {
                    debugPrint("Presented image modal")
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

