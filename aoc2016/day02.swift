//
//  day02.swift
//  aoc2016
//
//  Created by Chris McElroy on 5/19/21.
//

import Foundation

func day02() {
    let input = inputLines(2)
    var a1 = ""
    var a2 = ""
    let pad1 = Array(["123","456","789"].reversed())
    let pad2 = Array(["001","0234","56789","0ABC","00D"].reversed())
    var loc1 = C2(1, 1)
    var loc2 = C2(0, 2)
    
    for line in input {
        for c in line {
            if c == "D" {
                loc1.y = max(loc1.y-1, 0)
                loc2.y = max(loc2.y-1, 0 + abs(loc2.x-2))
            } else if c == "U" {
                loc1.y = min(loc1.y+1, 2)
                loc2.y = min(loc2.y+1, 4 - abs(loc2.x-2))
            } else if c == "L" {
                loc1.x = max(loc1.x-1, 0)
                loc2.x = max(loc2.x-1, 0 + abs(loc2.y-2))
            } else if c == "R" {
                loc1.x = min(loc1.x+1, 2)
                loc2.x = min(loc2.x+1, 4 - abs(loc2.y-2))
            }
        }
        a1.append(pad1[loc1.y][loc1.x])
        a2.append(pad2[loc2.y][loc2.x])
    }
    
    print(a1, a2)
}
// 76792 A7AC3
