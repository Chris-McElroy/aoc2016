//
//  day09.swift
//  aoc2016
//
//  Created by Chris McElroy on 6/2/21.
//

import Foundation

func day09() {
    let input = inputLines(9)[0]
    
    func subLength(_ data: Substring) -> (v1: Int, v2: Int) {
        var i = 0
        var sum1 = 0
        var sum2 = 0
        
        while i < data.count {
            let c = data[i]
            
            if c == "(" {
                let marker = data.dropFirst(i+1).split(separator: ")")[0].split(separator: "x")
                let repeats = Int(marker[1])!
                let length = Int(marker[0])!
                
                i += marker[0].count + marker[1].count + 3 + length
                sum1 += repeats*length
                sum2 += repeats*subLength(data[i-length, i]).v2
            } else {
                i += 1
                sum1 += 1
                sum2 += 1
            }
        }
        
        return (v1: sum1, v2: sum2)
    }
    
    let (a1, a2) = subLength(Substring(input))
    
    print(a1, a2)
}
// 74532 11558231665
