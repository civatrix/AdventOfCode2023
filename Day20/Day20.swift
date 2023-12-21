//
//  Day20.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

protocol Module {
    var name: String { get }
    var destinations: [String] { get }
    
    mutating func apply(pulse: Pulse) -> [Pulse]
    mutating func add(input: String)
}

struct Pulse {
    enum State {
        case high, low
    }
    
    let source: String
    let destination: String
    let state: State
}

final class Day20: Day {
    struct FlipFlop: Module {
        let name: String
        let destinations: [String]
        var currentState = Pulse.State.low
        
        mutating func apply(pulse: Pulse) -> [Pulse] {
            guard pulse.state == .low else { return [] }
            switch currentState {
            case .high:
                currentState = .low
            case .low:
                currentState = .high
            }
            
            return destinations.map { Pulse(source: name, destination: $0, state: currentState) }
        }
        
        mutating func add(input: String) {
            
        }
    }
    
    struct Conjunction: Module {
        let name: String
        let destinations: [String]
        var memory = [String: Pulse.State]()
        
        mutating func apply(pulse: Pulse) -> [Pulse] {
            memory[pulse.source] = pulse.state
            if memory.values.allSatisfy({ $0 == .high }) {
                return destinations.map { Pulse(source: name, destination: $0, state: .low) }
            } else {
                return destinations.map { Pulse(source: name, destination: $0, state: .high) }
            }
        }
        
        mutating func add(input: String) {
            memory[input] = .low
        }
    }
    
    func run(input: String) -> String {
        var broadcastPulses = [Pulse]()
        var modules = [String: Module]()
        for line in input.lines {
            if line.hasPrefix("%") {
                let moduleParts = line.dropFirst().bifurcate(on: " -> ")
                modules[moduleParts.0] = FlipFlop(name: moduleParts.0, destinations: moduleParts.1.split(separator: ", ").map { String($0) })
            } else if line.hasPrefix("&") {
                let moduleParts = line.dropFirst().bifurcate(on: " -> ")
                modules[moduleParts.0] = Conjunction(name: moduleParts.0, destinations: moduleParts.1.split(separator: ", ").map { String($0) })
            } else {
                broadcastPulses = line.bifurcate(on: " -> ").1.split(separator: ", ").map { Pulse(source: "broadcast", destination: String($0), state: .low) }
            }
        }
        
        for module in Array(modules.values) {
            for destination in module.destinations {
                modules[destination]?.add(input: module.name)
            }
        }
        
        let targets: Set<String> = ["ln", "zx", "vn", "dr"]
        var multiples = [Int]()
        for buttonPress in 1 ..< .max {
            var pulses = ArraySlice(broadcastPulses)
            while let pulse = pulses.popFirst() {
                if targets.contains(pulse.destination) && pulse.state == .low {
                    multiples.append(buttonPress)
                    
                    if multiples.count == targets.count {
                        return multiples.leastCommonMultiple.description
                    }
                }
                guard var module = modules[pulse.destination] else { continue }
                pulses.append(contentsOf: module.apply(pulse: pulse))
                modules[pulse.destination] = module
            }
        }
        
        return "Not found"
    }
}
