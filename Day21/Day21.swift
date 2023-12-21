//
//  Day21.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day21: Day {
    var numberOfSteps = 64
    
    func run(input: String) -> String {
        var rocks = Set<Point>()
        var start = Point.zero
        for (y, line) in input.lines.enumerated() {
            for (x, cell) in line.enumerated() {
                if cell == "#" {
                    rocks.insert([x, y])
                } else if cell == "S" {
                    start = [x, y]
                }
            }
        }
        
        var positions: Set<Point> = [start]
        for _ in 0 ..< numberOfSteps {
            positions = Set(positions.flatMap { $0.adjacent }.filter { !rocks.contains($0) })
        }
        
        return positions.count.description
    }
}
