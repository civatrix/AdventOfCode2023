//
//  Day8.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day8: Day {
    let regex = /(...) = \((...), (...)\)/
    
    func run(input: String) -> String {
        var lines = input.lines
        let key = lines.removeFirst()
        
        var maps = [Substring: (Substring, Substring)]()
        for line in lines {
            let match = line.wholeMatch(of: regex)!.output
            maps[match.1] = (match.2, match.3)
        }
        
        var keyIndex = key.startIndex
        var currentNode: Substring = "AAA"
        var steps = 0
        while currentNode != "ZZZ" {
            let left = key[keyIndex] == "L"
            currentNode = left ? maps[currentNode]!.0 : maps[currentNode]!.1
            keyIndex = key.index(after: keyIndex)
            if keyIndex == key.endIndex {
                keyIndex = key.startIndex
            }
            steps += 1
        }
        
        return steps.description
    }
}
