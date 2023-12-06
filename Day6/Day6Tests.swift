//
//  Day6Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day6Tests: XCTestCase {
    let day = Day6()
    
    func testDay() throws {
        let input =
"""
Time:      7  15   30
Distance:  9  40  200
"""
        XCTAssertEqual(day.run(input: input), "71503")
    }
}
