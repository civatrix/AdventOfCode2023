//
//  Day18.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day18: Day {
    func run(input: String) -> String {
        var current = Point.zero
        var corners = [current]
        var perimeter = 0
        
        input.lines
            .forEach { line in
                let hex = line.split(separator: "#").last!.dropLast()
                let directionString = hex.last!
                let direction: Point = switch directionString {
                case "0": .right
                case "2": .left
                case "3": .up
                case "1": .down
                default:
                    fatalError("Invalid direction \(directionString)")
                }
                
                let distance = Int(hex.prefix(5), radix: 16)!
                perimeter += distance
                current += (direction * distance)
                corners.append(current)
            }
        
        var area = 0
        for (p1, p2) in corners.adjacentPairs() {
            area += (p1.x - p2.x) * (p1.y + p2.y)
        }
        area /= 2
        
        let interior = area + 1 - (perimeter / 2)
        
        return (perimeter + interior).description
    }
}
