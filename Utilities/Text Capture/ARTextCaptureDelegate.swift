//
//  ARTextCaptureDelegate.swift
//  Utilities
//
//  Created by Jose A Ramirez on 04/01/2021.
//  Copyright © 2021 The Curious Pixel. All rights reserved.
//

import Foundation

protocol ARTextCaptureDelegate: class {
    
    func textCaptured(newString: String, oldString: String)
    func textCaptureCancelled()
}
