//
//  Day17.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day17: Day {
    struct HeatNode: Hashable {
        static func == (_ lhs: HeatNode, _ rhs: HeatNode) -> Bool {
            return lhs.position == rhs.position && lhs.direction == rhs.direction
        }
        
        let position: Point
        let direction: Point
        let totalCost: Int
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(position)
            hasher.combine(direction)
        }
    }
    
    func run(input: String) -> String {
        let grid = input.lines.map { line in
            line.map { $0.wholeNumberValue! }
        }
        let destination = Point(x: grid[0].count - 1, y: grid.count - 1)
        
        var heap = HashedHeap(array: [HeatNode(position: .zero, direction: .up, totalCost: 0), HeatNode(position: .zero, direction: .left, totalCost: 0)], sort: { $0.totalCost < $1.totalCost })
        var seen = [HeatNode: Int]()
        var best = Int.max
        while let current = heap.remove() {
            if current.position == destination {
                best = min(best, current.totalCost)
                continue
            }
            guard current.totalCost < best else { continue }
            
            for nextDirection in [current.direction.rotate(clockwise: true), current.direction.rotate(clockwise: false)] {
                for offset in (1 ... 3) {
                    let cost = (1 ... offset).compactMap { (current.position + (nextDirection * $0)).value(in: grid) }
                    guard cost.count == offset else { continue }
                    let nextNode = HeatNode(position: current.position + (nextDirection * offset), direction: nextDirection, totalCost: current.totalCost + cost.sum)
                    guard nextNode.totalCost < seen[nextNode, default: .max] else { continue }
                    seen[nextNode] = nextNode.totalCost
                    heap.insert(nextNode)
                }
            }
        }
        
        return best.description
    }
}
