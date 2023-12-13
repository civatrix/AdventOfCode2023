//
//  Day12Tests.swift
//  AdventOfCodeTests
//
//  Created by DanielJohns on 2022-11-09.
//

import XCTest

final class Day12Tests: XCTestCase {
    let day = Day12()
    
    func testDay() throws {
        let input =
"""
???.### 1,1,3
.??..??...?##. 1,1,3
?#?#?#?#?#?#?#? 1,3,1,6
????.#...#... 4,1,1
????.######..#####. 1,6,5
?###???????? 3,2,1
"""
        XCTAssertEqual(day.run(input: input), "525152")
    }
}
