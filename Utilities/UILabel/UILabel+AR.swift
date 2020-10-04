//
//  UILabel+AR.swift
//  Utilities
//
//  Created by Jose A Ramirez on 04/10/2020.
//  Copyright © 2020 The Curious Pixel. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    func setCharacterSpacing(_ characterSpacing: CGFloat) {
        
        guard let labelText = text else { return }
        
        let attributedString: NSMutableAttributedString
        if let labelAttributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSMakeRange(0, attributedString.length))
        
        attributedText = attributedString
    }

}
