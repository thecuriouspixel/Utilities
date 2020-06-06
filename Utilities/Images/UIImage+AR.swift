//
//  UIImage+AR.swift
//  Utilities
//
//  Created by Jose A Ramirez on 06/06/2020.
//  Copyright © 2020 The Curious Pixel. All rights reserved.
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
}
