//
//  Day15.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day15: Day {
    func run(input: String) -> String {
        return input.split(separator: ",").map { hash(String($0)) }.sum.description
    }
    
    func hash(_ input: String) -> Int {
        input.reduce(0) { partialResult, character in
            ((partialResult + Int(character.asciiValue!)) * 17) % 256
        }
    }
}
