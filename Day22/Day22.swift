//
//  Day22.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day22: Day {
    struct Brick: Equatable, Comparable {
        static func < (lhs: Day22.Brick, rhs: Day22.Brick) -> Bool {
            lhs.end < rhs.end
        }
        
        let start, end: Point3D
        
        var xRange: ClosedRange<Int> {
            start.x ... end.x
        }
        
        var yRange: ClosedRange<Int> {
            start.y ... end.y
        }
        
        var zRange: ClosedRange<Int> {
            start.z ... end.z
        }
        
        func intersects(other: Brick) -> Bool {
            xRange.overlaps(other.xRange) && yRange.overlaps(other.yRange) && zRange.overlaps(other.zRange)
        }
    }
    
    func run(input: String) -> String {
        var bricks = input.lines.map { line in
            let numbers = line.allDigits
            return Brick(start: Point3D(x: numbers[0], y: numbers[1], z: numbers[2]), end: Point3D(x: numbers[3], y: numbers[4], z: numbers[5]))
        }
            .sorted()
        
        _ = settle(bricks: &bricks)
        
        var count = 0
        for index in bricks.indices {
            var newBricks = bricks
            newBricks.remove(at: index)
            count += settle(bricks: &newBricks)
        }
        
        return count.description
    }
    
    func settle(bricks: inout [Brick]) -> Int {
        var movedBricks = 0
        var newBricks = [Brick]()
        for brick in bricks {
            let newZ = newBricks.filter { brick.xRange.overlaps($0.xRange) && brick.yRange.overlaps($0.yRange) }.map { $0.zRange.upperBound }.max() ?? 0
            let newBrick = Brick(start: Point3D(x: brick.start.x, y: brick.start.y, z: newZ + 1), end: Point3D(x: brick.end.x, y: brick.end.y, z: newZ + brick.zRange.count))
            newBricks.append(newBrick)
            if brick != newBrick {
                movedBricks += 1
            }
        }
        
        bricks = newBricks
        return movedBricks
    }
}
