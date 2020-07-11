//
//  UIViewController+OneShot.swift
//  OneShot
//
//  Created by Jose A Ramirez on 02/06/2020.
//  Copyright © 2020 The Curious Pixel. All rights reserved.
//

import UIKit

extension UIViewController {
    
    enum PermissionError {
        case camera
        case gallery
    }
    
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
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { [unowned ac] _ in
            completion(nil)
        }
        
        ac.addAction(submitAction)
        ac.addAction(cancel)

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
    
    // only handling cmaera or gallery for now
    func displayPermissionsError(type: PermissionError) {
        
        var action: [UIAlertAction] = []
        // being paranoid and not adding the button if we are not going to be able to do it
        if URL(string: UIApplication.openSettingsURLString) != nil {
            let settingsAction = UIAlertAction(title: "Open Settings", style: .default) { _ in
                self.openAppSettings()
            }
            action.append(settingsAction)
        }
        
        var title: String
        var message: String
        switch type {
            case .camera:
                title = "Can't access your camera"
                message = "Enable the camera permission in settings to take photos"
            case .gallery:
                title = "Can't access your photos"
                message = "Enable photo access in settings to save photos"
        }
        
        showAlertView(title: title,
                      message: message,
                      actions: action,
                      style: .alert,
                      cancelString: "Cancel")
    }
    
    func openAppSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        }
    }
    
}
