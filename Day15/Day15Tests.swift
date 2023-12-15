//
//  Day15Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day15Tests: XCTestCase {
    let day = Day15()
    
    func testDay() throws {
        let input =
"""
rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
"""
        XCTAssertEqual(day.run(input: input), "145")
    }
    
    func testHash() {
        XCTAssertEqual(day.hash("HASH"), 52)
    }
}
