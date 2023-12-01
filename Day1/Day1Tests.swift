//
//  Day1Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day1Tests: XCTestCase {
    let day = Day1()
    
    func testDay() throws {
        let input =
"""
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
"""
        XCTAssertEqual(day.run(input: input), "142")
    }
}
