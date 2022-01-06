//
//  SFImagePlaceholder.swift
//  Utilities
//
//  Copyright © 2021 The Curious Pixel. All rights reserved.
//

import Foundation
import UIKit

struct ARImagePlaceholderGradientInfo {
    var gradientAlignment: ARGradientView.GradientViewAxis = .horizontal
    var gradientStartColor: UIColor = UIColor(white: 0, alpha: 0)
    var gradientEndColor: UIColor = UIColor(white: 0, alpha: 1)
}

enum ARImagePlaceHolderImageAlignment {
    case left
    case right
    case center
}

class ARImagePlaceholder: UIView {
    
    init(frame: CGRect,
         imageOrSymbolName: String,
         tintColor: UIColor?,
         alignment: ARImagePlaceHolderImageAlignment = .center,
         margin: CGFloat,
         imageToViewRatio: CGSize = CGSize(width: 0.25, height: 0.25),
         sfSymbolConfig: UIImage.SymbolConfiguration?,
         gradientConfig: ARImagePlaceholderGradientInfo?) {
        super.init(frame: frame)
       
        
        // GRADIENT VIEW
        if let gradientConfig = gradientConfig {
            gradientView = ARGradientView(frame: frame,
                                          alignment: gradientConfig.gradientAlignment,
                                          startColor: gradientConfig.gradientStartColor,
                                          endColor: gradientConfig.gradientEndColor)
            
            gradientView.constrain(toParent: self, atCorners: .all)
        }
        
        // IMAGE
        let previewImage: UIImage?
        if let fileImage = UIImage.image(named: imageOrSymbolName,
                                         withTintColor: tintColor) {
            previewImage = fileImage
        } else {
            previewImage = UIImage.sfImage(named: imageOrSymbolName,
                                           config: sfSymbolConfig ?? UIImage.SymbolConfiguration(pointSize: 12, weight: .regular),
                                           withTintColor: tintColor)
        }
        
        let sfImageView = UIImageView(frame: frame)
        sfImageView.image = previewImage
        sfImageView.contentMode = .scaleAspectFit
        
        self.addSubview(sfImageView)
        sfImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: imageToViewRatio.width).isActive = true
        sfImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: imageToViewRatio.height).isActive = true
        switch alignment {
            case .center:
                sfImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
                sfImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            case .left:
                sfImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                sfImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: margin).isActive = true
            case .right:
                sfImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
                sfImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -margin).isActive = true
        }
        sfImageView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var gradientView: ARGradientView!
    private var sfImage: UIImage!
}
