//
//  ARTextCapture.swift
//  Utilities
//
//  Copyright © 2021 The Curious Pixel. All rights reserved.
//

import UIKit

/*
 * Textfield background is kept above the keyboard via constant change. Other elements are aligned to it.
 */
class ARTextCapture: UIViewController {
    
    static let fieldOffset: CGFloat = -100
    
    func requestText(parentVC: UIViewController,
                     titleString: String,
                     placeholderString: String,
                     completion: @escaping ((String?)-> Void),
                     currentText: String?,
                     tintColor: UIColor = .white) {
        
        addAsChildViewController(toParent: parentVC)
        
        self.currentText = currentText ?? ""
        self.completion = completion
        
        setup(titleString: titleString, placeholderString: placeholderString, currentText: currentText, tintColor: tintColor)
        
        UIView.animate(withDuration: 0.4) {
            self.fieldBackground.alpha = 1
            self.textField.alpha = 1
        }completion: { (success) in
            UIView.animate(withDuration: 0.4) {
                self.label.alpha = 1
                self.textField.becomeFirstResponder() // not only does it look good, it's a nice way to "wait some time"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowOrHide(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        completion = nil
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLayoutSubviews() {
        updateLayout()
    }
    
    private weak var fieldBackground: UIView!
    private weak var textFieldConstraint: NSLayoutConstraint!
    private weak var textField: UITextField!
    private weak var label: UILabel!
    private var currentText: String = ""
    private var completion: ((String?) -> Void)?
}

extension ARTextCapture: UITextFieldDelegate {
    
    // new name captured at this point
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        completion?(textField.text)
        
        removeAsChildViewController()
        
        return false
    }
}

// MARK: - Private
extension ARTextCapture {
    
    private func setup(titleString: String, placeholderString: String, currentText: String?, tintColor: UIColor) {
        
        addVisualEffectView()
        addTextField(placeholderString: placeholderString, currentText: currentText, tintColor: tintColor)
        addTitle(titleString: titleString, tintColor: tintColor)
        
        fieldBackground.alpha = 0
        textField.alpha = 0
        label.alpha = 0
    }
    
    private func addTextField(placeholderString: String, currentText: String?, tintColor: UIColor) {
        
        let bknd = addTextFieldBackground()
        
        let textField = UITextField()
        textField.text = currentText
        textField.textAlignment = .center
        textField.textColor = .white
        textField.returnKeyType = .done
        textField.tintColor = tintColor
        addClearButton(toTextField: textField, tintColor: tintColor)
        
        textField.delegate = self
        
        view.addSubview(textField)
        
        let lightPlaceHolderText = NSAttributedString(string: placeholderString,
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.attributedPlaceholder = lightPlaceHolderText
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalTo: bknd.widthAnchor, multiplier: 0.9).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textField.centerXAnchor.constraint(equalTo: bknd.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: bknd.centerYAnchor).isActive = true
        
        fieldBackground = bknd
        self.textField = textField
    }
    
    private func addVisualEffectView() {
        let newView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        newView.constrain(toParent: self.view, atCorners: .all)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(cancel(sender:)))
        newView.addGestureRecognizer(tapRecognizer)
    }
    
    private func addTextFieldBackground() -> UIView {
        
        let widthMultiplier: CGFloat = 0.8
        
        let textBnkd = UIView()
        textBnkd.backgroundColor = .black
        view.addSubview(textBnkd)
        
        textBnkd.translatesAutoresizingMaskIntoConstraints = false
        textBnkd.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: widthMultiplier).isActive = true
        textBnkd.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textBnkd.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let constraint = textBnkd.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: Self.fieldOffset)
        constraint.isActive = true
        self.textFieldConstraint = constraint
        
        return textBnkd
    }
    
    private func addTitle(titleString: String, tintColor: UIColor) {
        
        let label = UILabel()
        label.text = titleString
        label.font = UIFont.systemFont(ofSize: 30, weight: .thin)
        label.textColor = tintColor
        label.setCharacterSpacing(2)
        
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.widthAnchor.constraint(equalTo: fieldBackground.widthAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        label.leadingAnchor.constraint(equalTo: fieldBackground.leadingAnchor).isActive = true
        
        label.bottomAnchor.constraint(equalTo: fieldBackground.topAnchor, constant: -10).isActive = true
        
        self.label = label
    }
    
    private func addClearButton(toTextField textField: UITextField, tintColor: UIColor = .white) {
        
        let config = UIImage.SymbolConfiguration(pointSize: 16)
        let buttonImage = UIImage.sfImage(named: "xmark.circle", config: config, withTintColor: tintColor)
        
        let clearButton = UIButton(type: .custom)
        clearButton.setImage(buttonImage, for: .normal)
        clearButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        clearButton.contentMode = .scaleAspectFit
        clearButton.addTarget(self, action: #selector(clear(sender:) ), for: .touchUpInside)
        textField.rightView = clearButton
        textField.rightViewMode = .always
        
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
                
                if endRect.height > view.frame.height/3 { // make sure we don't get random small keyboard events
                    
                    self.textFieldConstraint?.constant = (keyboardOverlap > 0) ? -keyboardOverlap + Self.fieldOffset : Self.fieldOffset
                    
                    let duration = (durationValue as AnyObject).doubleValue
                    let options = UIView.AnimationOptions(rawValue: UInt((curveValue as AnyObject).integerValue << 16))
                    
                    UIView.animate(withDuration: duration!, delay: 0, options: options, animations: {
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                }
            }
        }
    }
    
    @objc func clear(sender : AnyObject) {
        textField.text = ""
        textField.sendActions(for: .editingChanged)
    }
    
    @objc func cancel(sender : AnyObject) {
        textField.resignFirstResponder()
        
        completion?(nil)
        
        removeAsChildViewController()
    }
}
