//
//  Day9Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day9Tests: XCTestCase {
    let day = Day9()
    
    func testDay() throws {
        let input =
"""
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45
"""
        XCTAssertEqual(day.run(input: input), "2")
    }
}
