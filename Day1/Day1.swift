//
//  Day1.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day1: Day {
    func run(input: String) -> String {
        return input.lines
            .map { digits(in: $0) }
            .map { Int("\($0.first!)\($0.last!)")! }
            .sum
            .description
    }
    
    func digits(in line: String) -> [Int] {
        var digits: [Int] = []
        for index in line.indices {
            if let number = line[index].wholeNumberValue {
                digits.append(number)
            } else if line.range(of: "one", range: index ..< line.endIndex)?.lowerBound == index {
                digits.append(1)
            } else if line.range(of: "two", range: index ..< line.endIndex)?.lowerBound == index {
                digits.append(2)
            } else if line.range(of: "three", range: index ..< line.endIndex)?.lowerBound == index {
                digits.append(3)
            } else if line.range(of: "four", range: index ..< line.endIndex)?.lowerBound == index {
                digits.append(4)
            } else if line.range(of: "five", range: index ..< line.endIndex)?.lowerBound == index {
                digits.append(5)
            } else if line.range(of: "six", range: index ..< line.endIndex)?.lowerBound == index {
                digits.append(6)
            } else if line.range(of: "seven", range: index ..< line.endIndex)?.lowerBound == index {
                digits.append(7)
            } else if line.range(of: "eight", range: index ..< line.endIndex)?.lowerBound == index {
                digits.append(8)
            } else if line.range(of: "nine", range: index ..< line.endIndex)?.lowerBound == index {
                digits.append(9)
            }
        }
        
        return digits
    }
}
