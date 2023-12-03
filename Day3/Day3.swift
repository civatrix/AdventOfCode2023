//
//  Day3.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day3: Day {
    struct Part {
        var id = -1
        var adjacent = Set<Point>()
    }
    
    func run(input: String) -> String {
        let characters = input.lines.map { $0.map { $0 } }
        
        var parts = [Part]()
        var currentPart: Part?
        for (y, row) in characters.enumerated() {
            for (x, char) in row.enumerated() {
                guard let digit = char.wholeNumberValue else {
                    if var part = currentPart {
                        part.adjacent.insert([x, y])
                        part.adjacent.insert([x, y - 1])
                        part.adjacent.insert([x, y + 1])
                        parts.append(part)
                        currentPart = nil
                    }
                    continue
                }
                
                if let part = currentPart {
                    currentPart?.id = part.id * 10 + digit
                } else {
                    currentPart = Part(id: digit, adjacent: [[x - 1, y], [x - 1, y - 1], [x - 1, y + 1]])
                }
                
                currentPart?.adjacent.insert([x, y + 1])
                currentPart?.adjacent.insert([x, y - 1])
            }
            
            if let part = currentPart {
                parts.append(part)
                currentPart = nil
            }
        }
        
        return parts
            .filter { part in
                part.adjacent.contains { point in
                    let value = point.value(in: characters)
                    return value != nil && value != "."
                }
            }
            .map { $0.id }
            .sum
            .description
    }
}
