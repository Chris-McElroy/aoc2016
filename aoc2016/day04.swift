//
//  day04.swift
//  aoc2016
//
//  Created by Chris McElroy on 5/21/21.
//

import Foundation

func day04() {
    let input = inputLines(4)
    var a1 = 0
    var a2 = 0
    
    for line in input {
        let parts = line.split(separator: "[")
        let encryption = parts[0]
        let id = Int(encryption.last(3))!
        let checksum = Array(parts[1].dropLast())
        var totals: [Character: Int] = [:]
        
        for c in encryption {
            if c.isLetter {
                totals[c, default: 0] += 1
            }
        }
        
        let sum = totals.sorted(by: { $0.value > $1.value || ($0.value == $1.value && $0.key < $1.key) }).first(5).map({ $0.key })
        if sum == checksum {
            a1 += id
            if a2 == 0 {
                let name = String(encryption.dropLast(4).map({ $0 == "-" ? " " : $0 + id }))
                if name == "northpole object storage" { a2 = id }
            }
        }
    }
    
    print(a1, a2)
}
// 185371 984
