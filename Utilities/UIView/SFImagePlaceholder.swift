//
//  SFImagePlaceholder.swift
//  Utilities
//
//  Created by Jose A Ramirez on 19/02/2021.
//  Copyright © 2021 The Curious Pixel. All rights reserved.
//

import Foundation
import UIKit

class SFImagePlaceholder: UIView {
    
    init(frame: CGRect,
         sfSymbolName: String,
         sfSymbolConfig: UIImage.SymbolConfiguration,
         sfSymbolTintColor: UIColor?,
         sfSymbolAlignment: UIView.ContentMode,
         sfSymbolMargin: CGFloat,
         gradientAlignment: GradientView.GradientViewAxis = .horizontal,
         gradientStartColor: UIColor = UIColor(white: 0, alpha: 0),
         gradientEndColor: UIColor = UIColor(white: 0, alpha: 1)) {
        super.init(frame: frame)
        
        gradientView = GradientView(frame: frame,
                                    alignment: gradientAlignment,
                                    startColor: gradientStartColor,
                                    endColor: gradientEndColor)
        
        sfImage = UIImage.sfImage(named: sfSymbolName,
                                  config: sfSymbolConfig,
                                  withTintColor: sfSymbolTintColor)
        
        let sfImageView = UIImageView(frame: frame)
        sfImageView.image = sfImage
        sfImageView.contentMode = sfSymbolAlignment
        
        // skipping constraints for now to test
        self.addSubview(gradientView)
        gradientView.constrain(toParent: self, atCorners: .all)
        
        self.addSubview(sfImageView)
        sfImageView.constrain(toParent: self,
                              atCorners: .all,
                              hMargin: sfSymbolMargin,
                              vMargin: sfSymbolMargin)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var gradientView: GradientView!
    private var sfImage: UIImage!
}
