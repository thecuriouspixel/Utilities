//
//  UIView+AR.swift
//  Utilities
//
//  Created by Jose A Ramirez on 27/09/2020.
//  Copyright © 2020 The Curious Pixel. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func constrain(toParent parent: UIView, atCorners edges: UIRectEdge, hMargin: CGFloat = 0, vMargin: CGFloat = 0) {
        
        if edges.contains(.all) {
            self.topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
        } else {
            
            if edges.contains(.top) {
                self.topAnchor.constraint(equalTo: parent.topAnchor, constant: vMargin).isActive = true
            }
            
            if edges.contains(.bottom) {
                self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -vMargin).isActive = true
            }
            
            if edges.contains(.left) {
                self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: hMargin).isActive = true
            }
            
            if edges.contains(.right) {
                self.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -hMargin).isActive = true
            }
        }
        translatesAutoresizingMaskIntoConstraints = false
    }
}
