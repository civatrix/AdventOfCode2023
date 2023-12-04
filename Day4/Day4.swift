//
//  Day4.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day4: Day {
    func run(input: String) -> String {
        let numberOfWins = input
            .lines
            .map { $0.split(separator: ":")[1].split(separator: "|") }
            .map { (Set($0[0].allDigits), Set($0[1].allDigits)) }
            .map { $0.0.intersection($0.1).count }
        
        var numberOfCards = [Int](repeating: 1, count: numberOfWins.count)
        for (index, wins) in numberOfWins.enumerated() {
            guard wins > 0 else { continue }
            for j in (index + 1 ... index + wins) {
                numberOfCards[j] += numberOfCards[index]
            }
        }
        
        return numberOfCards.sum.description
    }
}
