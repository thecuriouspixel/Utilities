//
//  ARTextCapture.swift
//  Utilities
//
//  Created by Jose A Ramirez on 11/11/2020.
//  Copyright © 2020 The Curious Pixel. All rights reserved.
//

import UIKit

class ARTextCapture: UIViewController {
    
    // init with a delegate - or just pass a callback?
    
    func requestText(parentVC: UIViewController) {
        debugPrint("Requesting text")
        parentVC.addChild(self)
        parentVC.view.addSubview(self.view)
        self.didMove(toParent: parentVC)
        
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("ARTextCapture loaded")

    }
    
    func setup() {
        addVisualEffectView()
        addTextField()
    }
    
    func addTextField() {
        
        let bknd = addTextFieldBackground()
        
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = .lightText
        view.addSubview(textField)
        
        let lightPlaceHolderText = NSAttributedString(string: "Enter a new name",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.attributedPlaceholder = lightPlaceHolderText
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalTo: bknd.widthAnchor, multiplier: 0.9).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textField.centerXAnchor.constraint(equalTo: bknd.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: bknd.centerYAnchor).isActive = true
        
        textField.becomeFirstResponder()
        
    }
    
    func addVisualEffectView() {
        let newView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        view.addSubview(newView)
        newView.constrain(toParent: self.view, atCorners: .all)
    }
    
    func addTextFieldBackground() -> UIView {
        
        let widthMultiplier: CGFloat = 0.8
        
        let textBnkd = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width * widthMultiplier, height: 60))
        textBnkd.backgroundColor = .black
        view.addSubview(textBnkd)
        
        textBnkd.translatesAutoresizingMaskIntoConstraints = false
        textBnkd.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultiplier).isActive = true
        textBnkd.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textBnkd.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textBnkd.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        
        textBnkd.round(corners: .allCorners, radius: 12)
        
        return textBnkd
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
