//
//  NSFileManager+AR.swift
//  VisualTasks
//
//  Created by Jose A Ramirez on 9/7/19.
//  Copyright © 2019 Jose A Ramirez. All rights reserved.
//

import Foundation

extension FileManager {
    class func getDocumentsDirectory() -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else
        {
            return nil
        }
        return documentsDirectory
    }
    
    class func getDocumentsInDirectory(ofType: String) -> [URL]{
        
        var URLs:[URL] = []
        if let documentsDirectory = FileManager.getDocumentsDirectory() {
            do {
                let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles])
                
                let onlyAppFiles = directoryContents.filter{$0.pathExtension == ofType}
                URLs = onlyAppFiles
            } catch {
                print("Could not search for urls of files in documents directory: \(error)")
            }
        }
        return URLs
    }
    
    class func uniqueFileName(forBaseName baseName: String, withFileType type: String, atURL: URL) -> String {
        
        var possibleName = String("\(baseName).\(type)")
        var pathToCheck = atURL.appendingPathComponent(possibleName)
        var fileCounter = 2 // start at two as the first same name is "1"
        while FileManager.default.fileExists(atPath: pathToCheck.path) {
            possibleName = String(format: "\(baseName) \(fileCounter).\(type)")
            pathToCheck = atURL.appendingPathComponent(possibleName)
            fileCounter += 1
        }
        return possibleName
    }
}
