//
//  Day17Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day17Tests: XCTestCase {
    let day = Day17()
    
    func testDay() throws {
        let input =
"""
2413432311323
3215453535623
3255245654254
3446585845452
4546657867536
1438598798454
4457876987766
3637877979653
4654967986887
4564679986453
1224686865563
2546548887735
4322674655533
"""
        XCTAssertEqual(day.run(input: input), "102")
    }
}
