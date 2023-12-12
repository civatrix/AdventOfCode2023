//
//  Day12.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day12: Day {
    func run(input: String) -> String {
        return input.lines.map { line -> Int in
            let guide = line.allDigits
            let map = line.split(separator: " ")[0]
            
            return permutations(of: String(map), matching: guide, startingFrom: map.startIndex)
        }
        .sum
        .description
    }
    
    func permutations(of map: String, matching guide: [Int], startingFrom: String.Index) -> Int {
        guard matches(map, guide: guide) else {
            return 0
        }
        
        guard let index = map[startingFrom...].firstIndex(of: "?") else { return 1 }
        let nextIndex = map.index(after: index)
            
        var total = 0
        total += permutations(of: map.replacingCharacters(in: index ..< nextIndex, with: "#"), matching: guide, startingFrom: nextIndex)
        total += permutations(of: map.replacingCharacters(in: index ..< nextIndex, with: "."), matching: guide, startingFrom: nextIndex)
        
        return total
    }
    
    func matches(_ map: String, guide: [Int]) -> Bool {
        var currentGuide = 0
        var length = 0
        for character in map.trimmingCharacters(in: CharacterSet(charactersIn: ".")).appending(".") {
            if character == "?" {
                if length <= guide[safe: currentGuide] ?? 0 {
                    return true
                } else {
                    return false
                }
            } else if character == "#" {
                length += 1
            } else if length > 0 {
                if length == guide[safe: currentGuide] ?? 0 {
                    currentGuide += 1
                    length = 0
                } else {
                    return false
                }
            }
        }
        
        return currentGuide == guide.count
    }
}
