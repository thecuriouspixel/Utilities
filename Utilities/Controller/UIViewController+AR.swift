//
//  UIViewController+OneShot.swift
//  OneShot
//
//  Created by Jose A Ramirez on 02/06/2020.
//  Copyright © 2020 The Curious Pixel. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func promptForString(withTitle title: String, completion: @escaping ((String?) -> Void)) {
        
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            if let answer = ac.textFields?[0] {
                completion(answer.text)
            } else {
                completion(nil)
            }
        }
        submitAction.isEnabled = false
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(nil)
        }
        
        ac.addAction(submitAction)
        ac.addAction(cancel)
        
        // leaving this hanging and never removing it
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification,
                                               object:ac.textFields?[0],
                                               queue: OperationQueue.main) { (notification) -> Void in
                                                
                                                if let textField = ac.textFields?[0] {
                                                    submitAction.isEnabled = textField.text?.count ?? 0 > 0
                                                }
        }

        present(ac, animated: true)
    }
    
    func showAlertView(title: String?,
                       message: String?,
                       actions: [UIAlertAction],
                       style: UIAlertController.Style,
                       cancelString: String = "Cancel") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.overrideUserInterfaceStyle = .light
        
        let cancelAction = UIAlertAction(title: cancelString, style: .cancel, handler: nil)
        for action in actions {
            alertController.addAction(action)
        }
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        alertController.addAction(cancelAction)
        alertController.view.tintColor = UIColor(red: 31/255, green: 53/255, blue: 84/255, alpha: 1)
        present(alertController, animated: true, completion: nil)
    }
    
    func openAppSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
    
    func addAsChildViewController(toParent parent: UIViewController) {
        parent.addChild(self)
        parent.view.addSubview(self.view)
        self.didMove(toParent: parent)
    }
    
    func removeAsChildViewController() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
}
