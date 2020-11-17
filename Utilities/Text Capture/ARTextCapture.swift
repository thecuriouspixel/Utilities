//
//  ARTextCapture.swift
//  Utilities
//
//  Created by Jose A Ramirez on 11/11/2020.
//  Copyright © 2020 The Curious Pixel. All rights reserved.
//

import UIKit

/*
 * Textfield background is kept above the keyboard via constant change. Other elements are aligned to it.
 */

class ARTextCapture: UIViewController {
    
    // init with a delegate - or just pass a callback?
    
    func requestText(parentVC: UIViewController) {
        debugPrint("Requesting text")
        parentVC.addChild(self)
        parentVC.view.addSubview(self.view)
        self.didMove(toParent: parentVC)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("ARTextCapture loaded")
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowOrHide(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLayoutSubviews() {
        updateLayout()
    }
    
    func setup() {
        addVisualEffectView()
        addTextField()
        updateLayout()
    }
    
    func addTextField() {
        
        let bknd = addTextFieldBackground()
        
        let textField = UITextField()
        textField.textAlignment = .center
        textField.textColor = .lightText
        textField.delegate = self
        
        view.addSubview(textField)
        
        let lightPlaceHolderText = NSAttributedString(string: "Enter a new name",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.attributedPlaceholder = lightPlaceHolderText
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalTo: bknd.widthAnchor, multiplier: 0.9).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textField.centerXAnchor.constraint(equalTo: bknd.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: bknd.centerYAnchor).isActive = true
        
        fieldBackground = bknd
        
        textField.becomeFirstResponder()
    }
    
    func addVisualEffectView() {
        let newView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        view.addSubview(newView)
        newView.constrain(toParent: self.view, atCorners: .all)
    }
    
    func addTextFieldBackground() -> UIView {
        
        let widthMultiplier: CGFloat = 0.8
        
        let textBnkd = UIView()
        textBnkd.backgroundColor = .black
        view.addSubview(textBnkd)
        
        textBnkd.translatesAutoresizingMaskIntoConstraints = false
        textBnkd.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultiplier).isActive = true
        textBnkd.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textBnkd.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let constraint = textBnkd.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        constraint.isActive = true
        self.textFieldConstraint = constraint
        
        return textBnkd
    }

    private func updateLayout() {
        fieldBackground?.round(corners: .allCorners, radius: 12)
    }
    
    @objc private func keyboardWillShowOrHide(notification: NSNotification) {
            // Get required info out of the notification
            if let userInfo = notification.userInfo, let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey], let durationValue = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey], let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] {
                
                if let fieldBackground = fieldBackground {
                    
                    let endRect = view.convert((endValue as AnyObject).cgRectValue, from: view)
                    let keyboardOverlap = (fieldBackground.frame.maxY - endRect.origin.y) + 10 // 10 is offset
                    
                    if keyboardOverlap > 0 {
                        
                        let duration = (durationValue as AnyObject).doubleValue
                        let options = UIView.AnimationOptions(rawValue: UInt((curveValue as AnyObject).integerValue << 16))
                        
                        UIView.animate(withDuration: duration!, delay: 0, options: options, animations: {
                            self.textFieldConstraint?.constant = -keyboardOverlap
                            self.view.layoutIfNeeded()
                        }, completion: nil)
                    }
                }
            }
        }
    
    private weak var fieldBackground: UIView?
    private weak var textFieldConstraint: NSLayoutConstraint?

}

extension ARTextCapture: UITextFieldDelegate {

    // new name captured at this point
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
