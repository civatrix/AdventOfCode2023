//
//  Day10Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day10Tests: XCTestCase {
    let day = Day10()
    
    func testDay() throws {
        let input =
"""
-L|F7
7S-7|
L|7||
-L-J|
L|-JF
"""
        XCTAssertEqual(day.run(input: input), "4")
    }
    
    func testDay2() throws {
        let input =
"""
7-F7-
.FJ|7
SJLL7
|F--J
LJ.LJ
"""
        XCTAssertEqual(day.run(input: input), "8")
    }
}
