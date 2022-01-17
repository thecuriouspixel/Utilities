//
//  UIView+AR.swift
//  Utilities
//
//  Copyright © 2021 The Curious Pixel. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // need to test
    static func instantiateFromNib() -> Self? {
    
        func instanceFromNib<T: UIView>() -> T? {
            
            return UINib(nibName: "\(self)", bundle: nil).instantiate(withOwner: nil, options: nil).first as? T
        }
        
        return instanceFromNib()
    }
    
    enum Alignment {
        case center
        case left
        case right
    }
    
    func round(corners: UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func constrain(toParent parent: UIView, atCorners edges: UIRectEdge, hMargin: CGFloat = 0, vMargin: CGFloat = 0) {
        
        if !parent.subviews.contains(self) && self.superview == nil {
            parent.addSubview(self)
        }
        
        if edges.contains(.all) {
            self.topAnchor.constraint(equalTo: parent.topAnchor,
                                      constant: vMargin).isActive = true
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor,
                                         constant: -vMargin).isActive = true
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor,
                                          constant: hMargin).isActive = true
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor,
                                           constant: -hMargin).isActive = true
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
    
    func center(inView masterView: UIView, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
        centerYAnchor.constraint(equalTo: masterView.centerYAnchor, constant: offsetY).isActive = true
        centerXAnchor.constraint(equalTo: masterView.centerXAnchor, constant: offsetX).isActive = true
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func generate(ofSize size: CGSize, withImage image: UIImage, imageScale: CGFloat, alignment: Alignment, backgroundColor: UIColor) -> UIView {
        
        let baseView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        baseView.backgroundColor = backgroundColor
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        baseView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        switch alignment {
            case .left:
                imageView.centerYAnchor.constraint(equalTo: baseView.centerYAnchor).isActive = true
                imageView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor).isActive = true
            case .right:
                imageView.centerYAnchor.constraint(equalTo: baseView.centerYAnchor).isActive = true
                imageView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor).isActive = true
            default:
                imageView.centerYAnchor.constraint(equalTo: baseView.centerYAnchor).isActive = true
                imageView.centerXAnchor.constraint(equalTo: baseView.centerXAnchor).isActive = true
        }
        
        imageView.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: imageScale).isActive = true
        imageView.heightAnchor.constraint(equalTo: baseView.heightAnchor, multiplier: imageScale).isActive = true
        
        return baseView
    }
    
    func toImage() -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        let image = renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
        return image
    }
}
