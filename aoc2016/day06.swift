//
//  day06.swift
//  aoc2016
//
//  Created by Chris McElroy on 5/27/21.
//

import Foundation

func day06() {
    let input = inputLines(6)
    
    var counts: [[Character: Int]] = Array(repeating: [:], count: input[0].count)
    
    for line in input {
        for (i, c) in line.enumerated() {
            counts[i][c, default: 0] += 1
        }
    }
    
    let a1 = String(counts.map { $0.max(by: { $0.value < $1.value })!.key })
    let a2 = String(counts.map { $0.min(by: { $0.value < $1.value })!.key })
    
    print(a1, a2)
} // qzedlxso ucmifjae
