//
//  Day10.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day10: Day {
    class Pipe: Hashable {
        func hash(into hasher: inout Hasher) {
            hasher.combine(position)
        }
        
        static func == (lhs: Day10.Pipe, rhs: Day10.Pipe) -> Bool {
            lhs.position == rhs.position
        }
        
        init(position: Point, directions: [Point], adjacent: [Day10.Pipe] = []) {
            self.position = position
            self.directions = directions
            self.adjacent = adjacent
        }
        
        let position: Point
        let directions: [Point]
        var adjacent: [Pipe] = []
    }
    
    func run(input: String) -> String {
        var pipes = Set<Pipe>()
        
        var start: Pipe!
        for (y, line) in input.lines.enumerated() {
            for (x, char) in line.enumerated() {
                let position = Point(x: x, y: y)
                switch char {
                case "|":
                    pipes.insert(Pipe(position: position, directions: [.up, .down]))
                case "-":
                    pipes.insert(Pipe(position: position, directions: [.left, .right]))
                case "L":
                    pipes.insert(Pipe(position: position, directions: [.up, .right]))
                case "J":
                    pipes.insert(Pipe(position: position, directions: [.up, .left]))
                case "7":
                    pipes.insert(Pipe(position: position, directions: [.left, .down]))
                case "F":
                    pipes.insert(Pipe(position: position, directions: [.right, .down]))
                case ".":
                    break // No pipe
                case "S":
                    start = Pipe(position: position, directions: [])
                    pipes.insert(start)
                default:
                    break
//                    fatalError("Invalid pipe \(char)")
                }
            }
        }
        
        for pipe in pipes {
            pipe.adjacent = pipe.directions
                .map { pipe.position + $0 }
                .compactMap { position in pipes.first { $0.position == position } }
        }
        
        start.adjacent = pipes.filter { $0.adjacent.contains(start) }
        
        var position = start!
        var previous = position
        var route = Set<Point>()
        repeat {
            route.insert(position.position)
            let newPosition = position.adjacent.filter { $0 != previous }.first!
            previous = position
            position = newPosition
        } while position != start
        
        let xRange = route.map { $0.x }.minAndMax()!
        let yRange = route.map { $0.y }.minAndMax()!
                
        var count = 0
        for y in yRange.min + 1 ... yRange.max - 1 {
            for x in xRange.min + 1 ... xRange.max - 1 {
                guard !route.contains([x, y]) else { continue }
                
                let hits = (1 ... min(xRange.max - x, yRange.max - y)).filter { offset in
                    let coord = Point(x: x + offset, y: y + offset)
                    let pipe = pipes.first { $0.position == coord }
                    return route.contains(coord) && pipe!.directions != [.left, .down] && pipe!.directions != [.up, .right]
                }.count
                
                if !hits.isMultiple(of: 2) {
                    count += 1
                }
            }
        }
        
        return count.description
    }
}
