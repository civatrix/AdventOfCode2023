//
//  Point3D.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-12-17.
//

import Foundation

struct Point3D: Hashable, CustomStringConvertible, Comparable, Equatable, ExpressibleByArrayLiteral {
    let x, y, z: Int
    
    static let zero: Point3D = [0, 0, 0]
    static let left: Point3D = [-1, 0, 0]
    static let right: Point3D = [1, 0, 0]
    static let towards: Point3D = [0, -1, 0]
    static let away: Point3D = [0, 1, 0]
    static let down: Point3D = [0, 0, -1]
    static let up: Point3D = [0, 0, 1]
    
    static let adjacentDirections: [Point3D] = [.up, .left, .down, .right, .towards, .away]
    
    static func distance(between to: Point3D, and from: Point3D) -> Int {
        from.distance(to: to)
    }
    
    public static func < (lhs: Point3D, rhs: Point3D) -> Bool {
        if lhs.z != rhs.z {
            return lhs.z < rhs.z
        } else if lhs.y != rhs.y {
            return lhs.y < rhs.y
        } else {
            return lhs.x < rhs.x
        }
    }
    
    public static func += (left: inout Point3D, right: Point3D) {
        left = left + right
    }
    
    public static func + (left: Point3D, right: Point3D) -> Point3D {
        Point3D(x: left.x + right.x, y: left.y + right.y, z: left.z + right.z)
    }
    
    public static func -= (left: inout Point3D, right: Point3D) {
        left = left - right
    }
    public static func - (left: Point3D, right: Point3D) -> Point3D {
        Point3D(x: left.x - right.x, y: left.y - right.y, z: left.z - right.z)
    }
    
    public static func *= (left: inout Point3D, right: Int) {
        left = left * right
    }
    
    public static func * (left: Point3D, right: Int) -> Point3D {
        Point3D(x: left.x * right, y: left.y * right, z: left.z * right)
    }
    
    init(x: Int, y: Int, z: Int) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    init(arrayLiteral elements: Int...) {
        self = Point3D(x: elements[0], y: elements[1], z: elements[2])
    }
    
    public var description: String {
        "(x: \(x), y: \(y), z: \(z))"
    }
    
    var adjacent: [Point3D] {
        Point3D.adjacentDirections.map { $0 + self }
    }
    
    var normalized: Point3D {
        Point3D(x: x.clamped(to: -1 ... 1), y: y.clamped(to: -1 ... 1), z: z.clamped(to: -1 ... 1))
    }
    
    func value<T>(in array: [[[T]]]) -> T? {
        guard y < array.endIndex && y >= array.startIndex else { return nil }
        guard x < array[y].endIndex && x >= array[y].startIndex else { return nil }
        guard z < array[y][x].endIndex && z >= array[y][x].startIndex else { return nil }
        return array[y][x][z]
    }
    
    func set<T>(value: T, in array: inout [[[T]]]) {
        array[y][x][z] = value
    }
    
    func distance(to: Point3D) -> Int {
        abs(x - to.x) + abs(y - to.y) + abs(z - to.z)
    }
}

struct Grid3DGraph: Graph {
    struct Edge: WeightedEdge {
        let cost = 1
        let target: Point3D
    }
    
    let walls: Set<Point3D>
    
    func edgesOutgoing(from vertex: Point3D) -> [Edge] {
        return vertex.adjacent
            .filter { !walls.contains($0) }
            .map { Edge(target: $0) }
    }
}
