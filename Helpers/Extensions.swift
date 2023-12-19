//
//  Extensions.swift
//  Advent of Code
//
//  Created by DanielJohns on 2022-01-07.
//

import Foundation
import Algorithms

extension StringProtocol {
    var lines: [String] {
        split(separator: "\n").lazy.map { String($0) }
    }
    
    var allLines: [String] {
        split(separator: "\n", omittingEmptySubsequences: false).lazy.map { String($0) }
    }
    
    var allDigits: [Int] {
        let characterSet = CharacterSet(charactersIn: "-0123456789")
        return components(separatedBy: characterSet.inverted).filter { !$0.isEmpty }.compactMap { Int($0) }
    }
    
    func bifurcate(on: String) -> (String, String) {
        let components = split(separator: on)
        guard components.count == 2 else {
            fatalError("Failed to bifurcate \(self) on \(on). Got \(components)")
        }
        return (String(components[0]), String(components[1]))
    }
}

extension Collection where Index == Int {
    subscript(wrapped wrapped: Index) -> Element {
        self[wrapped % count]
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        guard index < endIndex && index >= startIndex else { return nil }
        return self[index]
    }
}

extension Collection where Element == Int {
    var sum: Int {
        self.reduce(0, +)
    }
    
    var leastCommonMultiple: Int {
        reduce(1, leastCommonMultiple(_:_:))
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}

extension ArraySlice {
    subscript(n n: Int) -> Element {
        self[index(startIndex, offsetBy: n)]
    }
}
