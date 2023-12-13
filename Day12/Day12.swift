//
//  Day12.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day12: Day {
    struct Key: Hashable {
        let mapIndex: String.Index
        let guideIndex: Int
        let blockSize: Int
    }
    
    var cache = [Key: Int]()
    func run(input: String) -> String {
        return input.lines.map { line -> Int in
            let guide = line.allDigits
            let map = line.split(separator: " ")[0].appending("?")
            
            let finalGuide = guide + guide + guide + guide + guide
            let finalMap = (map + map + map + map + map).dropLast(1).appending(".")
            
            cache = [:]
            return permutations(of: finalMap, matching: finalGuide, startingFrom: map.startIndex, inBlock: 0, withSize: 0)
        }
        .sum
        .description
    }
    
    func permutations(of map: String, matching guide: [Int], startingFrom: String.Index, inBlock: Int, withSize: Int) -> Int {
        let key = Key(mapIndex: startingFrom, guideIndex: inBlock, blockSize: withSize)
        if let cacheHit = cache[key] {
            return cacheHit
        }
                    
        guard startingFrom != map.endIndex else {
            return inBlock == guide.count ? 1 : 0
        }
        
        let nextIndex = map.index(after: startingFrom)
        var total = 0
        func handleHit() {
            if withSize <= guide[safe: inBlock] ?? -1 {
                total += permutations(of: map, matching: guide, startingFrom: nextIndex, inBlock: inBlock, withSize: withSize + 1)
            }
        }
        
        func handleMiss() {
            if withSize > 0 {
                if withSize == guide[safe: inBlock] ?? -1 {
                    total += permutations(of: map, matching: guide, startingFrom: nextIndex, inBlock: inBlock + 1, withSize: 0)
                }
            } else {
                total += permutations(of: map, matching: guide, startingFrom: nextIndex, inBlock: inBlock, withSize: withSize)
            }
        }
        
        switch map[startingFrom] {
        case "?":
            handleHit()
            handleMiss()
        case ".":
            handleMiss()
        case "#":
            handleHit()
        default:
            fatalError("Unknown character \(map[startingFrom]) in \(map)")
        }
        
        cache[key] = total
        return total
    }
}
