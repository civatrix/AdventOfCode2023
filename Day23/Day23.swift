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
        var slopes = [Point: Point]()
        var start = Point.zero
        var end = Point.zero
        for (y, line) in lines.enumerated() {
            for (x, cell) in line.enumerated() {
                switch cell {
                case "#":
                    walls.insert([x, y])
                case "<":
                    slopes[[x, y]] = .left
                case ">":
                    slopes[[x, y]] = .right
                case "v":
                    slopes[[x, y]] = .down
                case "^":
                    slopes[[x, y]] = .up
                default:
                    if y == 0 {
                        walls.insert([x, y])
                        start = [x, y + 1]
                    } else if y == lines.count - 1 {
                        end = [x, y]
                        walls.insert([x, y + 1])
                    }
                }
            }
        }
        
        let aStar = LongAStar(graph: SlopeGridGraph(walls: walls, slopes: slopes), heuristic: { _, _ in 0 })
        let path = aStar.path(start: SlopeGridGraph.DirectedPoint(position: start, direction: .down), target:  SlopeGridGraph.DirectedPoint(position: end, direction: .down))
        
        return path.count.description
    }
    
    struct SlopeGridGraph: Graph {
        struct DirectedPoint: Hashable {
            static func == (lhs: DirectedPoint, rhs: DirectedPoint) -> Bool {
                lhs.position == rhs.position
            }
            
            let position: Point
            let direction: Point
            
            func hash(into hasher: inout Hasher) {
                hasher.combine(position)
            }
        }
        
        struct Edge: WeightedEdge {
            let cost = 1
            let target: DirectedPoint
        }
        
        let walls: Set<Point>
        let slopes: [Point: Point]
        
        func edgesOutgoing(from vertex: DirectedPoint) -> [Edge] {
            if let slope = slopes[vertex.position] {
                if (slope * -1) != vertex.direction {
                    return [Edge(target: DirectedPoint(position: vertex.position + slope, direction: slope))]
                } else {
                    return []
                }
            }
            
            return Point.adjacentDirections
                .filter { ($0 * -1) != vertex.direction }
                .filter { !walls.contains(vertex.position + $0) && (slopes[vertex.position + $0, default: .zero] * -1) != $0 }
                .map { Edge(target: DirectedPoint(position: vertex.position + $0, direction: $0)) }
        }
    }
    
    class LongAStar<G: Graph> {
        /// The graph to search on.
        public let graph: G
        
        /// The heuristic cost function that estimates the cost between two vertices.
        ///
        /// - Note: The heuristic function needs to always return a value that is lower-than or equal to the actual
        ///         cost for the resulting path of the A* search to be optimal.
        public let heuristic: (G.Vertex, G.Vertex) -> Int
        
        /// Open list of nodes to expand.
        private var open: HashedHeap<Node<G.Vertex>>
        
        /// Closed list of vertices already expanded.
        private var closed = Set<G.Vertex>()
        
        /// Actual vertex cost for vertices we already encountered (referred to as `g` on the literature).
        private var costs = Dictionary<G.Vertex, Int>()
        
        /// Store the previous node for each expanded node to recreate the path.
        private var parents = Dictionary<G.Vertex, G.Vertex>()
        
        /// Initializes `AStar` with a graph and a heuristic cost function.
        public init(graph: G, heuristic: @escaping (G.Vertex, G.Vertex) -> Int) {
            self.graph = graph
            self.heuristic = heuristic
            open = HashedHeap(sort: <)
        }
        
        /// Finds an optimal path between `source` and `target`.
        ///
        /// - Precondition: both `source` and `target` belong to `graph`.
        public func path(start: G.Vertex, target: G.Vertex) -> [G.Vertex] {
            open.insert(Node<G.Vertex>(vertex: start, cost: 0, estimate: heuristic(start, target)))
            while let node = open.remove() {
                costs[node.vertex] = node.cost
                
                if !closed.contains(node.vertex) {
                    expand(node: node, target: target)
                    closed.insert(node.vertex)
                }
            }
            
            let path = buildPath(start: start, target: target)
            cleanup()
            return path
        }
        
        private func expand(node: Node<G.Vertex>, target: G.Vertex) {
            let edges = graph.edgesOutgoing(from: node.vertex)
            for edge in edges {
                let g = cost(node.vertex) + edge.cost
                if g > cost(edge.target) {
                    open.insert(Node<G.Vertex>(vertex: edge.target, cost: g, estimate: heuristic(edge.target, target)))
                    parents[edge.target] = node.vertex
                }
            }
        }
        
        private func cost(_ vertex: G.Edge.Vertex) -> Int {
            if let c = costs[vertex] {
                return c
            }
            
            let node = Node(vertex: vertex, cost: .min, estimate: 1000)
            if let index = open.index(of: node) {
                return open[index].cost
            }
            
            return .min
        }
        
        private func buildPath(start: G.Vertex, target: G.Vertex) -> [G.Vertex] {
            var path = Array<G.Vertex>()
            path.append(target)
            
            var current = target
            while current != start {
                guard let parent = parents[current] else {
                    return [] // no path found
                }
                current = parent
                path.append(current)
            }
            
            return path.reversed()
        }
        
        private func cleanup() {
            open.removeAll()
            closed.removeAll()
            parents.removeAll()
            costs.removeAll()
        }
    }
}
