//
//  ARFullScreenImageViewer.swift
//  Utilities
//
//  Copyright © 2021 The Curious Pixel. All rights reserved.
//

import UIKit

class ARFullScreenImageViewer: UIScrollView {
    
    private var imageView: UIImageView!
    private var gestureDoubleTap: UITapGestureRecognizer!
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        
        self.delegate = self
        
        // need to set otherwise it won't trigger zoom events
        self.maximumZoomScale = 2.0
        self.minimumZoomScale = 1.0
    }
    
    func add(image: UIImage) {
        setup(withImage: image)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func didMoveToSuperview() {
        
        if let sv = self.superview {
            self.constrain(toParent: sv, atCorners: .all)
        }
    }
    
    func setup(withImage image: UIImage) {
        
        if self.gestureDoubleTap == nil {
            
            let gr = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
            gr.numberOfTapsRequired = 2
            
            self.addGestureRecognizer(gr)
            
            self.gestureDoubleTap = gr
        }
        
        if self.imageView == nil {
            self.imageView = UIImageView(image: image)
            self.imageView.alpha = 0
            self.imageView.contentMode = .scaleAspectFit
            
            self.addSubview(self.imageView)
            
            self.imageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
            self.imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            self.imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            self.imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            
            UIView.animate(withDuration: 1.0) {
                self.imageView.alpha = 1.0
            }
            
        } else {
            self.imageView.image = image
        }
        
        self.calculateScale(imageToFit: image)
    }
    
    func calculateScale(imageToFit: UIImage) {
        
        debugPrint("Image size \(imageToFit.size)")
        
        let screenScale = UIScreen.main.scale
        
        // assume imageView same size as scroll view
        let widthScale = (self.frame.size.width * screenScale) / imageToFit.size.width
        let heightScale = (self.frame.size.height * screenScale) / imageToFit.size.height
        
        self.maximumZoomScale = 1.0/min( widthScale, heightScale)
    }
    
    @objc private func doubleTapped(_ sender: UITapGestureRecognizer) {
        debugPrint("Double tapped")
        
        if self.zoomScale != self.maximumZoomScale {
            
            debugPrint("maximumZoomScale \(self.maximumZoomScale)")
            let point = sender.location(in: self.imageView)
            
            let size = CGSize(width: self.imageView.frame.size.width / self.maximumZoomScale,
                              height: self.imageView.frame.size.height / self.maximumZoomScale)
            let origin = CGPoint(x: point.x - size.width / 2,
                                 y: point.y - size.height / 2)
            self.zoom(to:CGRect(origin: origin, size: size), animated: true)
            print(CGRect(origin: origin, size: size))
            
        } else {
            self.zoom(to: self.frame, animated: true)
        }
    }
}

extension ARFullScreenImageViewer: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
