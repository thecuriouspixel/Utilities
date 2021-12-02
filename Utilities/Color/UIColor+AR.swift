//
//  UIColor+AR.swift
//  Utilities
//
//  Copyright © 2021 The Curious Pixel. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexInt: UInt64 = 0
        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt64(&hexInt)
        
        let red = CGFloat((hexInt & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexInt & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexInt & 0xff) >> 0) / 255.0
        let alpha = alpha
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // does not do alpha
    var hexString: String {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: nil)
        // clamping due to wide color
        return [r.clamped(0,1), g.clamped(0,1), b.clamped(0,1)].map { String(format: "%02lX", Int($0 * 255)) }.reduce("#", +)
    }
}
