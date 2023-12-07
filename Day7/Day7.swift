//
//  Day7.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day7: Day {
    struct CamelHand: Comparable {
        static let cardOrder: [Character] = ["A", "K", "Q", "T", "9", "8", "7", "6", "5", "4", "3", "2", "J"]
        static let handOrder = [
            [5], // 5 of a kind
            [1,4], // 4 of a kind
            [2,3], // Full house
            [1,1,3], // 3 of a kind
            [1,2,2], // 2 pair
            [1,1,1,2], // 1 pair
            [1,1,1,1,1] // High card
        ]
        
        static func < (lhs: CamelHand, rhs: CamelHand) -> Bool {
            if lhs.rank > rhs.rank {
                return true
            } else if lhs.rank < rhs.rank {
                return false
            } else {
                for (l, r) in zip(lhs.cards, rhs.cards) where l != r {
                    return cardOrder.firstIndex(of: l)! > cardOrder.firstIndex(of: r)!
                }
                
                return false
            }
        }
        
        let cards: Substring
        let bid: Int
        let rank: Int
        
        init(_ line: String) {
            cards = line.split(separator: " ")[0]
            bid = Int(line.split(separator: " ")[1])!
            
            if cards == "JJJJJ" {
                rank = Self.handOrder.startIndex
                return
            }
            
            var cardCounts = cards.reduce(into: [Character: Int]()) { $0[$1, default: 0] += 1 }
            let jokers = cardCounts["J", default: 0]
            cardCounts.removeValue(forKey: "J")
            var occurrences = cardCounts.values.sorted()
            occurrences[occurrences.endIndex - 1] += jokers
            rank = Self.handOrder.firstIndex(of: occurrences)!
        }
    }
    
    func run(input: String) -> String {
        let hands = input.lines
            .map { CamelHand($0) }
            .sorted()
        
        return zip(hands, hands.indices).map { $0.bid * ($1 + 1) }.sum.description
    }
}
