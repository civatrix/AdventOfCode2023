//
//  Day16.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day16: Day {
    class Beam: Hashable {
        static func == (lhs: Day16.Beam, rhs: Day16.Beam) -> Bool {
            lhs.location == rhs.location && lhs.direction == rhs.direction
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(location)
            hasher.combine(direction)
        }
        
        init(location: Point, direction: Point) {
            self.location = location
            self.direction = direction
        }
        
        var location: Point
        var direction: Point
        
        func copy() -> Beam {
            return Beam(location: location, direction: direction)
        }
        
        func moveToNextMirror(in mirrors: [Point: Character], maxX: Int, maxY: Int) -> Character? {
            let points = mirrors.keys
            switch direction {
            case .right:
                location = [points.filter { $0.y == location.y && $0.x > location.x }.min()?.x ?? maxX, location.y]
            case .left:
                location = [points.filter { $0.y == location.y && $0.x < location.x }.max()?.x ?? -1, location.y]
            case .up:
                location = [location.x, points.filter { $0.x == location.x && $0.y < location.y }.max()?.y ?? -1]
            case .down:
                location = [location.x, points.filter { $0.x == location.x && $0.y > location.y }.min()?.y ?? maxY]
            default:
                fatalError("Unsupported direction")
            }
            
            return mirrors[location]
        }
    }
    
    func run(input: String) -> String {
        let lines = input.lines
        var mirrors = [Point: Character]()
        for (y, line) in lines.enumerated() {
            for (x, cell) in line.enumerated() where cell != "." {
                mirrors[[x, y]] = cell
            }
        }
        
        let maxX = lines[0].count
        let maxY = lines.count
        
        var beams = [Beam(location: .zero - .right, direction: .right)]
        var energized = Set<Beam>()
        var previousEnergized = -1
        while energized.count != previousEnergized {
            previousEnergized = energized.count
            let existingBeams = beams
            for beam in existingBeams {
                let startingBeam = beam.copy()
                if let mirror = beam.moveToNextMirror(in: mirrors, maxX: maxX, maxY: maxY) {
                    switch mirror {
                    case "/":
                        switch beam.direction {
                        case .right:
                            beam.direction = .up
                        case .left:
                            beam.direction = .down
                        case .up:
                            beam.direction = .right
                        case .down:
                            beam.direction = .left
                        default:
                            fatalError("Unsupported rotation")
                        }
                    case "\\":
                        switch beam.direction {
                        case .right:
                            beam.direction = .down
                        case .left:
                            beam.direction = .up
                        case .up:
                            beam.direction = .left
                        case .down:
                            beam.direction = .right
                        default:
                            fatalError("Unsupported rotation")
                        }
                    case "|":
                        if beam.direction == .right || beam.direction == .left {
                            beam.direction = .up
                            let newBeam = Beam(location: beam.location, direction: .down)
                            if !energized.contains(newBeam) {
                                beams.append(newBeam)
                            }
                        }
                    case "-":
                        if beam.direction == .up || beam.direction == .down {
                            beam.direction = .left
                            let newBeam = Beam(location: beam.location, direction: .right)
                            if !energized.contains(newBeam) {
                                beams.append(newBeam)
                            }
                        }
                    default:
                        fatalError("Invalid mirror \(mirror) at \(beam.location)")
                    }
                    
                    if energized.contains(beam) {
                        beams.remove(at: beams.firstIndex(of: beam)!)
                    }
                } else {
                    beams.remove(at: beams.firstIndex(of: beam)!)
                }
                
                while startingBeam.location != beam.location {
                    energized.insert(startingBeam.copy())
                    startingBeam.location += startingBeam.direction
                }
            }
        }
        
        energized.remove(Beam(location: .zero - .right, direction: .right))
        return Set(energized.map { $0.location }).count.description
    }
}
