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
        
        init(location: Point, type: Day14.Rock.Shape) {
            self.location = location
            self.type = type
        }
        
        enum Shape: Hashable {
            case square, round
        }
        
        var location: Point
        let type: Shape
    }
    
    func run(input: String) -> String {
        let lines = input.lines
        var rocks = Set<Rock>()
        for (y, line) in lines.enumerated() {
            for (x, cell) in line.enumerated() {
                if cell == "#" {
                    rocks.insert(Rock(location: [x, y], type: .square))
                } else if cell == "O" {
                    rocks.insert(Rock(location: [x, y], type: .round))
                }
            }
        }
        
        let southEdge = lines.count
        var totalLoad = 0
        for rock in rocks.sorted() where rock.type == .round {
            let newY = rocks.filter { $0.location.x == rock.location.x && $0.location.y < rock.location.y }.map { $0.location.y }.max() ?? -1
            rock.location = [rock.location.x, newY + 1]
            
            totalLoad += southEdge - (newY + 1)
        }
        
        return totalLoad.description
    }
}
