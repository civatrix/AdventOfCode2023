//
//  Day9.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day9: Day {
    func run(input: String) -> String {
        let reports = input.lines.map { [$0.allDigits] }
        
        var newValues = [Int]()
        for var report in reports {
            while !report.last!.allSatisfy({ $0 == 0 }) {
                report.append(report.last!.adjacentPairs().map { $0.1 - $0.0 })
            }
            
            report[report.endIndex - 1].insert(0, at: 0)
            for index in report.indices.reversed().dropFirst() {
                report[index].insert(report[index].first! - report[index + 1].first!, at: 0)
            }
            
            newValues.append(report[0].first!)
        }
        
        return newValues.sum.description
    }
}
