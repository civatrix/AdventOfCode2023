//
//  Day20Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day20Tests: XCTestCase {
    let day = Day20()
    
    func testDay() throws {
        let input =
"""
broadcaster -> a, b, c
%a -> b
%b -> c
%c -> inv
&inv -> a
"""
        XCTAssertEqual(day.run(input: input), "32000000")
    }
    
    func testDay2() throws {
        let input =
"""
broadcaster -> a
%a -> inv, con
&inv -> b
%b -> con
&con -> output
"""
        XCTAssertEqual(day.run(input: input), "11687500")
    }
}
