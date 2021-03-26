//
//  GradientView.swift
//  Utilities
//
//  Created by Jose A Ramirez on 04/10/2020.
//  Copyright © 2020 The Curious Pixel. All rights reserved.
//

import UIKit

class ARGradientView: UIView {
    
    enum GradientViewAxis {
        case vertical
        case horizontal
    }
    
    private var startColor: UIColor?
    private var endColor: UIColor?
    private var axis: GradientViewAxis?
    
    init(frame: CGRect, alignment: GradientViewAxis = .horizontal, startColor: UIColor = UIColor(white: 0, alpha: 0), endColor: UIColor = UIColor(white: 0, alpha: 1)) {
        super.init(frame: frame)
        
        self.startColor = startColor
        self.endColor = endColor
        self.axis = alignment
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let startColor = self.startColor, let endColor = self.endColor else {
            fatalError("Incorrect use of GradientView")
        }
        
        let context = UIGraphicsGetCurrentContext()!

        let gradient = CGGradient(colorsSpace: nil, colors: [startColor.cgColor, endColor.cgColor] as CFArray, locations: [0, 1])!

        let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        context.saveGState()
        rectanglePath.addClip()
        
        if self.axis == .horizontal {
            context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: self.frame.height/2), end: CGPoint(x: self.frame.width, y: self.frame.height/2), options: [])
        } else {
            context.drawLinearGradient(gradient, start: CGPoint(x: self.frame.width/2, y: 0), end: CGPoint(x: self.frame.width/2, y: self.frame.height), options: [])
        }
        
        context.restoreGState()
    }

}
