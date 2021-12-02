//
//  UIImage+AR.swift
//  Utilities
//
//  Copyright © 2021 The Curious Pixel. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func resizedImage(for size: CGSize) -> UIImage? {

        let renderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    static func image(named: String, withTintColor tint: UIColor?) -> UIImage? {
        
        if let fileImage = UIImage(named: named) {
            if let tintColor = tint {
                return fileImage.withTintColor(tintColor)
            }
            
            return fileImage
        }
        
        return nil
    }
    
    static func sfImage(named: String, config: SymbolConfiguration, withTintColor tint: UIColor?) -> UIImage? {
        
        if let galleryGfx = UIImage(systemName: named, withConfiguration: config) {
         
            if let tint = tint {
                return galleryGfx.withTintColor(tint, renderingMode: .alwaysOriginal)
            }
            
            return galleryGfx
        }
        
        return nil
    }
    
}
