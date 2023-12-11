//
//  Day11.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day11: Day {
    var expansionSize = 1_000_000
    
    func run(input: String) -> String {
        var stars = input.parseGrid()
        
        var xMax = stars.map { $0.x }.max()!
        var xIndex = 0
        while xIndex < xMax {
            guard stars.filter({ $0.x == xIndex }).count == 0 else {
                xIndex += 1
                continue
            }
            
            let toModify = stars.filter { $0.x > xIndex }
            stars.subtract(toModify)
            stars.formUnion(toModify.map { Point(x: $0.x + expansionSize - 1, y: $0.y) })
            xMax += expansionSize
            xIndex += expansionSize + 1
        }
        
        var yMax = stars.map { $0.y }.max()!
        var yIndex = 0
        while yIndex < yMax {
            guard stars.filter({ $0.y == yIndex }).count == 0 else {
                yIndex += 1
                continue
            }
            
            let toModify = stars.filter { $0.y > yIndex }
            stars.subtract(toModify)
            stars.formUnion(toModify.map { Point(x: $0.x, y: $0.y + expansionSize - 1) })
            yMax += expansionSize
            yIndex += expansionSize + 1
        }
        
        var sum = 0
        for startIndex in stars.indices {
            var endIndex = stars.index(after: startIndex)
            while endIndex != stars.endIndex {
                sum += stars[startIndex].distance(to: stars[endIndex])
                endIndex = stars.index(after: endIndex)
            }
        }
        
        return sum.description
    }
}
