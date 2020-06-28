//
//  ARFullScreenImageViewer.swift
//  Utilities
//
//  Created by Jose A Ramirez on 28/06/2020.
//  Copyright © 2020 The Curious Pixel. All rights reserved.
//

import UIKit

class ARFullScreenImageViewer: UIScrollView {
    
    private var imageView: UIImageView!
    
    init(withImage image: UIImage) {
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        
        self.delegate = self
        
        // need to set otherwise it won't trigger zoom events
        self.maximumZoomScale = 2.0
        self.minimumZoomScale = 1.0
        
        self.setup(withImage: image)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func didMoveToSuperview() {
        
        if let sv = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false;
            
            //Constrain scroll view
            self.leadingAnchor.constraint(equalTo: sv.leadingAnchor, constant: 0).isActive = true;
            self.topAnchor.constraint(equalTo: sv.topAnchor, constant: 0).isActive = true;
            self.trailingAnchor.constraint(equalTo: sv.trailingAnchor, constant: 0).isActive = true;
            self.bottomAnchor.constraint(equalTo: sv.bottomAnchor, constant: 0).isActive = true;
        }
    }
    
    func setup(withImage image: UIImage) {
        self.imageView = UIImageView(image: image)
        // self.imageView.backgroundColor = .orange
        self.imageView.contentMode = .scaleAspectFit
        
        self.addSubview(self.imageView)
        
        self.imageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func calculateScale(imageToFit: UIImage) -> CGFloat {
        
        // assume imageView same size as scroll view
        let widthScale = self.frame.size.width / imageToFit.size.width
        let heightScale = self.frame.size.height / imageToFit.size.height
        return min( widthScale, heightScale)
    }

}

extension ARFullScreenImageViewer: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        // find a better place to do this? Should only have to do it once
        if self.zoomScale == 1.0 {
            let scale = self.calculateScale(imageToFit: self.imageView.image!)
            self.maximumZoomScale = 1.0/scale
        }
    }
}
