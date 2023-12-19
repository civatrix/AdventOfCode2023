//
//  Day19.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day19: Day {
    struct Part: Hashable {
        var x, m, a, s: ClosedRange<Int>
        
        var total: Int {
            x.count * m.count * a.count * s.count
        }
        
        func split(on: WritableKeyPath<Part, ClosedRange<Int>>?, at: Int?, isLessThan: Bool) -> [Part] {
            guard let on, let at else { return [self] }
            
            let range = self[keyPath: on]
            if range.contains(at) {
                let lowerRange = range.lowerBound ... (isLessThan ? at - 1 : at)
                let upperRange = (isLessThan ? at : at + 1) ... range.upperBound
                
                var lower = Part(x: x, m: m, a: a, s: s)
                lower[keyPath: on] = lowerRange
                var upper = Part(x: x, m: m, a: a, s: s)
                upper[keyPath: on] = upperRange
                
                return isLessThan ? [lower, upper] : [upper, lower]
            } else {
                return [self]
            }
        }
    }
    
    struct Rule {
        let quality: WritableKeyPath<Part, ClosedRange<Int>>?
        let isLessThan: Bool
        let comparisonValue: Int?
        let output: String
        
        init(_ string: Substring) {
            if let match = string.wholeMatch(of: /([xmas])([<>])(\d+):(.+)/)?.output {
                quality = switch match.1 {
                case "x": \.x
                case "m": \.m
                case "a": \.a
                case "s": \.s
                default: fatalError("Unknown quality \(match.1)")
                }
                
                isLessThan = match.2 == "<"
                
                comparisonValue = Int(match.3)!
                output = String(match.4)
            } else {
                quality = nil
                isLessThan = false
                comparisonValue = nil
                output = String(string)
            }
        }
        
        func applies(to part: Part) -> Bool {
            guard let quality, let comparisonValue else {
                return true
            }
            
            let range = part[keyPath: quality]
            if range.contains(comparisonValue) {
                return true
            } else if isLessThan && range.upperBound < comparisonValue {
                return true
            } else if !isLessThan && range.lowerBound > comparisonValue {
                return true
            } else {
                return false
            }
        }
    }
    
    func run(input: String) -> String {
        let rulesString = input.split(separator: "\n\n")[0]
        var workflows = [String: [Rule]]()
        for line in rulesString.lines {
            let (name, rest) = line.bifurcate(on: "{")
            workflows[name] = rest.dropLast().split(separator: ",").map { Rule($0) }
        }
        var tracker: [String: Set<Part>] = ["in": [Part(x: 1 ... 4000, m: 1 ... 4000, a: 1 ... 4000, s: 1 ... 4000)]]
        
        var accepted = [Part]()
        while let (key, parts) = tracker.first {
            tracker.removeValue(forKey: key)
            
            var workingParts = parts
            for rule in workflows[key]! {
                let affectedParts = workingParts.filter { rule.applies(to: $0) }
                workingParts.subtract(affectedParts)
                
                for part in affectedParts {
                    let newParts = part.split(on: rule.quality, at: rule.comparisonValue, isLessThan: rule.isLessThan)
                    if rule.output == "A" {
                        accepted.append(newParts[0])
                    } else if rule.output != "R" {
                        tracker[rule.output, default: []].insert(newParts[0])
                    }
                    
                    if let otherPart = newParts[safe: 1] {
                        workingParts.insert(otherPart)
                    }
                }
            }
        }
        
        return accepted.map { $0.total }.sum.description
    }
}
