//
//  Day22Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day22Tests: XCTestCase {
    let day = Day22()
    
    func testDay() throws {
        let input =
"""
1,0,1~1,2,1
0,0,2~2,0,2
0,2,3~2,2,3
0,0,4~0,2,4
2,0,5~2,2,5
0,1,6~2,1,6
1,1,8~1,1,9
"""
        XCTAssertEqual(day.run(input: input), "5")
    }
}
