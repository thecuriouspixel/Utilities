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
    
    @IBAction func testFullScreenImageViewer(id: Any) {
        
        if let image = UIImage(named: "mila.jpg") {
            let fullScreenView = ARFullScreenImageViewer()
            fullScreenView.backgroundColor = .darkGray
            
            let vc = UIViewController()
            
            vc.view.addSubview(fullScreenView)
            
            self.present(vc, animated: true) {
                debugPrint("Presented full image view")
                fullScreenView.add(image: image)
            }
        }
    }
    
    @IBAction func testHorizontalGradientOverlay(id: Any) {
        
        if let image = UIImage(named: "mila.jpg") {
            let imageview = UIImageView(image: image)
            imageview.contentMode = .scaleAspectFit
            
            let gradienView = GradientView(frame: CGRect.zero, alignment: .vertical)
            
            let vc = UIViewController()
            
            vc.view.addSubview(imageview)
            imageview.constrain(toParent: vc.view, atCorners: .all)
            
            vc.view.addSubview(gradienView)
            gradienView.constrain(toParent: vc.view, atCorners: .all)
            
            self.present(vc, animated: true) {
                debugPrint("Presented horizontal gradient test")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Test some utils that don't need a button press
        testIterator()
    }

    
    private func testIterator() {
        
        let array = [ 1, 2, 3, 4]
        
        let iterator = array.makeInfiniteLoopIterator()
        
        debugPrint("Iterator 10 items using next")
        var index = 0
        while index < 10 {
            if let next = iterator.next() {
                debugPrint(next)
            }
            index += 1
        }
        
        // prep 10 items ahead of time
        debugPrint("Iterator 10 items prepared")
        let tenItems = iterator.prefix(10)
        for item in tenItems {
            debugPrint(item)
        }
    }

}

