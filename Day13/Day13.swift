//
//  Day13.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day13: Day {
    func run(input: String) -> String {
        let patterns = input.split(separator: "\n\n").map { $0.parseGrid() }
        
        return patterns.map { grid -> Int in
            let maxX = grid.map { $0.x }.max()!
            let maxY = grid.map { $0.y }.max()!
            
            let rows = (0 ... maxY).map { y in Set(grid.filter { $0.y == y }.map { $0.x }) }
            for topIndex in 0 ..< maxY {
                let rowsToCheck = min(topIndex + 1, maxY - topIndex)
                if (0 ..< rowsToCheck).allSatisfy({ rows[topIndex - $0] == rows[topIndex + $0 + 1] }) {
                    return 100 * (topIndex + 1)
                }
            }
            
            let columns = (0 ... maxX).map { x in Set(grid.filter { $0.x == x }.map { $0.y }) }
            for leftIndex in 0 ..< maxX {
                let columnsToCheck = min(leftIndex + 1, maxX - leftIndex)
                if (0 ..< columnsToCheck).allSatisfy({ columns[leftIndex - $0] == columns[leftIndex + $0 + 1] }) {
                    return leftIndex + 1
                }
            }
            
            grid.printPoints()
            fatalError("No mirror found")
        }
        .sum
        .description
    }
}
