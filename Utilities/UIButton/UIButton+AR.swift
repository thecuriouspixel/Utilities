//
//  UIButton+AR.swift
//  OneShot
//
//  Copyright © 2021 The Curious Pixel. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func set(withImage image: UIImage,
             action: Selector,
             tintColor: UIColor,
             target: Any?) {
        self.setImage(image, for: .normal)
        self.addTarget(target, action: action, for: .touchUpInside)
        self.imageView?.contentMode = .scaleAspectFit
        self.tintColor = tintColor
    }
    
    
    // from: https://noahgilmore.com/blog/uibutton-padding/
    func setInsets(
        forContentPadding contentPadding: UIEdgeInsets,
        imageTitlePadding: CGFloat
    ) {
        self.contentEdgeInsets = UIEdgeInsets(
            top: contentPadding.top,
            left: contentPadding.left,
            bottom: contentPadding.bottom,
            right: contentPadding.right + imageTitlePadding
        )
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: imageTitlePadding,
            bottom: 0,
            right: -imageTitlePadding
        )
    }
    
}
