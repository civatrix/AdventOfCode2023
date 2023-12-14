//
//  Day14Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day14Tests: XCTestCase {
    let day = Day14()
    
    func testDay() throws {
        let input =
"""
O....#....
O.OO#....#
.....##...
OO.#O....O
.O.....O#.
O.#..O.#.#
..O..#O..O
.......O..
#....###..
#OO..#....
"""
        XCTAssertEqual(day.run(input: input), "136")
    }
}
