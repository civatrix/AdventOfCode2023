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
        
        let seeds = maps.keys.filter { $0.last == "A" }
        
        return seeds.map { steps(from: $0, key: key, maps: maps) }
            .leastCommonMultiple
            .description
    }
    
    func steps(from: Substring, key: String, maps: [Substring: (Substring, Substring)]) -> Int {
        var keyIndex = key.startIndex
        var currentNode: Substring = from
        var steps = 0
        while currentNode.last != "Z" {
            let left = key[keyIndex] == "L"
            currentNode = left ? maps[currentNode]!.0 : maps[currentNode]!.1
            keyIndex = key.index(after: keyIndex)
            if keyIndex == key.endIndex {
                keyIndex = key.startIndex
            }
            steps += 1
        }
        
        return steps
    }
}
