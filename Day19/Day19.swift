//
//  Day19.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day19: Day {
    struct Part {
        let x, m, a, s: Int
        
        var total: Int {
            x + m + a + s
        }
    }
    
    struct Rule {
        let quality: KeyPath<Part, Int>?
        let condition: ((Int, Int) -> Bool)?
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
                
                condition = switch match.2 {
                case "<": (<)
                case ">": (>)
                default: fatalError("Unknown comparator \(match.2)")
                }
                
                comparisonValue = Int(match.3)!
                output = String(match.4)
            } else {
                quality = nil
                condition = nil
                comparisonValue = nil
                output = String(string)
            }
        }
        
        func isSatisfied(by part: Part) -> Bool {
            guard let quality, let condition, let comparisonValue else {
                return true
            }
            
            return condition(part[keyPath: quality], comparisonValue)
        }
    }
    
    func run(input: String) -> String {
        let (rulesString, partsString) = input.bifurcate(on: "\n\n")
        var workflows = [String: [Rule]]()
        for line in rulesString.lines {
            let (name, rest) = line.bifurcate(on: "{")
            workflows[name] = rest.dropLast().split(separator: ",").map { Rule($0) }
        }
        
        let parts = partsString.lines.map { $0.allDigits }
            .map { Part(x: $0[0], m: $0[1], a: $0[2], s: $0[3]) }
        
        var accepted = [Part]()
        parts.forEach { part in
            var next = "in"
            while next != "A" {
                if next == "R" {
                    return
                }
                
                next = workflows[next]!.first { $0.isSatisfied(by: part) }!.output
            }
            accepted.append(part)
        }
        
        return accepted.map { $0.total }.sum.description
    }
}
