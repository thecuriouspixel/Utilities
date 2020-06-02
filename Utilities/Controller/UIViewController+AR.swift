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
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        ac.addAction(submitAction)
        ac.addAction(cancel)

        present(ac, animated: true)
    }
    
}
