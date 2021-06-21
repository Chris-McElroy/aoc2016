//
//  day05.swift
//  aoc2016
//
//  Created by Chris McElroy on 5/24/21.
//

import Foundation

func day05() {
    let input = inputLines(5)[0]
    
    var a1 = ""
    var a2Array = Array("________")
    var n = 1
    
    while n < 100000000 {
        let hash = MD5(of: input+String(n))

        if hash.hasPrefix("00000") {
            if a1.count < 8 {
                a1.append(hash[5])
            }
            
            let chr6 = Int(String(hash[5]), radix: 16)!
            
            if chr6 < 8 && a2Array[chr6] == "_" {
                a2Array[chr6] = hash[6]
                if !a2Array.contains("_") { break }
            }
        }
        
        n += 1
    }
    
    let a2 = String(a2Array)
    
    print(a1, a2)
}
// d4cd2ee1 f2c730e5
