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
RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)
"""
        XCTAssertEqual(day.run(input: input), "2")
    }
    
    func testDay2() throws {
        let input =
"""
LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)
"""
        XCTAssertEqual(day.run(input: input), "6")
    }
}

