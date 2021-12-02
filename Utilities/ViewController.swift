//
//  ViewController.swift
//  Utilities
//
//  Copyright © 2021 The Curious Pixel. All rights reserved.
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
                imageView.constrain(toParent: displayController.view, atCorners: .all)
                
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
            
            let gradienView = ARGradientView(frame: CGRect.zero, alignment: .vertical)
            
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
    
    @IBAction func testTextCapture(id: Any) {
        
        let tintColor = UIColor(displayP3Red: 255/255, green: 233/255, blue: 145/255, alpha: 1.0)
        
        let vc = UIViewController()
        
        let imageView = UIImageView(image: UIImage(named: "mila.jpg"))
        imageView.contentMode = .scaleAspectFill
        
        vc.view.addSubview(imageView)
        imageView.constrain(toParent: vc.view, atCorners: .all)
        
        self.present(vc, animated: true) {
            debugPrint("Presented text capture test - adding text capture")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                let textRequest = ARTextCapture()
                textRequest.requestText(parentVC: vc,
                                        titleString: "Rename",
                                        placeholderString: "Enter a new name",
                                        completion: { (newString) in
                                            if let newString = newString {
                                                debugPrint("Text Captured with \(newString)")
                                            } else {
                                                debugPrint("Capture cancelled")
                                            }
                                        },
                                        currentText: "Andres",
                                        tintColor: tintColor)
            }
        }
    }
    
    @IBAction func testSFImagePlaceholder(id: Any) {
        
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        
        let gradientConfig = ARImagePlaceholderGradientInfo(gradientAlignment: .horizontal,
                                                            gradientStartColor: .blue,
                                                            gradientEndColor: .red)
        let placeholder = ARImagePlaceholder(frame: CGRect.zero,
                                             imageOrSymbolName: "square.and.arrow.up",
                                             tintColor: .white,
                                             alignment: .left,
                                             margin: 20,
                                             imageToViewRatio: CGSize(width: 0.25, height: 0.25),
                                             sfSymbolConfig: config,
                                             gradientConfig: gradientConfig
                                             )
        
        let vc = UIViewController()
        vc.view.addSubview(placeholder)
        placeholder.constrain(toParent: vc.view, atCorners: .all)
        
        self.present(vc, animated: true) {
            debugPrint("Presented SFImagePlaceholder test")
        }
    }
    
    @IBAction func testImagePlaceholderWithImage(id: Any) {
        
        let gradientConfig = ARImagePlaceholderGradientInfo(gradientAlignment: .horizontal,
                                                            gradientStartColor: .blue,
                                                            gradientEndColor: .red)
        
        let placeholder = ARImagePlaceholder(frame: CGRect.zero,
                                             imageOrSymbolName: "coffee",
                                             tintColor: .systemPink,
                                             alignment: .right,
                                             margin: 20,
                                             imageToViewRatio: CGSize(width: 0.25, height: 0.25),
                                             sfSymbolConfig: nil,
                                             gradientConfig: gradientConfig)
        
        let vc = UIViewController()
        vc.view.addSubview(placeholder)
        placeholder.constrain(toParent: vc.view, atCorners: .all)
        
        self.present(vc, animated: true) {
            debugPrint("Presented SFImagePlaceholder test")
        }
    }
    
    @IBAction func testButtonWithImage(id: Any) {
        
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        
        if let sfImage = UIImage.sfImage(named: "gamecontroller", config: config, withTintColor: .red) {
            
            let button = UIButton(frame: CGRect(x:0,y:0,width:100,height:100))
            button.setTitle("Title", for: .normal)
            button.backgroundColor = .black
            button.set(withImage: sfImage, action: #selector(self.genericSelector), tintColor: .gray, target: self)
            
            let vc = UIViewController()
            vc.view.backgroundColor = .lightGray
            vc.view.addSubview(button)
            
            button.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
            button.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.setInsets(forContentPadding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                             imageTitlePadding: 10)
            
            self.present(vc, animated: true) {
                debugPrint("Presented Button With Image test")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func genericSelector() {
        debugPrint("Selector called")
    }

}
