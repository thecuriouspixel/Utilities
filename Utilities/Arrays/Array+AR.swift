//
//  Array+AR.swift
//  Utilities
//
//  Copyright © 2021 The Curious Pixel. All rights reserved.
//

import Foundation

extension Array {

    func makeInfiniteLoopIterator() -> AnyIterator<Element> {
        var index = self.startIndex

        return AnyIterator({
            if self.isEmpty {
                return nil
            }

            let result = self[index]

            index = self.index(after: index)
            if index == self.endIndex {
                index = self.startIndex
            }

            return result
        })
    }
    
    func itemsFromRandom(_ limit: Int) -> ArraySlice<Element> {
        
        guard limit < self.count else {
            return self[0..<self.count] // need to force an ArraySlice
        }
        
        let maxStart = self.count - limit
        let randomStart = Int.random(in: 0..<maxStart)
        return self[randomStart..<(randomStart+limit)]
    }
}
