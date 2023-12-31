//
//  Day5.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day5: Day {
    struct Map {
        let from: String
        let to: String
        
        var fromRanges: [Range<Int>] = []
        var toRangeStarts: [Int] = []
        
        var description: String {
            var output = "\(from)-to-\(to) map:\n"
            for index in fromRanges.indices {
                output += "\(toRangeStarts[index]) \(fromRanges[index].lowerBound) \(fromRanges[index].count)\n"
            }
            
            return output
        }
        
        func destination(for input: Int) -> Int {
            guard let fromIndex = fromRanges.firstIndex(where: { $0.contains(input) }) else {
                return input
            }
            
            return toRangeStarts[fromIndex] + (input - fromRanges[fromIndex].lowerBound)
        }
    }
    
    func run(input: String) -> String {
        let lines = input.lines
        
        let seedRanges = [Range<Int>](lines[0].allDigits.chunks(ofCount: 2).map { $0[n: 0] ..< $0[n: 0] + $0[n: 1] })
        var maps = [String: Map]()
        var currentMap: Map?
        
        for line in lines where !line.isEmpty {
            if line.contains("map") {
                if let currentMap {
                    maps[currentMap.from] = currentMap
                }
                // X-to-Y map:
                let components = line.dropLast(5).split(separator: "-")
                currentMap = Map(from: String(components[0]), to: String(components[2]))
            } else {
                let digits = line.allDigits
                currentMap?.fromRanges.append(digits[1] ..< digits[1] + digits[2])
                currentMap?.toRangeStarts.append(digits[0])
            }
        }
        
        if let currentMap {
            maps[currentMap.from] = currentMap
        }
        
        return test(seedRanges: seedRanges, maps: maps).description
    }
    
    var locations = [Int]()
    let queue = OperationQueue()
    func test(seedRanges: [Range<Int>], maps: [String: Map]) -> Int {
        for seedRange in seedRanges {
            bestSeed(from: seedRange, maps: maps)
        }
        
        queue.waitUntilAllOperationsAreFinished()
        
        return locations.min()!
    }
    
    func bestSeed(from seeds: Range<Int>, maps: [String: Map]) {
        queue.addOperation {
            var bestLocation = Int.max
            for seed in seeds {
                var current = "seed"
                var value = seed
                while true {
                    let map = maps[current]!
                    current = map.to
                    value = map.destination(for: value)
                    
                    if current == "location" {
                        bestLocation = min(bestLocation, value)
                        break
                    }
                }
            }
            
            self.locations.append(bestLocation)
        }
    }
}
