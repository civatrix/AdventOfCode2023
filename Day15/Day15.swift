//
//  Day15.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-11-09.
//

import Foundation

final class Day15: Day {
    struct Lens {
        let label: String
        let focalLength: Int
    }
    
    func run(input: String) -> String {
        var boxes = [[Lens]](repeating: [], count: 256)
        input.split(separator: ",").forEach { instruction in
            if let match = instruction.wholeMatch(of: /(.+)=(\d)/)?.output {
                let label = String(match.1)
                let boxNumber = hash(label)
                let lens = Lens(label: label, focalLength: Int(match.2)!)
                if let existingLens = boxes[boxNumber].firstIndex(where: { $0.label == label }) {
                    boxes[boxNumber][existingLens] = lens
                } else {
                    boxes[boxNumber].append(lens)
                }
            } else if let match = instruction.wholeMatch(of: /(.+)-/) {
                let label = String(match.1)
                let boxNumber = hash(label)
                if let existingLens = boxes[boxNumber].firstIndex(where: { $0.label == label }) {
                    boxes[boxNumber].remove(at: existingLens)
                }
            } else {
                fatalError("Couldn't match instruction \(instruction)")
            }
        }
        
        return boxes.enumerated().map { (index, box) -> Int in
            box.enumerated().map { (index + 1) * ($0.offset + 1) * $0.element.focalLength }.sum
        }
        .sum
        .description
    }
    
    var cache = [String: Int]()
    func hash(_ input: String) -> Int {
        if let hit = cache[input] {
            return hit
        }
        
        let result = input.reduce(0) { partialResult, character in
            ((partialResult + Int(character.asciiValue!)) * 17) % 256
        }
        cache[input] = result
        return result
    }
}
