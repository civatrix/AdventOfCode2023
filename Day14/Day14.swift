//
//  Day14.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day14: Day {
    class Rock: Hashable, Comparable {
        func hash(into hasher: inout Hasher) {
            hasher.combine(location)
        }
        
        static func < (lhs: Day14.Rock, rhs: Day14.Rock) -> Bool {
            lhs.location < rhs.location
        }
        
        static func == (lhs: Day14.Rock, rhs: Day14.Rock) -> Bool {
            lhs.location == rhs.location
        }
        
        init(location: Point) {
            self.location = location
        }
        
        var location: Point
    }
    
    func run(input: String) -> String {
        let lines = input.lines
        var rocks = Set<Rock>()
        var roundRocks = Set<Rock>()
        for (y, line) in lines.enumerated() {
            for (x, cell) in line.enumerated() {
                if cell == "#" {
                    rocks.insert(Rock(location: [x, y]))
                } else if cell == "O" {
                    let rock = Rock(location: [x, y])
                    rocks.insert(rock)
                    roundRocks.insert(rock)
                }
            }
        }
        
        let southBoundary = lines.count
        let eastBoundary = lines[0].count
        
        var cache = [Set<Point>: Int]()
        var index = 0
        let target = 1_000_000_000
        while index < target {
            // North
            for rock in roundRocks.sorted() {
                let newY = rocks.filter { $0.location.x == rock.location.x && $0.location.y < rock.location.y }.map { $0.location.y }.max() ?? -1
                rock.location = [rock.location.x, newY + 1]
            }
            
            // West
            for rock in roundRocks.sorted() {
                let newX = rocks.filter { $0.location.y == rock.location.y && $0.location.x < rock.location.x }.map { $0.location.x }.max() ?? -1
                rock.location = [newX + 1, rock.location.y]
            }
            
            // South
            for rock in roundRocks.sorted().reversed() {
                let newY = rocks.filter { $0.location.x == rock.location.x && $0.location.y > rock.location.y }.map { $0.location.y }.min() ?? southBoundary
                rock.location = [rock.location.x, newY - 1]
            }
            
            // East
            for rock in roundRocks.sorted().reversed() {
                let newX = rocks.filter { $0.location.y == rock.location.y && $0.location.x > rock.location.x }.map { $0.location.x }.min() ?? eastBoundary
                rock.location = [newX - 1, rock.location.y]
            }
            
            let positions = Set(roundRocks.map { $0.location })
            if let match = cache[positions] {
                let cycle = index - match
                index = target - ((target - match) % cycle)
                cache = [:]
            } else {
                cache[positions] = index
            }
            index += 1
        }
        
        let southEdge = lines.count
        return roundRocks.map { southEdge - $0.location.y }.sum.description
    }
}
