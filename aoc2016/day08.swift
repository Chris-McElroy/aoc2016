//
//  day08.swift
//  aoc2016
//
//  Created by Chris McElroy on 5/31/21.
//

import Foundation

func day08() {
    let input = inputLines(8)
    
    var screen: [[Bool]] = Array(repeating: Array(repeating: false, count: 50), count: 6)
    
    for line in input {
        if line.hasPrefix("rect") {
            let w = Int(line.split(separator: " ")[1].split(separator: "x")[0])!
            let h = Int(line.split(separator: "x")[1])!
            for x in 0..<w {
                for y in 0..<h {
                    screen[y][x].toggle()
                }
            }
        } else if line.hasPrefix("rotate row") {
            let y = Int(line.split(separator: "=")[1].split(separator: " ")[0])!
            let rot = Int(line.split(separator: " ").last!)!
            let row = screen[y]
            for x in 0..<50 {
                screen[y][(x+rot) % 50] = row[x]
            }
        } else {
            let x = Int(line.split(separator: "=")[1].split(separator: " ")[0])!
            let rot = Int(line.split(separator: " ").last!)!
            let col = screen.map { $0[x] }
            for y in 0..<6 {
                screen[(y+rot) % 6][x] = col[y]
            }
        }
    }
    
    let a1 = screen.reduce(0, { $0 + $1.reduce(0, { $0 + $1.int }) })
    let a2 = String(screen.flatMap({ ["\n"] + $0.map({ $0 ? "#" : " "  }) }))
    
    print(a1, a2)
}
// 119 ZFHFSFOGPO
