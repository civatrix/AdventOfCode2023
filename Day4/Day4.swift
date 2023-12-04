//
//  Day4.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day4: Day {
    func run(input: String) -> String {
        let numbers = input.lines.map { $0.split(separator: ":")[1].split(separator: "|") }
        
        return numbers.map {
            let lhs = Set($0[0].allDigits)
            let rhs = Set($0[1].allDigits)
            
            let matches = lhs.intersection(rhs).count
            if matches > 0 {
                return 1 << (lhs.intersection(rhs).count - 1)
            } else {
                return 0
            }
        }
        .sum
        .description
    }
}
