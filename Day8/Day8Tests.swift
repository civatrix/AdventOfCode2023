//
//  Day8Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day8Tests: XCTestCase {
    let day = Day8()
    
    func testDay() throws {
        let input =
"""
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)
"""
        XCTAssertEqual(day.run(input: input), "6")
    }
}

