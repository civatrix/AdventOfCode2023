//
//  Math.swift
//  AdventOfCode
//
//  Created by Daniel Johns on 2023-12-08.
//

import Foundation

func leastCommonMultiple(_ x: Int, _ y: Int) -> Int {
    x / greatestCommonDenominator(x, y) * y
}

func greatestCommonDenominator(_ x: Int, _ y: Int) -> Int {
    let remainder = x % y
    if remainder == 0 {
        return y
    } else {
        return greatestCommonDenominator(y, remainder)
    }
}
