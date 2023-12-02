//
//  Day2.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation
import RegexBuilder

final class Day2: Day {
    let regex = Regex {
        TryCapture(OneOrMore(.digit)) { Int($0) }
        " "
        Capture {
            ChoiceOf {
                "blue"
                "red"
                "green"
            }
        }
    }
    
    func run(input: String) -> String {
        var matchingGames: [Int] = []
        for line in input.lines {
            let matches = line.matches(of: regex).map { $0.output }
            
            var red = 0
            var blue = 0
            var green = 0
            
            for match in matches {
                switch match.2 {
                case "red":
                    red = max(match.1, red)
                case "blue":
                    blue = max(match.1, blue)
                case "green":
                    green = max(match.1, green)
                default:
                    fatalError("Unknown colour \(match.0)")
                }
            }
            
            if red <= 12 && green <= 13 && blue <= 14 {
                matchingGames.append(line.allDigits[0])
            }
        }
        
        return matchingGames.sum.description
    }
}
