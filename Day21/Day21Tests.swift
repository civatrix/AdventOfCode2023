//
//  Day21Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day21Tests: XCTestCase {
    let day = Day21()
    
    func testDay() throws {
        let input =
"""
...........
.....###.#.
.###.##..#.
..#.#...#..
....#.#....
.##..S####.
.##..#...#.
.......##..
.##.#.####.
.##..##.##.
...........
"""
        day.numberOfSteps = 6
        XCTAssertEqual(day.run(input: input), "16")
    }
}
