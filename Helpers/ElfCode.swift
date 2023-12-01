//
//  ElfCode.swift
//  AdventOfCode
//
//  Created by DanielJohns on 2022-12-10.
//

import Foundation
import RegexBuilder

class ElfCode {
    static let regex = Regex {
        Capture {
            One(.word)
            One(.word)
            One(.word)
        }
        " "
        Capture {
            Optionally {
                "-"
            }
            OneOrMore(.word)
        }
        Optionally {
            " "
            Capture {
                Optionally {
                    "-"
                }
                OneOrMore(.word)
            }
        }
    }
    
    enum Instruction {
        case set(Substring, Substring), add(Substring, Substring), multiply(Substring, Substring), modulo(Substring, Substring), jumpGreaterZero(Substring, Substring), recover(Substring), send(Substring)
        
        init(_ input: String) {
            guard let match = input.wholeMatch(of: regex)?.output else {
                fatalError("Unknown instruction: \(input)")
            }
            let instruction = match.1
            switch instruction {
            case "snd": self = .send(match.2)
            case "set": self = .set(match.2, match.3!)
            case "add": self = .add(match.2, match.3!)
            case "mul": self = .multiply(match.2, match.3!)
            case "mod": self = .modulo(match.2, match.3!)
            case "rcv": self = .recover(match.2)
            case "jgz": self = .jumpGreaterZero(match.2, match.3!)
            default:
                fatalError("Unknown instruction: \(input)")
            }
        }
    }
    
    var registers: [Substring: Int] = [:]
    var instructions: [Instruction]
    var instructionPointer = 0
    var input = [Int]()
    var output: Int?
    var timesSent = 0
    
    init(_ lines: [String]) {
        instructions = lines.map(Instruction.init)
    }
    
    func step() -> Bool {
        output = nil
        let instruction = instructions[instructionPointer]
        switch instruction {
        case let .set(lhs, rhs):
            if let number = Int(rhs) {
                registers[lhs] = number
            } else {
                registers[lhs] = registers[rhs]!
            }
        case let .add(lhs, rhs):
            registers[lhs, default: 0] += Int(rhs) ?? registers[rhs]!
        case let .multiply(lhs, rhs):
            registers[lhs, default: 0] *= Int(rhs) ?? registers[rhs]!
        case let .modulo(lhs, rhs):
            registers[lhs, default: 0] %= Int(rhs) ?? registers[rhs]!
        case let .jumpGreaterZero(register, value):
            if (Int(register) ?? registers[register])! > 0, let offset = Int(value) ?? registers[value] {
                instructionPointer += offset - 1
            }
        case let .send(register):
            output = Int(register) ?? registers[register]
            timesSent += 1
        case let .recover(register):
            if let next = input.first {
                registers[register] = next
                input.removeFirst()
            } else {
                return false
            }
        }
        
        instructionPointer += 1
        return instructionPointer < instructions.count
    }
}
