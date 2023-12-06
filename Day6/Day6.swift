//
//  Day6.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day6: Day {
    func run(input: String) -> String {
        let time = input.lines[0].replacingOccurrences(of: " ", with: "").allDigits[0]
        let distance = input.lines[1].replacingOccurrences(of: " ", with: "").allDigits[0]
        
        let solutions = solveQuadratic(a: 1, b: -time, c: distance)
        return (solutions.1 - solutions.0 + 1).description
    }
    
    func solveQuadratic(a: Int, b: Int, c: Int) -> (Int, Int) {
        let root = sqrt(Double((b * b) - (4 * a * c)))
        let solutions = [(Double(-b) + root) / (2 * Double(a)), (Double(-b) - root) / (2 * Double(a))].sorted()
        
        return (Int(ceil(solutions[0].nextUp)), Int(floor(solutions[1].nextDown)))
    }
}
