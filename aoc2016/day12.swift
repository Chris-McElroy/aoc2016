//
//  day12.swift
//  aoc2016
//
//  Created by Chris McElroy on 6/11/21.
//

import Foundation

func day12() {
    let input = inputWords(12)
    
    func run(key: Int) -> Int {
        var line = 0
        var registers: [String: Int] = ["a": 0, "b": 0, "c": key, "d": 0]
        
        while line < input.count {
            let instr = input[line]
            switch instr[0] {
            case "cpy":
                if let n = Int(instr[1]) {
                    registers[instr[2]] = n
                } else {
                    registers[instr[2]] = registers[instr[1]]!
                }
                break
            case "jnz":
                if registers[instr[1]] != 0 {
                    line += Int(instr[2])! - 1
                }
                break
            case "inc":
                registers[instr[1]]! += 1
                break
            case "dec":
                registers[instr[1]]! -= 1
                break
            default: break
            }
            line += 1
        }
        
        return registers["a"]!
    }
    
    let a1 = run(key: 0)
    let a2 = run(key: 1)
    
    print(a1, a2)
}
