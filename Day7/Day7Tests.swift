//
//  Day7Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day7Tests: XCTestCase {
    let day = Day7()
    
    func testDay() throws {
        let input =
"""
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
"""
        XCTAssertEqual(day.run(input: input), "6440")
    }
}
