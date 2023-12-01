//
//  Day1.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day1: Day {
    func run(input: String) -> String {
        let values = input.lines
            .map { $0.compactMap { $0.wholeNumberValue } }
            .map { Int("\($0.first!)\($0.last!)")! }
        values.forEach { print($0) }
        return values.sum
            .description
    }
}
