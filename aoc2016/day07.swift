//
//  day07.swift
//  aoc2016
//
//  Created by Chris McElroy on 5/28/21.
//

import Foundation

func day07() {
    let input = inputLines(7)
    var a1 = 0
    var a2 = 0
    
    for line in input {
        var abbaIn = false
        var abbaOut = false
        
        var abaIn: Set<[Character]> = []
        var abaOut: Set<[Character]> = []
        
        let split = line.split(separator: "[").flatMap { $0.split(separator: "]") }
        
        for (i, part) in split.enumerated() {
            for j in 0..<(part.count-3) {
                if part[j] == part[j+3] && part[j+1] == part[j+2] && part[j] != part[j+1] {
                    if i % 2 == 0 {
                        abbaOut = true
                    } else {
                        abbaIn = true
                    }
                }
            }
        }
        
        for (i, part) in split.enumerated() {
            for j in 0..<(part.count-2) {
                if part[j] == part[j+2] && part[j] != part[j+1] {
                    if i % 2 == 0 {
                        abaOut.insert([part[j], part[j+1]])
                    } else {
                        abaIn.insert([part[j+1], part[j]])
                    }
                }
            }
        }
        
        if !abbaIn && abbaOut {
            a1 += 1
        }
        
        if !abaOut.intersection(abaIn).isEmpty {
            a2 += 1
        }
    }
    
    print(a1, a2)
}
// 105 258
