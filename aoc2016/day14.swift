//
//  day14.swift
//  aoc2016
//
//  Created by Chris McElroy on 6/15/21.
//

import Foundation

func day14() {
    let input = inputLines(14)[0]
    var hashIndex = 0
    var checkIndex = 0
    
    var threes1: [Int: Character] = [:]
    var fives1: [Character: [Int]] = [:]
    var numKeys1 = 0
    var a1: Int = 1
    
    var threes2: [Int: Character] = [:]
    var fives2: [Character: [Int]] = [:]
    var numKeys2 = 0
    var a2: Int = 2
    
    while numKeys1 < 64 || numKeys2 < 64 {
        if hashIndex > checkIndex + 1000 {
            if let c1 = threes1[checkIndex] {
                for j in fives1[c1] ?? [] {
                    if j > checkIndex && j <= checkIndex + 1000 {
                        numKeys1 += 1
                        if numKeys1 == 64 { a1 = checkIndex }
                        break
                    }
                }
            }
            if let c2 = threes2[checkIndex] {
                for j in fives2[c2] ?? [] {
                    if j > checkIndex && j <= checkIndex + 1000 {
                        numKeys2 += 1
                        if numKeys2 == 64 { a2 = checkIndex }
                        break
                    }
                }
            }
            checkIndex += 1
        } else {
            checkNext()
        }
    }
    
    func checkNext() {
        let hash1 = MD5(of: input+String(hashIndex))
        var hash2 = hash1
        
        for _ in 0..<2016 {
            hash2 = MD5(of: hash2)
        }
        
        threes1[hashIndex] = hash1.repititions(n: 3).first
        for c in hash1.repititions(n: 5) {
            fives1[c, default: []].append(hashIndex)
        }
        
        threes2[hashIndex] = hash2.repititions(n: 3).first
        for c in hash2.repititions(n: 5) {
            fives2[c, default: []].append(hashIndex)
        }
        
        hashIndex += 1
    }
    
    print(a1, a2)
}
// 25427 22045
