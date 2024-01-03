//
//  Day23.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day23: Day {
    func run(input: String) -> String {
        let lines = input.lines
        var walls = Set<Point>()
        var start = Point.zero
        var end = Point.zero
        for (y, line) in lines.enumerated() {
            for (x, cell) in line.enumerated() {
                switch cell {
                case "#":
                    walls.insert([x, y])
                default:
                    if y == 0 {
                        walls.insert([x, y])
                        start = [x, y]
                    } else if y == lines.count - 1 {
                        end = [x, y]
                        walls.insert([x, y + 1])
                    }
                }
            }
        }
        
        let edges = buildEdges(start: start, end: end, walls: walls)
        
        assert(edges[start]?.count == 1)
        let firstEdge = edges[start]![0]
        var openNodes = [Node(position: firstEdge, seen: [start], cost: firstEdge.cost)].prefix(1)
        var maxNode = openNodes.first!
        while let node = openNodes.popFirst() {
            if node.position.end == end {
                if node.cost > maxNode.cost {
                    maxNode = node
                }
                continue
            }
            
            let newSeen = node.seen.union([node.position.end])
            for nextEdge in edges[node.position.end, default: []] where !node.seen.contains(nextEdge.end) {
                openNodes.append(Node(position: nextEdge, seen: newSeen, cost: node.cost + nextEdge.cost))
            }
        }
        
        return maxNode.cost.description
    }
    
    func buildEdges(start: Point, end: Point, walls: Set<Point>) -> [Point: [Edge]] {
        var edges = [Point: [Edge]]()
        var seen: Set<Point> = []
        var intersections: Set<Point> = []
        var openNodes = [(current: start + .down, initial: start, cost: 0)].prefix(1)
        while let node = openNodes.popLast() {
            guard node.current != node.initial else { continue }
            let valid = node.current.adjacent.filter { !walls.contains($0) }
            let outward = valid.filter { !seen.contains($0) || intersections.contains($0) }
            
            if node.current == end {
                edges[node.initial, default: []].append(Edge(end: node.current, cost: node.cost + 1))
                edges[node.current, default: []].append(Edge(end: node.initial, cost: node.cost + 1))
            } else if valid.count > 2 && node.cost > 1 {
                edges[node.initial, default: []].append(Edge(end: node.current, cost: node.cost + 1))
                edges[node.current, default: []].append(Edge(end: node.initial, cost: node.cost + 1))
                
                if !intersections.contains(node.current) {
                    openNodes.append(contentsOf: outward.map { (current: $0, initial: node.current, cost: 0) })
                    intersections.insert(node.current)
                }
            } else {
                openNodes.append(contentsOf: outward.map { (current: $0, initial: node.initial, cost: node.cost + 1) })
                seen.insert(node.current)
            }
        }
        
        return edges
    }
    
    struct Edge: Hashable {
        let end: Point
        let cost: Int
    }
    
    struct Node: Hashable {
        static func == (lhs: Day23.Node, rhs: Day23.Node) -> Bool {
            lhs.position == rhs.position && lhs.seen == rhs.seen
        }
        
        let position: Edge
        let seen: Set<Point>
        let cost: Int
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(position)
            hasher.combine(seen)
        }
    }
}
