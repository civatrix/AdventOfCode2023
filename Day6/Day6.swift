//
//  Day6.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day6: Day {
    func run(input: String) -> String {
        let times = input.lines[0].allDigits
        let distances = input.lines[1].allDigits
        
        var result = 1
        for (time, distance) in zip(times,distances) {
            let solutions = solveQuadratic(a: 1, b: -time, c: distance)
            result *= solutions.1 - solutions.0 + 1
        }
        
        return result.description
    }
    
    func solveQuadratic(a: Int, b: Int, c: Int) -> (Int, Int) {
        let root = sqrt(Double((b * b) - (4 * a * c)))
        let solutions = [(Double(-b) + root) / (2 * Double(a)), (Double(-b) - root) / (2 * Double(a))].sorted()
        
        return (Int(ceil(solutions[0].nextUp)), Int(floor(solutions[1].nextDown)))
    }
}
