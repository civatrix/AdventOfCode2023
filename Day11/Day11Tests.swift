//
//  Day11Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day11Tests: XCTestCase {
    let day = Day11()
    
    func testDay() throws {
        let input =
"""
...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....
"""
        day.expansionSize = 2
        XCTAssertEqual(day.run(input: input), "374")
    }
    func testDay2() throws {
        let input =
"""
...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....
"""
        day.expansionSize = 10
        XCTAssertEqual(day.run(input: input), "1030")
    }
    
    func testDay3() throws {
        let input =
"""
...#......
.......#..
#.........
..........
......#...
.#........
.........#
..........
.......#..
#...#.....
"""
        day.expansionSize = 100
        XCTAssertEqual(day.run(input: input), "8410")
    }
}
